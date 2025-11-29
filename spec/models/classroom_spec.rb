require "rails_helper"

RSpec.describe Classroom, type: :model do
  describe "associations" do
    it "belongs to school" do
      school = School.create!(name: "Test School")
      classroom = Classroom.new(number: 1, letter: "A", school: school)

      expect(classroom.school).to eq(school)
    end

    it "has many students with dependent destroy" do
      school = School.create!(name: "Test School")
      classroom = Classroom.create!(number: 1, letter: "A", school: school)
      Student.create!(first_name: "John", last_name: "Doe", surname: "Smith", school: school, classroom: classroom)

      expect { classroom.destroy }.to change { Student.count }.by(-1)
    end
  end

  describe "validations" do
    it "is invalid without number" do
      classroom = Classroom.new(letter: "A", school: School.new(name: "Test School"))

      expect(classroom.valid?).to be false
      expect(classroom.errors[:number]).to include("can't be blank")
    end

    it "is invalid without letter" do
      classroom = Classroom.new(number: 1, school: School.new(name: "Test School"))

      expect(classroom.valid?).to be false
      expect(classroom.errors[:letter]).to include("can't be blank")
    end
  end
end
