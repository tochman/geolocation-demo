Given(/^I am in Stockholm$/) do
  Rails.application.config.fake_location = {lat: 59.334591, lng: 18.063240}
end

Given(/^(?:The user is|I am) at latitude: "([^"]*)", longitude: "([^"]*)"$/) do |lat, lng|
  Rails.application.config.fake_location = {lat: lat, lng: lng}
end

Given(/^these restaurants exist:$/) do |table|
  table.hashes.each do |restaurant_hash|
    create(:restaurant, restaurant_hash)
  end
end

Then(/^(?:I expect a Google map to load|the map has been loaded)$/) do
  sleep(0.1)
  expect(page).to have_css '#map .gm-style'
end

Then(/^the center of the map should be approximately "([^"]*)" lat and "([^"]*)" lng$/) do |lat, lng|
  ACCEPTED_OFFSET = 0.2
  center_lat = page.evaluate_script('map.getCenter().lat();')
  center_lng = page.evaluate_script('map.getCenter().lng();')
  expect(center_lat).to be_within(ACCEPTED_OFFSET).of(lat.to_f)
  expect(center_lng).to be_within(ACCEPTED_OFFSET).of(lng.to_f)
end