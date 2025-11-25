class Classroom < ApplicationRecord
  belongs_to :school, counter_cache: true, optional: false
  has_many :students, dependent: :destroy
end
