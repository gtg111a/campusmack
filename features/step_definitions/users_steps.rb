Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)" college id$/ do |field, parent, college|
  value = College.where(:name => college).first.id
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end