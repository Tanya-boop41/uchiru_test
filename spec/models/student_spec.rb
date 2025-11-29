require "rails_helper"

RSpec.describe Student, type: :model do
  describe "associations" do
    it "belongs to school" do
      school = School.create!(name: "Test School")
      classroom = Classroom.create!(number: 1, letter: "A", school: school)
      student = Student.new(first_name: "John", last_name: "Doe", surname: "Smith", school: school, classroom: classroom)

      expect(student.school).to eq(school)
    end

    it "belongs to classroom" do
      school = School.create!(name: "Test School")
      classroom = Classroom.create!(number: 1, letter: "A", school: school)
      student = Student.new(first_name: "John", last_name: "Doe", surname: "Smith", school: school, classroom: classroom)

      expect(student.classroom).to eq(classroom)
    end
  end

  describe "validations" do
    it "is invalid without first_name" do
      school = School.create!(name: "Test School")
      classroom = Classroom.create!(number: 1, letter: "A", school: school)
      student = Student.new(last_name: "Doe", surname: "Smith", school: school, classroom: classroom)

      expect(student.valid?).to be false
      expect(student.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without last_name" do
      school = School.create!(name: "Test School")
      classroom = Classroom.create!(number: 1, letter: "A", school: school)
      student = Student.new(first_name: "John", surname: "Smith", school: school, classroom: classroom)

      expect(student.valid?).to be false
      expect(student.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without surname" do
      school = School.create!(name: "Test School")
      classroom = Classroom.create!(number: 1, letter: "A", school: school)
      student = Student.new(first_name: "John", last_name: "Doe", school: school, classroom: classroom)

      expect(student.valid?).to be false
      expect(student.errors[:surname]).to include("can't be blank")
    end

    it "is invalid without classroom_id" do
      school = School.create!(name: "Test School")
      student = Student.new(first_name: "John", last_name: "Doe", surname: "Smith", school: school)

      expect(student.valid?).to be false
      expect(student.errors[:classroom]).to include("must exist")
    end

    it "is invalid without school_id" do
      school = School.create!(name: "Test School")
      classroom = Classroom.create!(number: 1, letter: "A", school: school)
      student = Student.new(first_name: "John", last_name: "Doe", surname: "Smith", classroom: classroom)

      expect(student.valid?).to be false
      expect(student.errors[:school]).to include("must exist")
    end
  end

  describe "custom validation" do
    it "is invalid if classroom does not belong to school" do
      school1 = School.create!(name: "School 1")
      school2 = School.create!(name: "School 2")
      classroom = Classroom.create!(number: 1, letter: "A", school: school2)

      student = Student.new(first_name: "John", last_name: "Doe", surname: "Smith", school: school1, classroom: classroom)

      expect(student.valid?).to be false
      expect(student.errors[:class_id]).to include("does not belong to school with id #{school1.id}")
    end
  end
end
