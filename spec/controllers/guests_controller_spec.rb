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
        Guest.create(last_name: "Johnson", first_name: "Bob")
        Guest.create(last_name: "Jenkins", first_name: "Jimmy")
      end
      subject { get :search, params: {last_name: "jenkins"} }

      it 'should render the search template with the correct guests displayed' do
        expect(subject.body).to match(/Jenkins, Jimmy/)
      end

      it 'should not display any guests who do not match the search term' do
        expect(subject.body).not_to match(/Johnson/)
      end
    end
  end

end
