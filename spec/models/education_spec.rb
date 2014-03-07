require 'spec_helper'

describe Education do
  let (:education) {FactoryGirl.build :education}
  subject { education }
  it "is invalid without a degree" do
    education2 = FactoryGirl.build :education, degree: ""
    expect( education2 ).to be_invalid
  end
end
