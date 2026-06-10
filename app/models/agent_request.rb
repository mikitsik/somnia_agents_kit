# frozen_string_literal: true

class AgentRequest < ApplicationRecord
  AGENT_IDS = {
    'json_api_request' => '13174292974160097713',
    'llm_parse_website' => '12875401142070969085',
    'llm_inference' => '12847293847561029384'
  }.freeze

  STATUSES = %w[
    draft
    requested
    processing
    completed
    failed
  ].freeze

  validates :agent_kind, presence: true, inclusion: { in: AGENT_IDS.keys }
  validates :agent_id, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :payload, presence: true

  before_validation :set_agent_id

  def completed?
    status == 'completed'
  end

  def failed?
    status == 'failed'
  end

  private

  def set_agent_id
    self.agent_id ||= AGENT_IDS[agent_kind]
  end
end
