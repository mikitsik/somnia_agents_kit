# frozen_string_literal: true

class CreateAgentRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :agent_requests do |t|
      t.string :agent_kind, null: false
      t.string :agent_id, null: false
      t.string :status, null: false, default: 'draft'

      t.string :request_id
      t.string :request_tx_hash
      t.string :callback_tx_hash

      t.jsonb :payload, null: false, default: {}
      t.jsonb :response, null: false, default: {}
      t.text :error_message

      t.timestamps
    end

    add_index :agent_requests, :agent_kind
    add_index :agent_requests, :agent_id
    add_index :agent_requests, :status
    add_index :agent_requests, :request_id, unique: true
    add_index :agent_requests, :request_tx_hash
  end
end
