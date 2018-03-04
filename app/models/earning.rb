# frozen_string_literal: true

class Earning < ApplicationRecord
  belongs_to :stock
  belongs_to :year

  validates :value, presence: true
  validates :stock, uniqueness: { scope: :year, message: 'already has an earning record for that year' }
end
