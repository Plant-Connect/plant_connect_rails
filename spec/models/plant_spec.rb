require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :photo }
    it { should validate_presence_of :plant_type }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do 
    it { should belong_to :user }
    it { should have_many :listings }
  end
end