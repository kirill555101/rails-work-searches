# frozen_string_literal: true

class Middle < ApplicationRecord
  belongs_to :user
  belongs_to :job
  validates :summary, presence: true, uniqueness: true
end
