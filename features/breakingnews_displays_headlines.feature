Feature: breakingnews displays recent news

As a user
I want to view the latest news headlines
So that I can be informed about whats happening

Scenario: visit breakingnews page
  Given I am not yet viewing the breakingnews page
  When I navigate to the site
  Then I should see 5 headlines from "www.cnn.com"
  And I should see the first paragraph of the story


