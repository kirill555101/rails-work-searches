# frozen_string_literal: true

class AddNewColumnToMiddle < ActiveRecord::Migration[5.1]
  def change
    add_reference :middles, :user
    add_reference :middles, :job
  end
end
