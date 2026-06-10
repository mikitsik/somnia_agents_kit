# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SomniaAgentsKit::JsonApiRequest do
  describe '.call' do
    subject(:request) do
      described_class.call(
        url: 'https://example.com/data.json',
        selector: 'items.0.title'
      )
    end

    it 'creates JSON API agent request' do
      expect(request.agent_kind).to eq('json_api_request')
    end

    it 'uses JSON API Request agent id' do
      expect(request.agent_id).to eq('13174292974160097713')
    end

    it 'stores target URL' do
      expect(request.payload['url']).to eq('https://example.com/data.json')
    end

    it 'stores selector' do
      expect(request.payload['selector']).to eq('items.0.title')
    end

    it 'stores purpose' do
      expect(request.payload['purpose']).to eq(
        'Fetch a value from a public JSON API.'
      )
    end
  end
end
