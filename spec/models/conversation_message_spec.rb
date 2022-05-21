require 'rails_helper'

RSpec.describe ConversationMessage, type: :model do

  describe 'relationships' do
    it { should belong_to :conversation }
    it { should belong_to :message }
  end
end 