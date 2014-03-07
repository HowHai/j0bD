require 'spec_helper'

describe Employee do
  let(:full_stack_employee) do
    tags = FactoryGirl.create :stack_tag
    employee2 = tags.stack_overflow_account.employee
    employee_github = FactoryGirl.create :github_account, employee_id: employee2.id
    FactoryGirl.create :github_repo, github_account_id: employee_github.id  
    employee2
  end

  let(:employee) {FactoryGirl.build :employee}
  subject { employee }

  describe ".calculate_top_tags_score" do
    it "returns an array" do
      expect(full_stack_employee.calculate_top_tags_score).to be_a Array
    end
    it "cannot be an empty array" do
      expect(full_stack_employee.calculate_top_tags_score.count).to be > 0
    end
  end

  describe ".top_tags" do
    it "will return an array of tag objects" do
      related_tags = full_stack_employee.top_tags
      expect(related_tags.first).to be_a Hash
    end
    it "will return only tags that match tags in the github_top_skills" do
      github_top_skills = full_stack_employee.github_top_skills.keys.map(&:to_s)
      related_tags = full_stack_employee.top_tags
      expect(github_top_skills.include?(related_tags[0][:tag_name])).to be_true
    end
  end
end
