# frozen_string_literal: true

class AgentRequest < ApplicationRecord
  STATUSES = %w[
    draft
    requested
    processing
    completed
    failed
  ].freeze

  validates :agent_kind,
            presence: true,
            inclusion: { in: SomniaAgentsKit::AgentIds.keys }

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
    return if agent_kind.blank?
    return unless SomniaAgentsKit::AgentIds.valid?(agent_kind)

    self.agent_id ||= SomniaAgentsKit::AgentIds.fetch(agent_kind)
  end
end
