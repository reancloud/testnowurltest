Feature: Text verification on User Page
  As a user, I want hit the url and verify text on page

  Scenario: Login to Confluence
    Given User page is opened
    When I login using username "abcd" and password "xyz"
    And I follow forgot password link
    And I click on login button
    Then I should see the specified text