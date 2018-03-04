# frozen_string_literal: true

class SharePrice < ApplicationRecord
  belongs_to :stock
  belongs_to :year

  validates :stock, uniqueness: { scope: :year, message: 'already has a price for that year' }
  validates :high_value, presence: true
  validates :low_value, presence: true
end
