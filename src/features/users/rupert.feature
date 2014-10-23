Feature: A Friendly Hello
  As a user of our Site
  Rupert wants get a friendly greeting
  So that he feels great this morning

  Scenario: Hello
    Given I am on the page
    When I give my name as "Rupert"
    Then I should see a friendly greeting

  Scenario: Already Met
    Given I am on the page
    When I give my name as "Rupert"
    And I give my name as "Rupert" again
    Then I should see a friendly already met you
