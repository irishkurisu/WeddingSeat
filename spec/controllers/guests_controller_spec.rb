require 'rails_helper'

RSpec.describe GuestsController, type: :controller do
  render_views

  describe "#welcome" do
    subject { get :welcome }

    it 'should render the welcome template' do
      expect(subject).to render_template(:welcome)
    end
  end

  describe "#new" do
    subject { get :new }

    it 'should render the new template' do
      expect(subject).to render_template(:new)
    end
  end

  describe "#create" do
    context "with first name and last name and table" do
      let(:table) {Table.create(name: "Test")}

      it 'should create table' do
        post :create, params: {guest: {first_name: "Bob", last_name: "Roberts", table_id: table.id}}
        expect(Guest.where(first_name: "Bob", last_name: "Roberts").first).to_not be_nil
      end

      it 'should set success flash message' do
        post :create, params: {guest: {first_name: "Bob", last_name: "Roberts", table_id: table.id}}
        expect(flash[:success]).to match(/Guest successfully added/)
      end

      it 'should redirect to new' do
        post :create, params: {guest: {first_name: "Bob", last_name: "Roberts", table_id: table.id}}
        expect(response).to redirect_to(action: :new)
      end
    end

    context "without first name" do
      it 'should not create the table' do
        expect{post :create, params: {guest: {last_name: "Roberts"}}}.to_not change{Guest.count}
      end

      it 'should set alert flash message' do
        post :create, params: {guest: {last_name: "Roberts"}}
        expect(flash[:alert]).to match(/First name can't be blank/)
      end
    end

    context "without last name" do
      it 'should not create the table' do
        expect{post :create, params: {guest: {first_name: "Bob"}}}.to_not change{Guest.count}
      end

      it 'should set alert flash message' do
        post :create, params: {guest: {first_name: "Bob"}}
        expect(flash[:alert]).to match(/Last name can't be blank/)
      end
    end

    context "without table selected" do
      it 'should not create the table' do
        expect{post :create, params: {guest: {first_name: "Bob", last_name: "Roberts"}}}.to_not change{Guest.count}
      end

      it 'should set alert flash message' do
        post :create, params: {guest: {first_name: "Bob", last_name: "Roberts"}}
        expect(flash[:alert]).to match(/Table must exist/)
      end
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
