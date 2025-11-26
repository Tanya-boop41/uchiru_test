class Student < ApplicationRecord
  belongs_to :school
  belongs_to :classroom, counter_cache: true

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
