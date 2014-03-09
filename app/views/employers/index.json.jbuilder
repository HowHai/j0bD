json.employee do |json|
  json.extract! @employee, :id, :name, :primary_stats
end
