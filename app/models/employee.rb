class Employee < ActiveRecord::Base
  has_one :github_account
  has_one :stack_overflow_account
end
