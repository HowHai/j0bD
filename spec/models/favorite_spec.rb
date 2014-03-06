require 'spec_helper'

describe Favorite do
  let(:fav) {
    FactoryGirl.build :favorite
  }
  subject {fav}
  describe "Belongs to employee and employer" do
    it {should be_valid}
  end
end
