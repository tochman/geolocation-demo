@javascript
Feature: User can visit the site and view a list of restaurants
  As a user
  In order to make an informed choice about where to order my food
  I would like to see a list of restaurants in my proximity

  Background:
    Given these restaurants exist:
      | name                | city      |
      | Scott's Pizza Place | Stockholm |
      | Oliver's Burgers    | Göteborg  |

    #And I am in Stockholm
  And I am at latitude: "59.33", longitude: "18.05"

  Scenario: User can see a list of restaurants
    Given I visit the site
    And the map has been loaded
    Then the center of the map should be approximately "59.334591" lat and "18.063240" lng
    Then I should see "Scott's Pizza Place"
    But I should not see "Oliver's Burgers"
