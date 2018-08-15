require 'rails_helper'

RSpec.describe TablesController, type: :controller do

  describe "#create" do
    context "with table name" do
      it 'should create table' do
        post :create, params: {table: {name: "Table 5"}}
        expect(Table.find_by(name: "Table 5")).to_not be_nil
      end

      it 'should set success flash message' do
        post :create, params: {table: {name: "Table 5"}}
        expect(flash[:success]).to match(/Table successfully added/)
      end

      it 'should redirect to new' do
        post :create, params: {table: {name: "Table 5"}}
        expect(response).to redirect_to(action: :new)
      end
    end

    context "without name" do
      it 'should not create the table' do
        expect{post :create, params: {table: {name: ""}}}.to_not change{Table.count}
      end

      it 'should set alert flash message' do
        post :create, params: {table: {name: ""}}
        expect(flash[:alert]).to match(/Name can't be blank/)
      end
    end
  end
end
