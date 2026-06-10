# frozen_string_literal: true

module SomniaAgentsKit
  module AgentIds
    IDS = {
      'json_api_request' => '13174292974160097713',
      'llm_parse_website' => '12875401142070969085',
      'llm_inference' => '12847293847561029384'
    }.freeze

    module_function

    def fetch(agent_kind)
      IDS.fetch(agent_kind)
    end

    def valid?(agent_kind)
      IDS.key?(agent_kind)
    end

    def keys
      IDS.keys
    end
  end
end
