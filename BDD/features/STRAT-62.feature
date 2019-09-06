@ladder @Smoke @regression
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#loading Cashflows
@Import("BDD\features-meta\loadingCashFlows.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")
#alert specific functions
@Import("BDD\features-meta\alert.meta")
@Import("BDD\features-meta\alertPreview.meta")
#NEW Cash tlmview grid specific functions
@Import("BDD\features-meta\gridLib.meta")
#NEW Cash tlmviewDashboard specific functions
@Import("BDD\features-meta\tlmviewDashboard.meta")

Feature: STRAT-62
  Test case
  As a cash manager I am validating account feeds

  Scenario:Successful Account load feed even without Account number in static feeds
    Given I load account "STRAT62-AccountWithoutNumber"
    And I validate account "1TESTJIRA62" has account number "NULL"

  Scenario:Update a Account to add Account number, to an account not having it already
    Given I load account "STRAT62-AccountWithAccNumber"
    And I validate account "1TESTJIRA62" has account number "1STRAT62"

  Scenario: Update a Account to update Account number, to an account having it already
    Given I load account "STRAT62-AccountWithUpdatedAccNumber"
    And I validate account "1TESTJIRA62" has account number "STRAT"

  Scenario:Update a Account to remove Account number, to an account having it already
    Given I load account "STRAT62-AccountWithRemoveAccNumber"
    And I validate account "1TESTJIRA62" has account number "NULL"
