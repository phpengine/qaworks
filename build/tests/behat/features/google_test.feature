Feature: Our test feature
Lets check that we can see google

  @googletest
  Scenario: Lets check the Google Home Page works
    Given I am on "http://www.google.co.uk"
    Then I wait 5 seconds
    Then I should see the google logo
    Then I should see the google menu

  @emptytest
  Scenario: Lets run a completely empty test
    Given I am the boss