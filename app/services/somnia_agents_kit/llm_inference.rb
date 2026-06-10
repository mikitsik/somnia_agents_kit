# frozen_string_literal: true

module SomniaAgentsKit
  class LlmInference
    def self.call(prompt:, input: {}, schema: {})
      Core.create_request!(
        agent_kind: 'llm_inference',
        payload: {
          prompt:,
          input:,
          schema:,
          purpose: 'Run LLM inference and return structured output.'
        }
      )
    end
  end
end
