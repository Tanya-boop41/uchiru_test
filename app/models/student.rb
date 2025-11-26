class Student < ApplicationRecord
  belongs_to :school
  belongs_to :classroom, counter_cache: true

  validates :first_name, :last_name, :surname, :class_id, :school_id, presence: true

  validate :class_belongs_to_school

  def class_belongs_to_school
    return if classroom&.school_id == school_id

    errors.add(:class_id, "does not belong to school with id #{school_id}")
  end

  def as_openapi_json
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      surname: surname,
      class_id: classroom_id,
      school_id: school_id
    }
  end
end
