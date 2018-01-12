And(/^I visit the site$/) do
  visit root_path
end

Then(/^I should( not)? see "([^"]*)"$/) do |negate, content|
  if negate
    expect(page).not_to have_content content
  else
    expect(page).to have_content content
  end
end

# But(/^I should not see "([^"]*)"$/) do |content|
#   expect(page).not_to have_content content
# end