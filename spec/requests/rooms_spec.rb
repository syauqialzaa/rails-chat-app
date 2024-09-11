require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let(:user) { create(:user) }
  let(:room) { create(:room) }

  before do
    sign_in user
  end

  describe "GET /rooms" do
    it "returns a successful response and renders index template" do
      get rooms_path
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /rooms/:id" do
    it "returns a successful response and renders index template" do
      get room_path(room)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe "POST /rooms" do
    it "creates a new room and redirects to the rooms index" do
      post rooms_path, params: { room: { name: "New Room" } }
      expect(response).to have_http_status(:no_content)
      expect(Room.last.name).to eq("New Room")
    end
  end
end
