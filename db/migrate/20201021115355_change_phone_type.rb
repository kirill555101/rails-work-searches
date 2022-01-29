# frozen_string_literal: true

class ChangePhoneType < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :phone, :string
  end
end
