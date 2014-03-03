class Employee < ActiveRecord::Base
  has_one :github_account
  has_one :dribbble
  has_one :stack_overflow_account
  has_one :linked_in
  has_many :favorites
  has_many :favorite_employers, through: :favorites, source: :employer

end
