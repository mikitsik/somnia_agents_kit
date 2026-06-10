# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AgentRequest do
  subject(:agent_request) { build_request }

  it 'is valid with valid attributes' do
    expect(agent_request).to be_valid
  end

  it 'sets agent id from agent kind' do
    agent_request.valid?

    expect(agent_request.agent_id).to eq('13174292974160097713')
  end

  it 'allows empty response before callback is received' do
    agent_request.response = {}

    expect(agent_request).to be_valid
  end

  it 'rejects unsupported agent kind' do
    agent_request.agent_kind = 'unknown_agent'

    expect(agent_request).not_to be_valid
  end

  it 'adds an error for unsupported agent kind' do
    agent_request.agent_kind = 'unknown_agent'
    agent_request.valid?

    expect(agent_request.errors[:agent_kind]).to be_present
  end

  it 'rejects unsupported status' do
    agent_request.status = 'unknown_status'

    expect(agent_request).not_to be_valid
  end

  it 'adds an error for unsupported status' do
    agent_request.status = 'unknown_status'
    agent_request.valid?

    expect(agent_request.errors[:status]).to be_present
  end

  it 'requires payload' do
    agent_request.payload = {}

    expect(agent_request).not_to be_valid
  end

  it 'adds an error for missing payload' do
    agent_request.payload = {}
    agent_request.valid?

    expect(agent_request.errors[:payload]).to be_present
  end

  it 'knows when completed' do
    agent_request.status = 'completed'

    expect(agent_request).to be_completed
  end

  it 'knows when failed' do
    agent_request.status = 'failed'

    expect(agent_request).to be_failed
  end

  it 'sets JSON API Request agent id' do
    expect(agent_id_for('json_api_request')).to eq('13174292974160097713')
  end

  it 'sets LLM Parse Website agent id' do
    expect(agent_id_for('llm_parse_website')).to eq('12875401142070969085')
  end

  it 'sets LLM Inference agent id' do
    expect(agent_id_for('llm_inference')).to eq('12847293847561029384')
  end

  def build_request(agent_kind: 'json_api_request')
    described_class.new(
      agent_kind:,
      status: 'draft',
      payload: { url: 'https://example.com/api/data', selector: 'title' },
      response: {}
    )
  end

  def agent_id_for(agent_kind)
    request = build_request(agent_kind:)
    request.valid?
    request.agent_id
  end
end
