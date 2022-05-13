require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :category }

    it { should validate_numericality_of :quantity }
  end

 
end