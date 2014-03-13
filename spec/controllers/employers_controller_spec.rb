require 'spec_helper'

describe EmployersController do

describe "GET 'index'" do
    it "returns http success" do
      Employer.should_receive(:all).and_return("An array of Employers")
      get 'index'
      expect(assigns(:employers)).to eq("An array of Employers")
      response.should be_success
    end
  end
end
