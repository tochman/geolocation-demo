Given(/^I am in Stockholm$/) do
  page.execute_script("window.navigator.geolocation.getCurrentPosition =
      function(success){
        var position = {'coords' : {
            'latitude': '59.334591',
            'longitude': '18.063240'
        }
      };
  success(position);}")
end

Given(/^these restaurants exist:$/) do |table|
  table.hashes.each do |restaurant_hash|
    create(:restaurant, restaurant_hash)
  end
end