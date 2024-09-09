# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid with a short password' do
      user = build(:user, password: '123', password_confirmation: '123')
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:messages) }
  end

  describe 'scopes' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }

    describe '.all_except' do
      it 'returns all users except the specified one' do
        expect(User.all_except(user1)).to include(user2)
        expect(User.all_except(user1)).not_to include(user1)
      end
    end
  end

  describe 'callbacks' do
    it 'broadcasts append to users on create' do
      user = build(:user)
      expect { user.save }.to have_broadcasted_to('users').with(kind_of(String))
    end
  end
  
end
