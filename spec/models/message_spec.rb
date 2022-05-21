require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it { should validate_presence_of :content }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :conversation_messages }
    it { should have_many(:conversations).through(:conversation_messages) }
  end
end 