# frozen_string_literal: true

class Account < ApplicationRecord
  # belongs_to :user
  # belongs_to :organisation
  validates :session_id, presence: true, uniqueness: true
end
