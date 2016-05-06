Feature: URL Crawl
  As a user, I want hit the url and take screenshot


  Scenario: Open user page
    Given User page is opened
    Then I should see the specified text
    And I should navigate to each link on the page and take screenshot

