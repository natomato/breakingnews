Feature: breakingnews automatically updates

As a user
I want the latest news to automatically refresh
So that I dont have to worry about missing a story

Scenario: visit website
  Given I am viewing the breakingnews page
  When A news story is posted on "www.cnn.com"
  Then I should see the story on the page
