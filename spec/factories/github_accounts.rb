FactoryGirl.define do 
  factory :github_account do
    employee #belongs to employee
    provider "github"
    uid "8899893435"
    sequence(:username) { |n| "username#{n}"}
    oauth_token "fdfjlka2839dkslfj"
  end
end