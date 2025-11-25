class ClassesController < ApplicationController
  def index
    school = School.find_by(id: params[:school_id])
    return render json: { data: [] }, status: :ok unless school

    classes = school.classrooms
    data = classes.map do |c|
      {
        id: c.id,
        number: c.number,
        letter: c.letter,
        students_count: c.students_count
      }
    end

    render json: { data: data }, status: :ok
  end
end
