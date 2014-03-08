require 'spec_helper'

describe Position do
  it "is invalid without a title" do
    expect(Position.new(title: nil)).to have(1).errors_on(:title)
  end
end
