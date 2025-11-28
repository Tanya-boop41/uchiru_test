module Students
  class CreateService < ApplicationService
    def initialize(student_params:)
      @student_params = student_params
    end

    def call
      student = Student.new(@student_params)

      unless student.save
        raise ValidationError.new("Validation failed", details: student.errors.full_messages)
      end

      [ student, JsonWebToken.encode(student_id: student.id) ]
    end
  end
end
