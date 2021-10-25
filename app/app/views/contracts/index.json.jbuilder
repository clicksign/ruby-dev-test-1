json.contracts @contracts.list.each do |contract|
  json.id contract.id
  json.description contract.description
end