require "rails_helper"

RSpec.describe Classroom, type: :model do
  include_context "school with classroom"

  describe "associations" do
    it "belongs to a school" do
      expect(classroom.school).to eq(school)
    end

    it "destroys dependent students" do
      create(:student, school: school, classroom: classroom)

      expect { classroom.destroy }.to change(Student, :count).by(-1)
    end
  end

  describe "validations" do
    it "is invalid without number" do
      classroom = build(:classroom, number: nil, school: school)

      expect(classroom).not_to be_valid
      expect(classroom.errors[:number]).to include("can't be blank")
    end

    it "is invalid without letter" do
      classroom = build(:classroom, letter: nil, school: school)

      expect(classroom).not_to be_valid
      expect(classroom.errors[:letter]).to include("can't be blank")
    end
  end
end
