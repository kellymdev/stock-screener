# frozen_string_literal: true

class SharePrice < ApplicationRecord
  belongs_to :stock
  belongs_to :year

  validates :stock, uniqueness: { scope: :year, message: 'already has a price for that year' }
  validates :high_value, presence: true, numericality: true
  validates :low_value, presence: true, numericality: true

  validate :high_value_greater_than_low_value

  private

  def high_value_greater_than_low_value
    return true if high_value.present? && low_value.present? && high_value >= low_value

    errors.add(:high_value, 'must be greater than or equal to low value')
  end
end
