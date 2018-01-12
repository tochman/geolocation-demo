module ApplicationHelper
  def fake_location
    Rails.application.config.fake_location.to_json
  end
end
