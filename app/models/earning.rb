# frozen_string_literal: true

class Earning < ApplicationRecord
  belongs_to :stock
  belongs_to :year

  validates :value, presence: true, numericality: true
  validates :stock, uniqueness: { scope: :year, message: 'already has an earning record for that year' }

  scope :for_year, ->(year) { where(year: Year.find_by(year_number: year)) }
end
