FactoryGirl.define do 
  factory :github_account do
    employee #creates an employee which is necessary because github_account belongs_to employee and an employee must be created and saved to database each time we make a github_account
    provider "github"
    uid "8899893435"
    sequence(:username) { |n| "username#{n}"}
    oauth_token "fdfjlka2839dkslfj"
  end
end