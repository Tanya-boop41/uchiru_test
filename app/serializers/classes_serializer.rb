class ClassesSerializer
  include JSONAPI::Serializer

  attributes :id, :number, :letter, :students_count
end