class Pool < ApplicationRecord
  belongs_to :user
  has_many :forecasts
end
