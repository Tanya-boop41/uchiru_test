class ClassStudentsController < ApplicationController
  def index
    data = Classroom.find_by!(id: params[:class_id], school_id: params[:school_id]).students

    render_success(data:, status: :ok, serializer: StudentSerializer)
  end
end