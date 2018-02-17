require 'rails_helper'

describe Api::TagsController do
  let!(:tag1) { FactoryBot.create :tag, name: 'Tag A' }
  let!(:tag2) { FactoryBot.create :tag, name: 'Tag B' }

  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }

    it 'returns all tags' do
      expect(assigns(:tags)).to eq [tag1, tag2]
    end
  end
end
