class ClassStudentsController < ApplicationController
  def index
    data = Student.where(classroom_id: params[:class_id], school_id: params[:school_id])
    raise ActiveRecord::RecordNotFound if data.empty?

    render_success(data:, status: :ok, serializer: StudentSerializer)
  end
end
