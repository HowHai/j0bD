require 'spec_helper'

describe Employee do
  describe "#git_account column" do
    it "should be present" do
      emp = Employee.create
      expect(emp.respond_to?(:git_account)).to eq true
    end
  end
end
