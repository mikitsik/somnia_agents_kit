# frozen_string_literal: true

module SomniaAgentsKit
  class RequestExecutor
    def initialize(agent_request, transport: NullTransport.new)
      @agent_request = agent_request
      @transport = transport
    end

    def call
      ensure_draft_request!

      result = transport.call(agent_request)

      agent_request.update!(
        status: 'requested',
        request_id: result.fetch(:request_id),
        request_tx_hash: result.fetch(:tx_hash)
      )

      agent_request
    end

    private

    attr_reader :agent_request, :transport

    def ensure_draft_request!
      return if agent_request.status == 'draft'

      raise ArgumentError, 'AgentRequest must be draft'
    end

    class NullTransport
      def call(_agent_request)
        raise NotImplementedError, 'Configure a real Somnia transport'
      end
    end
  end
end
