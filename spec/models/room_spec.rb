require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  describe "validations" do
    it "validates uniqueness of name" do
      Room.create(name: "Room 1", is_private: false)
      duplicate_room = Room.new(name: "Room 1", is_private: false)

      expect(duplicate_room.valid?).to be_falsey
      expect(duplicate_room.errors[:name]).to include("has already been taken")
    end
  end

  describe "scopes" do
    it "returns only public rooms" do
      public_room = Room.create(name: "Public Room", is_private: false)
      private_room = Room.create(name: "Private Room", is_private: true)

      expect(Room.public_rooms).to include(public_room)
      expect(Room.public_rooms).not_to include(private_room)
    end
  end

  describe "callbacks" do
    it "broadcasts to 'rooms' after create if public" do
      public_room = Room.new(name: "Public Room", is_private: false)

      expect(public_room).to receive(:broadcast_if_public)
      public_room.save
    end

    it "does not broadcast to 'rooms' after create if private" do
      private_room = Room.new(name: "Private Room", is_private: true)

      private_room.save
      expect(private_room).not_to receive(:broadcast_if_public)
    end
  end

  describe "associations" do
    it { should have_many(:messages) }
    it { should have_many(:participants).dependent(:destroy) }
  end

  describe ".create_private_room" do
    it "creates a private room and assigns participants" do
      room_name = "private_room_#{user1.id}_#{user2.id}"
      room = Room.create_private_room([user1, user2], room_name)

      expect(room.name).to eq(room_name)
      expect(room.is_private).to be_truthy
      expect(room.participants.count).to eq(2)
      expect(room.participants.pluck(:user_id)).to include(user1.id, user2.id)
    end
  end
end
