require 'rails_helper'

RSpec.describe GuestsController, type: :controller do
  render_views

  describe "#welcome" do
    subject { get :welcome }

    it 'should render the welcome template' do
      expect(subject).to render_template(:welcome)
    end
  end

  describe "#search" do
    context "it has no results" do
      subject { get :search, params: {last_name: "jenkins"} }
      it 'should render the search template with the no results message' do
        expect(subject.body).to match(/There were no results for that guests's name/)
      end
    end

    context "it has results" do
      before() do
        table3 = Table.create(name: "Table 3")
        table10 = Table.create(name: "Table 10")
        Guest.create(last_name: "Johnson", first_name: "Bob", table: table3)
        Guest.create(last_name: "Jenkins", first_name: "Jimmy", table: table10)
      end
      subject { get :search, params: {last_name: "jenkins"} }

      it 'should render the search template with the correct guests and tables displayed' do
        expect(subject.body).to match(/Jenkins, Jimmy\s+Table 10/)
      end

      it 'should not display incorrect tables' do
        expect(subject.body).not_to match(/Table 3/)
      end

      it 'should not display any guests who do not match the search term' do
        expect(subject.body).not_to match(/Johnson/)
      end
    end
  end

end
