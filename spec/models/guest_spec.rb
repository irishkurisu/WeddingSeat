require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe "#create" do
    it 'should require first name' do
      t = Guest.create
      expect(t.errors[:first_name]).to include("can't be blank")
    end

    it 'should require last name' do
      t = Guest.create
      expect(t.errors[:last_name]).to include("can't be blank")
    end
  end
end
