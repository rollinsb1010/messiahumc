@sermons
Feature: Sermons
  In order to have sermons on my website
  As an administrator
  I want to manage sermons

  Background:
    Given I am a logged in refinery user
    And I have no sermons

  @sermons-list @list
  Scenario: Sermons List
   Given I have sermons titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of sermons
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @sermons-valid @valid
  Scenario: Create Valid Sermon
    When I go to the list of sermons
    And I follow "Add New Sermon"
    And I fill in "Speaker" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 sermon

  @sermons-invalid @invalid
  Scenario: Create Invalid Sermon (without speaker)
    When I go to the list of sermons
    And I follow "Add New Sermon"
    And I press "Save"
    Then I should see "Speaker can't be blank"
    And I should have 0 sermons

  @sermons-edit @edit
  Scenario: Edit Existing Sermon
    Given I have sermons titled "A speaker"
    When I go to the list of sermons
    And I follow "Edit this sermon" within ".actions"
    Then I fill in "Speaker" with "A different speaker"
    And I press "Save"
    Then I should see "'A different speaker' was successfully updated."
    And I should be on the list of sermons
    And I should not see "A speaker"

  @sermons-duplicate @duplicate
  Scenario: Create Duplicate Sermon
    Given I only have sermons titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of sermons
    And I follow "Add New Sermon"
    And I fill in "Speaker" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 sermons

  @sermons-delete @delete
  Scenario: Delete Sermon
    Given I only have sermons titled UniqueTitleOne
    When I go to the list of sermons
    And I follow "Remove this sermon forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 sermons
 