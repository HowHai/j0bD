require 'spec_helper'

describe LinkedinsController do
  it "gives us only the last linkedin on show" do
    @linkedin = LinkedIn.create(provider: "Your Daddy")
    get 'show', id: @linkedin, format: 'html'
    expect(response).to be_success
  end

  # let(:current_employee) { FactoryGirl.create :employee}
  # before :each do
  #   controller.stub(:current_employee).and_return(current_employee) 
  # end
  # describe "POST create" do
  #   it "placeholder" do 
  #   end
  # end
  # describe "GET index" do
  #   it "responds to success" do
  #     get 'index'
  #   end
  # end
end
