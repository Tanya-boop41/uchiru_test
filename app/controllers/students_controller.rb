class StudentsController < ApplicationController
  include AuthorizeRequest

  skip_before_action :authorize_request, only: [ :create ]
  before_action :set_student, only: [ :destroy ]

  def create
    data, token = Students::CreateService.call(student_params:)
    render_success(data:, status: :created, serializer: StudentSerializer, params: { token: })
  end

  def destroy
    Rails.logger.info("Destroying student #{@student.id}")
    @student.destroy
    render_success(data: {}, status: :no_content)
  end

  private

  def student_params
    permitted = params.require(:student).permit(:first_name, :last_name, :surname, :school_id, :class_id)
    permitted[:classroom_id] = permitted.delete(:class_id) if permitted[:class_id]
    permitted
  end

  def set_student
    @student = Student.find(params[:user_id]) # <- используем :user_id, потому что такой параметр в маршруте
  end
end
