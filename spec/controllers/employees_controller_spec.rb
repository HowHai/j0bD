require 'spec_helper'

describe EmployeesController do

  # describe "GET 'update'" do
  #   it "returns http success" do
  #     get 'update'
  #     response.should be_success
  #   end
  # end

  describe "GET 'new'" do
    it "returns http success" do
      Employee.should_receive(:new).and_return "an employee"
      get 'new'
      expect(assigns(:employee)).to eq "an employee"
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns a new employee" do
      Employee.should_receive(:new).and_return "a new employee"
      post 'create'
      expect(assigns(:employee)).to eq "a new employee"
      response.should redirect_to("/")
    end
  end
end
