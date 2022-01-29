# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :session_id

      t.timestamps
    end
  end
end
