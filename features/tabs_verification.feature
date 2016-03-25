Feature: Tabs verification on User Page
  As a user, I want hit the url and verify tabs on page

  Scenario: Display tabs on page
    Given User page is opened
    When I follow tabs on page
    Then I verify tabs is on page
    And I follow link on page
    Then I verify link open in page