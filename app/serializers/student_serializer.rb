class StudentSerializer
  include JSONAPI::Serializer

  attributes :id, :first_name, :last_name, :surname, :school_id

  attribute :class_id do |object|
    object.classroom_id
  end

  attribute :token, if: Proc.new { |user, params|
      params && params[:token].present?
    } do |_user, params|
    params[:token]
  end
end