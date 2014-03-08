require 'spec_helper'

describe LinkedIn do
  it "is invalid without a provider" do
    expect(LinkedIn.new( provider: nil )).to have(1).errors_on( :provider )
  end
end
