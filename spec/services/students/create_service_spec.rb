require "rails_helper"

RSpec.describe Students::CreateService do
  describe ".call" do
    let(:school) { create(:school) }
    let(:classroom) { create(:classroom, school:) }
    let(:valid_params) do
      {
        first_name: "John",
        last_name: "Doe",
        surname: "Smith",
        school_id: school.id,
        classroom_id: classroom.id
      }
    end

    context "with valid params" do
      it "creates a student and returns a student and token" do
        student, token = described_class.call(student_params: valid_params)

        expect(student).to be_a(Student)
        expect(student).to be_persisted
        expect(student.first_name).to eq("John")
        expect(token).to be_a(String)
      end
    end

    context "with invalid params" do
      it "raises a ValidationError with error details" do
        invalid_params = valid_params.merge(first_name: "")

        expect {
          described_class.call(student_params: invalid_params)
        }.to raise_error(AppError::ValidationError) do |error|
          expect(error.details).to include("First name can't be blank")
        end
      end
    end

    context "when classroom does not belong to school" do
      let(:other_school) { create(:school) }
      let(:other_classroom) { create(:classroom, school: other_school) }

      it "raises a ValidationError" do
        invalid_params = valid_params.merge(classroom_id: other_classroom.id)

        expect {
          described_class.call(student_params: invalid_params)
        }.to raise_error(AppError::ValidationError) do |error|
          expect(error.details.first).to match(/does not belong to school/)
        end
      end
    end
  end
end
