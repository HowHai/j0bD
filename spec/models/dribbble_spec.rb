require 'spec_helper'

describe Dribbble do
  let (:dribbble) {FactoryGirl.build(:dribbble, username: nil)}
  subject { dribbble }
  it "is invalid without a username" do
    expect( dribbble ).to have(1).errors_on(:username)
  end
end
