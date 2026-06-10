# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SomniaAgentsKit::RequestExecutor do
  subject(:executor) do
    described_class.new(agent_request, transport:)
  end

  let(:transport) do
    instance_double(SomniaAgentsKit::RequestExecutor::NullTransport)
  end

  let(:transport_result) do
    {
      request_id: '12345',
      tx_hash: '0xabc123'
    }
  end

  let(:agent_request) do
    AgentRequest.create!(
      agent_kind: 'json_api_request',
      status: 'draft',
      payload: {
        url: 'https://example.com/data.json',
        selector: 'title'
      },
      response: {}
    )
  end

  before do
    allow(transport).to receive(:call).and_return(transport_result)
  end

  it 'calls configured transport' do
    executor.call

    expect(transport).to have_received(:call).with(agent_request)
  end

  it 'marks request as requested' do
    executor.call

    expect(agent_request.reload.status).to eq('requested')
  end

  it 'stores Somnia request id' do
    executor.call

    expect(agent_request.reload.request_id).to eq('12345')
  end

  it 'stores request transaction hash' do
    executor.call

    expect(agent_request.reload.request_tx_hash).to eq('0xabc123')
  end

  it 'returns updated agent request' do
    expect(executor.call).to eq(agent_request)
  end

  it 'rejects non-draft requests' do
    agent_request.update!(status: 'requested')

    expect { executor.call }.to raise_error(
      ArgumentError,
      'AgentRequest must be draft'
    )
  end
end
