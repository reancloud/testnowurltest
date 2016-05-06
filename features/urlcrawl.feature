Feature: URL Crawl
  As a user, I want hit the url and take screenshot


  Scenario: Open user page
    Given User page is opened
    Then I should see the specified text


  Scenario: Crawl through the URL
    Given User page is opened
    Then I should navigate to each link on the page and take screenshot

