require 'spec_helper'

describe ApplicationController do
  describe 'GET boot' do
    before { get :boot }

    it { should respond_with :success }

    it "should export some data" do
      expect(controller.gon.all_variables.keys).to match_array [
        "accounts",
        "account_types",
        "category_types",
        "goal_periods"
      ]
    end
  end
end
