require "rails_helper"

RSpec.describe ClassesController, type: :controller do
  describe "GET #index" do
    let(:school) { create(:school) }

    context "when classes exist" do
      let!(:classrooms) do
        create_list(:classroom, 2, school:).each do |classroom|
          create_list(:student, 3, classroom:, school:)
        end
      end

      it "returns success with serialized classrooms" do
        get :index, params: { school_id: school.id }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json["data"].length).to eq(2)

        expect(json["data"].first).to include("id", "number", "letter", "students_count")
      end
    end

    context "when no classes exist" do
      it "returns 404 with error message" do
        get :index, params: { school_id: school.id }

        expect(response).to have_http_status(:not_found)

        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Not found")
      end
    end
  end
end
