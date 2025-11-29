require "rails_helper"

RSpec.describe School, type: :model do
  include_context "school with classroom"

  describe "associations" do
    it "has many classrooms" do
      expect(school.classrooms).to include(classroom)
    end

    it "has many students through classrooms" do
      student = create(:student, school: school, classroom: classroom)

      expect(school.students).to include(student)
    end
  end
end