require 'rails_helper'

RSpec.describe Table, type: :model do
  describe "#create" do
    it 'should require name' do
      t = Table.create
      expect(t.errors[:name]).to include("can't be blank")
    end
  end
end
