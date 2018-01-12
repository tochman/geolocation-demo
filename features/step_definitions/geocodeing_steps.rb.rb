Given(/^I am in Stockholm$/) do
  Rails.application.config.fake_location = {lat:59.334591,lng:18.063240}
end

Given(/^these restaurants exist:$/) do |table|
  table.hashes.each do |restaurant_hash|
    create(:restaurant, restaurant_hash)
  end
end