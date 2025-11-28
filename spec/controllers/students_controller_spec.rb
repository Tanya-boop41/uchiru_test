require "rails_helper"

RSpec.describe StudentsController, type: :controller do
  describe "POST #create" do
    let(:school) { create(:school) }
    let(:classroom) { create(:classroom, school: school) }

    let(:valid_params) do
      {
        student: {
          first_name: "John",
          last_name: "Doe",
          surname: "Smith",
          school_id: school.id,
          class_id: classroom.id
        }
      }
    end

    context "with valid params" do
      it "creates a student and returns serialized student with token" do
        post :create, params: valid_params

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expect(json["data"]).to include(
          "id" => be_a(Integer),
          "first_name" => "John",
          "last_name" => "Doe",
          "surname" => "Smith",
          "school_id" => school.id,
          "class_id" => classroom.id,
          "token" => be_a(String)
        )
        student = Student.find(json["data"]["id"])
        expect(student.first_name).to eq("John")
      end
    end

    context "with invalid params" do
      it "raises ValidationError and returns error" do
        invalid_params = {
          student: {
            first_name: "",
            last_name: "Doe",
            surname: "Smith",
            school_id: school.id,
            class_id: classroom.id
          }
        }

        expect {
          post :create, params: invalid_params
        }.to raise_error(AppError::ValidationError)
      end
    end
  end
  describe "DELETE #destroy" do
    let(:school) { create(:school) }
    let(:classroom) { create(:classroom, school: school) }
    let!(:student) { create(:student, school: school, classroom: classroom) }

    before do
      # Обходим авторизацию
      allow(controller).to receive(:authorize_request).and_return(true)
    end

    it "deletes the student and returns no_content" do
      expect {
        delete :destroy, params: { user_id: student.id }
      }.to change(Student, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
