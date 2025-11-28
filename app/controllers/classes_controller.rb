class ClassesController < ApplicationController
  def index
    data = Classroom.includes(:students).where(school_id: params[:school_id])
    raise ActiveRecord::RecordNotFound if data.empty?

    render_success(data:, status: :ok, serializer: ClassesSerializer)
  end
end
