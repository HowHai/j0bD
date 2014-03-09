json.employees do |json|
  json.array!(@employees) do |employee|
    json.extract! employee, :id, :name
    json.github do |json|
      json.extract! employee.github_account
    end
  end
end