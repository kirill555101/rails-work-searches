# frozen_string_literal: true

class AddNewColumnToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_reference :accounts, :user
    add_reference :accounts, :organisation
  end
end
