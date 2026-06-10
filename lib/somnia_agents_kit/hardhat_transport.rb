# frozen_string_literal: true

require 'json'
require 'open3'
require 'pathname'

module SomniaAgentsKit
  class HardhatTransport
    DEFAULT_NETWORK = 'somniaShannon'

    def initialize(
      contracts_path: default_contracts_path,
      network: DEFAULT_NETWORK
    )
      @contracts_path = contracts_path
      @network = network
    end

    def call(agent_request)
      stdout, stderr, status = run_hardhat(agent_request)

      raise Error, error_message(stdout, stderr) unless status.success?

      parse_stdout(stdout)
    end

    private

    attr_reader :contracts_path, :network

    def run_hardhat(agent_request)
      Open3.capture3(
        env_for(agent_request),
        'npx',
        'hardhat',
        'run',
        'scripts/request_agent.js',
        '--network',
        network,
        chdir: contracts_path.to_s
      )
    end

    def parse_stdout(stdout)
      JSON.parse(stdout.lines.last, symbolize_names: true)
    end

    def default_contracts_path
      return Rails.root.join('contracts') if defined?(Rails)

      Pathname.new(Dir.pwd).join('contracts')
    end

    def env_for(agent_request)
      {
        'SOMNIA_AGENT_PLATFORM_ADDRESS' => fetch_env('SOMNIA_AGENT_PLATFORM_ADDRESS'),
        'AGENT_ID' => agent_request.agent_id,
        'CALLBACK_ADDRESS' => fetch_env('SOMNIA_RAW_CALLBACK_RECEIVER_ADDRESS'),
        'CALLBACK_SELECTOR' => '0x00000000',
        'AGENT_FUNCTION_SIGNATURE' => function_signature_for(agent_request),
        'AGENT_ARGS_JSON' => JSON.generate(args_for(agent_request))
      }
    end

    def function_signature_for(agent_request)
      case agent_request.agent_kind
      when 'json_api_request'
        'function fetchString(string url,string selector) returns (string result)'
      else
        raise ArgumentError, "Unsupported agent kind: #{agent_request.agent_kind}"
      end
    end

    def args_for(agent_request)
      case agent_request.agent_kind
      when 'json_api_request'
        json_api_args(agent_request)
      else
        raise ArgumentError, "Unsupported agent kind: #{agent_request.agent_kind}"
      end
    end

    def json_api_args(agent_request)
      [
        agent_request.payload.fetch('url'),
        agent_request.payload.fetch('selector')
      ]
    end

    def fetch_env(name)
      ENV.fetch(name) do
        raise Error, "#{name} is missing"
      end
    end

    def error_message(stdout, stderr)
      [stderr, stdout].reject { |value| value.to_s.empty? }.join("\n")
    end

    class Error < StandardError; end
  end
end
