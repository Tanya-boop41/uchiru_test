class ClassStudentsController < ApplicationController
  def index
    data = Student.where(classroom_id: params[:class_id], school_id: params[:school_id])

    if data.any?
      render_success(data:, status: :ok, serializer: StudentSerializer)
    else
      render_not_found
    end
  end
end
