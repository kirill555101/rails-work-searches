# frozen_string_literal: true

class Organisation < ApplicationRecord
  has_many :accounts
  has_many :jobs
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :website_url, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :password, presence: true, length: { maximum: 50 }
  VALID_PHONE_REGEX = /\A[+-]?\d+?(\.\d+)?\Z/.freeze
  validates :phone, presence: true, length: { maximum: 11 }, format: { with: VALID_PHONE_REGEX }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
end
