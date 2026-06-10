# frozen_string_literal: true

module SomniaAgentsKit
  class JsonApiRequest
    def self.call(url:, selector:)
      Core.create_request!(
        agent_kind: 'json_api_request',
        payload: {
          url:,
          selector:,
          purpose: 'Fetch a value from a public JSON API.'
        }
      )
    end
  end
end
