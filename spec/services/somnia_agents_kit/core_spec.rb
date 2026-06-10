# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SomniaAgentsKit::Core do
  describe '.create_request!' do
    subject(:request) do
      described_class.create_request!(
        agent_kind: 'json_api_request',
        payload: payload
      )
    end

    let(:payload) do
      {
        url: 'https://example.com/data.json',
        selector: 'title'
      }
    end

    it 'creates agent request' do
      expect { request }.to change(AgentRequest, :count).by(1)
    end

    it 'sets request status to draft' do
      expect(request.status).to eq('draft')
    end

    it 'sets agent kind' do
      expect(request.agent_kind).to eq('json_api_request')
    end

    it 'sets agent id from agent kind' do
      expect(request.agent_id).to eq('13174292974160097713')
    end

    it 'stores payload' do
      expect(request.payload).to include(
        'url' => 'https://example.com/data.json',
        'selector' => 'title'
      )
    end

    it 'sets empty response' do
      expect(request.response).to eq({})
    end
  end
end
