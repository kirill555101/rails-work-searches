# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :middles
  belongs_to :organisation
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :need_to_do, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :description, presence: true, uniqueness: true
end
