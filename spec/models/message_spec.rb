require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:room) { create(:room, is_private: false) }
  let!(:participant) { create(:participant, user: user, room: room) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      message = Message.new(body: 'Hello World', user: user, room: room)
      expect(message).to be_valid
    end

    it 'is not valid without a body' do
      message = Message.new(body: nil, user: user, room: room)
      expect(message).to_not be_valid
    end

    it 'is not valid without a user' do
      message = Message.new(body: 'Hello World', user: nil, room: room)
      expect(message).to_not be_valid
    end

    it 'is not valid without a room' do
      message = Message.new(body: 'Hello World', user: user, room: nil)
      expect(message).to_not be_valid
    end
  end

  describe 'callbacks' do
    context 'when creating a message in a private room' do
      let(:private_room) { create(:room, is_private: true) }

      it 'raises an error if user is not a participant' do
        message = Message.new(body: 'Hello World', user: user, room: private_room)
        
        expect(message.save).to be_falsey
        expect(Message.count).to eq(0)
      end
    end
  end

  describe '#confirm_participant' do
    context 'when room is private' do
      let(:private_room) { create(:room, is_private: true) }

      it 'does not save the message if user is not a participant' do
        message = Message.new(body: 'Hello World', user: user, room: private_room)
        
        expect(message.save).to be_falsey
        expect(Message.count).to eq(0)
      end

      it 'saves the message if user is a participant' do
        create(:participant, user: user, room: private_room)
        message = Message.new(body: 'Hello World', user: user, room: private_room)
        
        expect(message.save).to be_truthy
        expect(Message.count).to eq(1)
      end
    end
  end
end
