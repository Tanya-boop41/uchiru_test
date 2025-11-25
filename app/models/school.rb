class School < ApplicationRecord
	has_many :classrooms, dependent: :destroy
 	has_many :students, through: :classrooms
end
