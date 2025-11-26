class Classroom < ApplicationRecord
  belongs_to :school, optional: false
  has_many :students, dependent: :destroy
end
