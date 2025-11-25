class ClassStudentsController < ApplicationController
  def index
    classroom = Classroom.find_by(id: params[:class_id], school_id: params[:school_id])
    return render json: { data: [] }, status: :ok unless classroom

    data = classroom.students.map(&:as_openapi_json)
    render json: { data: data }, status: :ok
  end
end
