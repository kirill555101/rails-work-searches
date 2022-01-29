# frozen_string_literal: true

class CreateOrganisations < ActiveRecord::Migration[5.1]
  def change
    create_table :organisations do |t|
      t.string :name
      t.text :description
      t.string :website_url
      t.string :password

      t.timestamps
    end
  end
end
