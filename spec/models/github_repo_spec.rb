require 'spec_helper'


describe GithubRepo do
  before :each do
    @valid_attributes = {
      employee_id: 1,
      provider: "github",
      uid: "kldsjfl",
      oauth_token: "ldsjflkdjfl"
    }
  end

  describe "GithubRepo must belong_to GithubAccount model" do
    it "should have a GithubAccount id" do
      GithubAccount.create(@valid_attributes.merge(id: 19))
      gitrepo = GithubRepo.create(github_account_id: 19)
      expect(gitrepo.github_account.id).to eq(19)
    end
  end

  describe "github_account_id, and name must be present when GithubRepo is created" do
    it "should be valid when github_account_id and name are present" do
      GithubRepo.create(github_account_id:2)
      GithubRepo.create()
      expect(GithubRepo.count).to eq 1
    end
  end
end