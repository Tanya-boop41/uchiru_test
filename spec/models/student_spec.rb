require "rails_helper"

RSpec.describe Student, type: :model do
  include_context "school with classroom"

  subject(:student) do
    build(:student, school: school, classroom: classroom)
  end

  describe "associations" do
    it "belongs to school" do
      expect(student.school).to eq(school)
    end

    it "belongs to classroom" do
      expect(student.classroom).to eq(classroom)
    end
  end

  describe "validations" do
    it "requires first_name" do
      student.first_name = nil
      expect(student).not_to be_valid
      expect(student.errors[:first_name]).to include("can't be blank")
    end

    it "requires last_name" do
      student.last_name = nil
      expect(student).not_to be_valid
      expect(student.errors[:last_name]).to include("can't be blank")
    end

    it "requires surname" do
      student.surname = nil
      expect(student).not_to be_valid
      expect(student.errors[:surname]).to include("can't be blank")
    end
  end

  describe "custom validation" do
    it "is invalid if classroom belongs to another school" do
      wrong_school = create(:school)
      other_classroom = create(:classroom, school: wrong_school)

      student.classroom = other_classroom

      expect(student).not_to be_valid
      expect(student.errors[:class_id]).to include("does not belong to school with id #{school.id}")
    end
  end
end
