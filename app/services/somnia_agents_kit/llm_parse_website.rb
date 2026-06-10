# frozen_string_literal: true

module SomniaAgentsKit
  class LlmParseWebsite
    def self.call(url:, schema:)
      Core.create_request!(
        agent_kind: 'llm_parse_website',
        payload: {
          url:,
          schema:,
          purpose: 'Parse a website and return structured data.'
        }
      )
    end
  end
end
