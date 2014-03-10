require 'spec_helper'

describe EmployersController do
  describe "GET 'index'" do
    it "returns http success" do
      Employee.stub(:all).and_return("all employees")
      expect(assigns(:employees)).to eq "all employees"
      response.should be_success
    end
  end
end
