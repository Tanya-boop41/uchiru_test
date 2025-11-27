class ClassesController < ApplicationController
  def index
    school = School.find_by(id: params[:school_id])
    return render_success(data: {}, status: :no_content) unless school

    data = school.classrooms
    puts data.first
    render_success(data:, status: :ok, serializer: ClassesSerializer)
  end
end
