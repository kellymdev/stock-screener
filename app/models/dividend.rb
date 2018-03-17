# frozen_string_literal: true

class Dividend < ApplicationRecord
  belongs_to :stock
  belongs_to :year

  validates :value, presence: true, numericality: true
end
