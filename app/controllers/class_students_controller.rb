class ClassStudentsController < ApplicationController
  def index
    classroom = Classroom.find_by(id: params[:class_id], school_id: params[:school_id])
    return render json: { data: [] }, status: :ok unless classroom

    render json: {
      data: classroom.students
    }, each_serializer: StudentSerializer, status: :ok
  end
end
