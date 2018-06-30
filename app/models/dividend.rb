# frozen_string_literal: true

class Dividend < ApplicationRecord
  belongs_to :stock
  belongs_to :year

  validates :value, presence: true, numericality: true

  scope :for_year, ->(year) { where(year: Year.find_by(year_number: year)) }
end
