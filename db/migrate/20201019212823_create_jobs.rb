# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :name
      t.text :description
      t.string :need_to_do
      t.boolean :is_found_worker

      t.timestamps
    end
  end
end
