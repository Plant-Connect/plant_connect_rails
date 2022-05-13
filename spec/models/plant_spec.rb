require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :photo }
    it { should validate_presence_of :type }
    it { should validate_presence_of :description }
  end

  describe 'relationships' do 
    it { should belong_to :user }
  end
end