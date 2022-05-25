require 'rails_helper'

RSpec.describe Conversation, type: :model do

  describe 'validations' do 
    it { should validate_presence_of :listing_id }
  end

  describe 'relationships' do
    it { should have_many :user_conversations }
    it { should have_many(:users).through(:user_conversations) }
    it { should have_many :messages }

    it { should belong_to :listing}
  end
end 