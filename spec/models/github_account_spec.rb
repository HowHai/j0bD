require 'spec_helper'

describe GithubAccount do
  before :each do
    @valid_attributes = {
      employee_id: 1,
      provider: "github",
      uid: "kldsjfl",
      oauth_token: "ldsjflkdjfl"
    }
  end

  describe "GithubAccount must belong_to Employee model" do
    it "should have a employee_id" do
      employee = Employee.create(id: 20)
      git = GithubAccount.create(employee_id: 20)
      expect(git.employee.id).to eq(20)
    
    end
  end

  describe "provider, uid, oauth_token and employee id must be present when GithubAccount is created" do
    it "should be valid when employee id is present" do
      GithubAccount.create(employee_id: 2)
      GithubAccount.create(employee_id: 1, provider: "github", uid: "lkdjflkajf", oauth_token: "lkfjaldfj")
      GithubAccount.create()
      expect(GithubAccount.count).to eq 1
    end
  end

  describe "provider must be github" do
    it "should be valid when provider is github" do
      git = GithubAccount.create(@valid_attributes)
      expect(git.provider).to eq "github"
    end
    it "should not be valid when provider is not github" do
      git = GithubAccount.create(@valid_attributes.merge(provider: 'linkedin'))
      expect(git).to be_invalid

    end
  end

  describe "GithubAccount must have a has_many relationship with github_repos" do
    it "should have access to a github_repos attribute" do
      git = GithubAccount.create(@valid_attributes)
      (git.github_repos.count).should be >= 0
    end
  end
  
  describe ".create_with_omniauth(auth)" do
    pending
  end
end
