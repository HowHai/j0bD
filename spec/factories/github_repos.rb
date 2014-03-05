FactoryGirl.define do 
  factory :github_repo do
    github_account
    name "random_repo_name"
  end
end