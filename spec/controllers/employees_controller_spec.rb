require 'spec_helper'

describe EmployeesController do
  let(:current_employee) { FactoryGirl.create :employee}
  before :each do
    controller.stub(:current_employee).and_return(current_employee) 
  end

  describe "GET 'show'" do
    it "returns http success" do
      Employee.stub(:find).with(current_employee.id).and_return("yourMama")
      get 'show', {id: 18}
      expect(assigns(:employee)).to eq "yourMama"
      response.should be_success
    end
  end

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
