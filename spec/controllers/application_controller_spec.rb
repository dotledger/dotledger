require 'spec_helper'

describe ApplicationController do
  describe 'GET boot' do
    before { get :boot }

    it { should respond_with :success }
  end
end
