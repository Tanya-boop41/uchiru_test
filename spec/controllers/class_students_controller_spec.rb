require "rails_helper"

RSpec.describe ClassStudentsController, type: :controller do
  describe "GET #index" do
    let(:school) { create(:school) }
    let(:classroom) { create(:classroom, school: school) }

    context "when students exist" do
      let!(:students) { create_list(:student, 3, classroom: classroom, school: school) }

      it "returns success with serialized students" do
        get :index, params: { class_id: classroom.id, school_id: school.id }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json["data"].length).to eq(3)

        expect(json["data"].first).to include("id", "first_name", "last_name", "surname", "school_id", "class_id")
      end
    end

    context "when no students exist" do
      it "returns 404 with error message" do
        get :index, params: { class_id: classroom.id, school_id: school.id }

        expect(response).to have_http_status(:not_found)

        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Not found")
      end
    end
  end
end

