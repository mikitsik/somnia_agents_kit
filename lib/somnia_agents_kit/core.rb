# frozen_string_literal: true

module SomniaAgentsKit
  module Core
    module_function

    def create_request!(agent_kind:, payload:)
      AgentRequest.create!(
        agent_kind:,
        status: 'draft',
        payload:,
        response: {}
      )
    end
  end
end
