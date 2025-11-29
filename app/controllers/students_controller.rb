class StudentsController < ApplicationController
  include AuthorizeRequest

  skip_before_action :authorize_request, only: [ :create ]

  def create
    data, token = Students::CreateService.call(student_params:)
    render_success(data:, status: :created, serializer: StudentSerializer, params: { token: })
  end

  def destroy
    student = Student.find(params[:user_id])

    unless student.id == @student.id
      return render_bad_request
    end

    student.destroy
    render_success(data: {}, status: :no_content)
  end

  private

  def student_params
    permitted = params.require(:student).permit(:first_name, :last_name, :surname, :school_id, :class_id)
    permitted[:classroom_id] = permitted.delete(:class_id) if permitted[:class_id]
    permitted
  end
end
