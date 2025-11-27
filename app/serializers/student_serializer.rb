class StudentSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :surname, :class_id, :school_id
  attribute :id, if: :show_id?

  def class_id
    object.classroom_id
  end

  def show_id?
    instance_options[:show_id] == true
  end
end
