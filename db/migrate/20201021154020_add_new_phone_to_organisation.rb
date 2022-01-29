# frozen_string_literal: true

class AddNewPhoneToOrganisation < ActiveRecord::Migration[5.1]
  def change
    add_column :organisations, :phone, :string
  end
end
