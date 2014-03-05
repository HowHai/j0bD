require 'spec_helper'

describe GithubAccount do
  let(:github_account) {FactoryGirl.build :github_account}
  subject { github_account }
  describe "GithubAccount must belong_to Employee model and it must fulfill our attributes validations" do
    context "it should be valid when github_account has an employee_id" do
      it { should be_valid } # testing that all validations pass
    end
  end

  describe "provider must be github" do
    context "it should be valid when provider is github" do
      it { should be_valid } #passes because created w/ Github as provider
    end
    it "should not be valid when provider is not github" do
      github_account2 = FactoryGirl.build :github_account, provider: "linkedin"
      expect( github_account2 ).to be_invalid
    end
  end
  
  # describe ".create_with_omniauth(auth)" do
  #   pending
  # end
end
