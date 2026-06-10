# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SomniaAgentsKit::LlmParseWebsite do
  describe '.call' do
    subject(:request) do
      described_class.call(
        url: 'https://example.com/article',
        schema: schema
      )
    end

    let(:schema) do
      {
        title: 'string',
        summary: 'string',
        pain_points: 'array'
      }
    end

    it 'creates LLM Parse Website agent request' do
      expect(request.agent_kind).to eq('llm_parse_website')
    end

    it 'uses LLM Parse Website agent id' do
      expect(request.agent_id).to eq('12875401142070969085')
    end

    it 'stores target URL' do
      expect(request.payload['url']).to eq('https://example.com/article')
    end

    it 'stores schema' do
      expect(request.payload['schema']).to eq(
        'title' => 'string',
        'summary' => 'string',
        'pain_points' => 'array'
      )
    end

    it 'stores purpose' do
      expect(request.payload['purpose']).to eq(
        'Parse a website and return structured data.'
      )
    end
  end
end
