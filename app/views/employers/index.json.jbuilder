json.employee do |json|
  json.extract! @employee, :id, :name, :primary_stats, :github_account, :stack_overflow_account, :linked_in, :dribbble
end
