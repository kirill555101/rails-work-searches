# frozen_string_literal: true

class ChangeDefaultToSession < ActiveRecord::Migration[5.1]
  def change
    change_column :accounts, :session_id, :string, default: '0'
  end
end
