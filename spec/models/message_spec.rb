require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it { should validate_presence_of :content }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    # it { should belong_to :conversation }
  end
end 