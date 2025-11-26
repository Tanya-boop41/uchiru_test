class StudentsController < ApplicationController
  def create
    student = Student.new(student_params)

    if student.save
      student.classroom.increment!(:students_count)
      token = AuthTokenService.generate(student.id)
      response.set_header('X-Auth-Token', token)
      render json: student.as_openapi_json, status: :created
    else
      render json: { error: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user_id = params[:user_id]
    return render json: { error: 'invalid id' }, status: :bad_request unless user_id =~ /\A\d+\z/

    require_auth_for_user!(user_id)

    student = Student.find_by(id: user_id)
    return render json: { error: 'not found' }, status: :bad_request unless student

    student.classroom.decrement!(:students_count) if student.classroom.students_count > 0
    student.destroy

    head :no_content
  end

  private

  def student_params
    params.permit(:first_name, :last_name, :surname, :class_id, :school_id)
  end
end