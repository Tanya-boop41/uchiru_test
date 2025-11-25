class StudentsController < ApplicationController
  def create
    permitted = params.permit(:first_name, :last_name, :surname, :class_id, :school_id)
    required = %i[first_name last_name surname class_id school_id]
    missing = required.select { |k| permitted[k].blank? }
    return render json: { error: "missing #{missing.join(', ')}" }, status: :bad_request if missing.any?

    classroom = Classroom.find_by(id: permitted[:class_id], school_id: permitted[:school_id])
    return render json: { error: 'class not found in school' }, status: :bad_request unless classroom

    student = Student.create!(
      first_name: permitted[:first_name],
      last_name: permitted[:last_name],
      surname: permitted[:surname],
      classroom: classroom,
      school_id: permitted[:school_id]
    )

    classroom.increment!(:students_count)

    token = AuthTokenService.generate(student.id)

    response.set_header('X-Auth-Token', token)
    render json: student.as_openapi_json, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    user_id = params[:user_id]
    return render json: { error: 'invalid id' }, status: :bad_request unless user_id =~ /\A\d+\z/

    require_auth_for_user!(user_id)

    student = Student.find_by(id: user_id)
    return render json: { error: 'not found' }, status: :bad_request unless student

    classroom = student.classroom
    student.destroy
    classroom.decrement!(:students_count) if classroom && classroom.students_count > 0

    head :no_content
  end
end
