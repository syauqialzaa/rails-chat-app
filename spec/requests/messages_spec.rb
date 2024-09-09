require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:user) { create(:user) }
  let(:room) { create(:room, is_private: false) }
  let!(:participant) { create(:participant, user: user, room: room) }

  before do
    sign_in user
  end

  describe "POST /rooms/:room_id/messages" do
    context "with valid attributes" do
      it "creates a new message and returns a successful response" do
        post room_messages_path(room), params: { message: { body: "Hello World" } }

        expect(response).to have_http_status(:success)
        expect(Message.last.body).to eq("Hello World")
        expect(Message.last.room).to eq(room)
        expect(Message.last.user).to eq(user)
      end
    end

    context "when the room is private and the user is not a participant" do
      let(:private_room) { create(:room, is_private: true) }

      it "does not create a new message and returns an error" do
        post room_messages_path(private_room), params: { message: { body: "Hello World" } }

        expect(response).to have_http_status(:no_content)
        expect(Message.count).to eq(0)
      end
    end
  end
end
