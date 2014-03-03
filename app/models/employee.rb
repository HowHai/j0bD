class Employee < ActiveRecord::Base
  has_one :github_account
  has_one :dribbble
  has_one :stack_overflow_account
  has_one :linked_in

end
