# frozen_string_literal: true

class CreateMiddles < ActiveRecord::Migration[5.1]
  def change
    create_table :middles do |t|
      t.text :summary

      t.timestamps
    end
  end
end
