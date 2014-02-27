class StackOverflowAccount < ActiveRecord::Base
  belongs_to :employee
  has_many :stack_tags

  # Create stack_user's tags
  def create_tags
    # GET all self's tags
    all_tags = HTTParty.get("https://api.stackexchange.com/2.2/users/" + self.id.to_s + "/top-answer-tags?site=stackoverflow&filter=!--Me6hT675Nt&key=d9Fe13Jxvcb)WMzdPi8t7A((")
    all_tags = all_tags["items"]

    # Create a new Tag for each tag
    all_tags.each do |tag|
      tag_data = {stack_overflow_account_id: self.id, answer_count: tag['answer_count'], answer_score: tag['answer_score'], question_count: tag['question_count'], question_score: tag['question_score'], top_tag_name: tag['tag_name']}
      StackTag.create(tag_data)
    end
  end
end
