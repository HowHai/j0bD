FactoryGirl.define do
  factory :stack_tag do
    stack_overflow_account
    top_tag_name "php"
    question_score 87
    question_count 23
    answer_score 88
    answer_count 55
  end
end