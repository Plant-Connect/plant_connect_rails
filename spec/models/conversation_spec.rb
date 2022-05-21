require 'rails_helper'

RSpec.describe Conversation, type: :model do

  describe 'relationships' do
    it { should have_many :user_conversations }
    it { should have_many(:users).through(:user_conversations) }
    # it { should have_many :messages }
  end
end 