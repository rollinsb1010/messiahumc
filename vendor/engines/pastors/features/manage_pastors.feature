@pastors
Feature: Pastors
  In order to have pastors on my website
  As an administrator
  I want to manage pastors

  Background:
    Given I am a logged in refinery user
    And I have no pastors

  @pastors-list @list
  Scenario: Pastors List
   Given I have pastors titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of pastors
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @pastors-valid @valid
  Scenario: Create Valid Pastor
    When I go to the list of pastors
    And I follow "Add New Pastor"
    And I fill in "Name" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 pastor

  @pastors-invalid @invalid
  Scenario: Create Invalid Pastor (without name)
    When I go to the list of pastors
    And I follow "Add New Pastor"
    And I press "Save"
    Then I should see "Name can't be blank"
    And I should have 0 pastors

  @pastors-edit @edit
  Scenario: Edit Existing Pastor
    Given I have pastors titled "A name"
    When I go to the list of pastors
    And I follow "Edit this pastor" within ".actions"
    Then I fill in "Name" with "A different name"
    And I press "Save"
    Then I should see "'A different name' was successfully updated."
    And I should be on the list of pastors
    And I should not see "A name"

  @pastors-duplicate @duplicate
  Scenario: Create Duplicate Pastor
    Given I only have pastors titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of pastors
    And I follow "Add New Pastor"
    And I fill in "Name" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 pastors

  @pastors-delete @delete
  Scenario: Delete Pastor
    Given I only have pastors titled UniqueTitleOne
    When I go to the list of pastors
    And I follow "Remove this pastor forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 pastors
 