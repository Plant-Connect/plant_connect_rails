require 'rails_helper'

RSpec.describe UserConversation, type: :model do

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :conversation }
  end
end 