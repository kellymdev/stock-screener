# frozen_string_literal: true

class Dividend < ApplicationRecord
  belongs_to :stock
  belongs_to :year

  validates :value, presence: true, numericality: true

  scope :by_year, -> { joins(:year).order("years.year_number") }
  scope :for_year, ->(year) { where(year: Year.find_by(year_number: year)) }
end
