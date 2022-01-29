# frozen_string_literal: true

class DeleteColumnFromJob < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :is_found_worker, :boolean
  end
end
