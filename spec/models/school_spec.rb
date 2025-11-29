require "rails_helper"

RSpec.describe School, type: :model do
  describe "associations" do
    it "has many classrooms" do
      school = School.create!(name: "Test School")
      classroom = Classroom.create!(number: 1, letter: "A", school: school)

      expect(school.classrooms).to include(classroom)
    end

    it "has many students through classrooms" do
      school = School.create!(name: "Test School")
      classroom = Classroom.create!(number: 1, letter: "A", school: school)
      student = Student.create!(first_name: "John", last_name: "Doe", surname: "Smith", school: school, classroom: classroom)

      expect(school.students).to include(student)
    end
  end
end
