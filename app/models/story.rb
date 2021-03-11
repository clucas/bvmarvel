class Story < ApplicationRecord
  has_one :roster, dependent: :delete
  has_many :characters, through: :roster
end
