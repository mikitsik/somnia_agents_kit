# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SomniaAgentsKit::LlmInference do
  describe '.call' do
    subject(:request) do
      described_class.call(
        prompt: 'Analyze this input and return JSON.',
        input: input,
        schema: schema
      )
    end

    let(:input) do
      {
        facts: %w[one two]
      }
    end

    let(:schema) do
      {
        score: 'integer',
        summary: 'string'
      }
    end

    it 'creates LLM Inference agent request' do
      expect(request.agent_kind).to eq('llm_inference')
    end

    it 'uses LLM Inference agent id' do
      expect(request.agent_id).to eq('12847293847561029384')
    end

    it 'stores prompt' do
      expect(request.payload['prompt']).to eq(
        'Analyze this input and return JSON.'
      )
    end

    it 'stores input' do
      expect(request.payload['input']).to eq(
        'facts' => %w[one two]
      )
    end

    it 'stores schema' do
      expect(request.payload['schema']).to eq(
        'score' => 'integer',
        'summary' => 'string'
      )
    end

    it 'stores purpose' do
      expect(request.payload['purpose']).to eq(
        'Run LLM inference and return structured output.'
      )
    end
  end
end
