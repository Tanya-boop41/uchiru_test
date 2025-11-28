class ClassesController < ApplicationController
  def index
    data = School.find(params[:school_id]).classrooms

    render_success(data:, status: :ok, serializer: ClassesSerializer)
  end
end