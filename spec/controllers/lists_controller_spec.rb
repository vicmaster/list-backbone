require 'spec_helper'

describe ListsController do
  describe 'Get: #index' do

    before do
      List.should_receive(:all)
    end

    specify do
      get :index, format: 'json'
      response.should be_success
    end

  end

  describe 'Post: #Create' do
    #you can use this line
    let(:list) { Fabricate :list }
    #or this one
    #let(:list) { mock_model List, :as_json => { name: 'Home', description: 'Things to do at home' } }
    before do
      List.should_receive(:create).and_return list
    end

    specify do
      post :create, format: 'json'
      response.should be_success
    end
  end

  describe 'Get: #Show' do
    let(:list){ Fabricate :list }

    before do
      List.should_receive(:find).with(list.id.to_s).and_return list
    end

    specify do
      get :show, id: list.id, format: 'json'
      response.should be_success
    end
  end

  describe "Put: #Update" do
    let(:list) { Fabricate :list }

    before do
      List.should_receive(:update).with(list.id.to_s, list).and_return list
    end

    specify do
      put :update, id: list.id, list: list, format: 'json'
      response.should be_success
    end
  end

  describe "Delete: #Destroy" do
    let(:list) { Fabricate :list }

    before do
      List.should_receive(:destroy).with(list.id.to_s).and_return list
    end

    specify do
      delete :destroy, id: list.id, format: 'json'
      response.should be_success
    end
  end


end
