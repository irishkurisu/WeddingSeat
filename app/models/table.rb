class Table < ApplicationRecord
  has_many :guests
  validates :name, presence: true
end
