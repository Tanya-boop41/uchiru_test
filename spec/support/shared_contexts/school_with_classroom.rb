RSpec.shared_context "school with classroom" do
  let(:school)    { create(:school) }
  let(:classroom) { create(:classroom, school: school) }
end
