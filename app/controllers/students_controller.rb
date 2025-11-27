class StudentsController < ApplicationController
  before_action :set_student, only: :destroy
  before_action :authorize_destroy, only: :destroy

  def create
    student = Student.new(student_params)

    if student.save
      student.classroom.increment!(:students_count)
      response.set_header('X-Auth-Token', AuthTokenService.generate(student.id))

      render json: student, serializer: StudentSerializer, status: :created
    else
      render json: { error: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    head :no_content
  end

  private

  def student_params
    permitted = params.require(:student).permit(:first_name, :last_name, :surname, :school_id, :class_id)
    permitted[:classroom_id] = permitted.delete(:class_id) if permitted[:class_id]
  end

  def set_student
    @student = Student.find_by(id: params[:user_id])
    render json: { error: 'not found' }, status: :bad_request unless @student
  end

  def authorize_destroy
  require_auth_for_user!(@student&.id)
  end
end
