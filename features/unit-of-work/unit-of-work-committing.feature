Feature: UnitOfWork Commits
  In order to register entity changes
  An UnitOfWork should be able to build a commit

  Scenario: Commit a single persisted entity
    Given a new UnitOfWork
    And a new object "example"
    And I persist the object "example"
    When I commit
    Then the object "example" is in the "insert" records
    And the number of records in the commit is 1

  Scenario: Commit multiple persisted entities
    Given a new UnitOfWork
    And a new object "example1"
    And a new object "example2"
    And I persist the object "example1"
    And I persist the object "example2"
    When I commit
    Then the object "example1" is in the "insert" records
    Then the object "example2" is in the "insert" records
    And the number of records in the commit is 2

  Scenario: Commit a single removed entity
    Given a new UnitOfWork
    And a new object "example"
    And I register the object "example"
    And I remove the object "example"
    When I commit
    Then the object "example" is in the "delete" records
    And the number of records in the commit is 1

  Scenario: Commit a multiple removed entities
    Given a new UnitOfWork
    And a new object "example1"
    And a new object "example2"
    And I register the object "example1"
    And I register the object "example2"
    And I remove the object "example1"
    And I remove the object "example2"
    When I commit
    Then the object "example1" is in the "delete" records
    Then the object "example2" is in the "delete" records
    And the number of records in the commit is 2

  Scenario: Commit a single changed entity
    Given a new UnitOfWork
    And a new object "example"
    And I register the object "example"
    And I change the object "example"
    When I commit
    Then the object "example" is in the "update" records
    And the number of records in the commit is 1

  Scenario: Commit multiple changed entities
    Given a new UnitOfWork
    And a new object "example1"
    And a new object "example2"
    And I register the object "example1"
    And I register the object "example2"
    And I change the object "example1"
    And I change the object "example2"
    When I commit
    Then the object "example1" is in the "update" records
    Then the object "example2" is in the "update" records
    And the number of records in the commit is 2

  Scenario: Commit without changes
    Given a new UnitOfWork
    And a new object "example"
    And I register the object "example"
    When I commit
    Then the number of records in the commit is 0

  Scenario: Commit with mixed changes
    Given a new UnitOfWork
    And a new object "example1"
    And a new object "example2"
    And a new object "example3"
    And I register the object "example1"
    And I change the object "example1"
    And I persist the object "example2"
    And I register the object "example3"
    And I remove the object "example3"
    When I commit
    Then the number of records in the commit is 3
    And the object "example1" is in the "update" records
    And the object "example2" is in the "insert" records
    And the object "example3" is in the "delete" records

  Scenario: Committing multiple times is redundant
    Given a new UnitOfWork
    And a new object "example"
    And I persist the object "example"
    When I commit
    And I commit again
    Then the commit is empty
