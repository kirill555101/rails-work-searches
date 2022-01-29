# frozen_string_literal: true

class AddNewColumnToJob < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :organisation
  end
end
