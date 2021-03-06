require 'spec_helper'

describe GithubReposController do


  describe "GET 'index'" do
    it "returns http success" do
      GithubRepo.should_receive(:all).and_return("An array of GithubRepo's")
      get 'index'
      expect(assigns(:github_repos)).to eq("An array of GithubRepo's")
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      GithubRepo.should_receive(:find).with('101').and_return("A repo was found")
      get 'show', {id: 101}
      expect(assigns(:github_repo)).to eq("A repo was found")
      response.should be_success
    end
  end

end
