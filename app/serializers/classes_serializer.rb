class ClassesSerializer
  include JSONAPI::Serializer

  attributes :id, :number, :letter

  attributes :students_count do |object|
    object.students.size
  end
end
