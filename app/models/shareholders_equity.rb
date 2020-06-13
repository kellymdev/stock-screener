# frozen_string_literal: true

class ShareholdersEquity < ApplicationRecord
  belongs_to :stock
  belongs_to :year

  validates :value, presence: true, numericality: true

  validates :stock, uniqueness: { scope: :year, message: 'already has a shareholders equity record for that year' }

  scope :by_year, -> { joins(:year).order("years.year_number") }
  scope :for_year, ->(year) { where(year: Year.find_by(year_number: year)) }
end
