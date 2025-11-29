class ClassesController < ApplicationController
  def index
    data = Classroom.includes(:students).where(school_id: params[:school_id])
    if data.any?
      render_success(data:, status: :ok, serializer: ClassesSerializer)
    else
      render_not_found
    end
  end
end
