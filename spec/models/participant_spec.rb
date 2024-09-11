require 'rails_helper'

RSpec.describe Participant, type: :model do
  let(:user) { create(:user) }
  let(:private_room) { create(:room) }
  let(:participant) { create(:participant, user: user, room: private_room) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(participant).to be_valid
    end

    it 'is not valid without a user' do
      participant.user = nil
      expect(participant).to_not be_valid
    end

    it 'is not valid without a room' do
      participant.room = nil
      expect(participant).to_not be_valid
    end
  end
end
