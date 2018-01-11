And(/^I visit the site$/) do
  FakeIp.new(Rails.application, '1.1.1.1')
  visit root_path
end

Then(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content content
end

But(/^I should not see "([^"]*)"$/) do |content|
  expect(page).not_to have_content content
end