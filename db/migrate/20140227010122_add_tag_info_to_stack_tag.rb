class AddTagInfoToStackTag < ActiveRecord::Migration
  def change
    add_column :stack_tags, :top_tag_name, :string
    add_column :stack_tags, :question_score, :integer
    add_column :stack_tags, :question_count, :integer
    add_column :stack_tags, :answer_score, :integer
    add_column :stack_tags, :answer_count, :integer
  end
end
