require 'spec_helper'


describe GithubRepo do
  let(:gitrepo) {FactoryGirl.build :github_repo}
  subject { gitrepo }
  describe "GithubRepo must belong_to GithubAccount model thus it has a github_account_id and fulfills attribute validations" do
    it { should be_valid }
  end
end