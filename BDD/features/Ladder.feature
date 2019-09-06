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
#timeline meta
@Import("BDD\features-meta\timeline.meta")

Feature: Ladder
  Test case for cash ladder
  As a cash manager
  I want to verify cash ladder

  Scenario: TC1 Verify navigation to Cash ladder page and verify page with default perspective
    Given moduleName is "ladder"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "functional" user
    And fund menu should not be displayed
    And strategy menu should not be displayed
    And I go to the ladder page
    And I verify timeline sidebar button is not visible
    And I verify cbd for user "functional" is "23/09/2017"
    And I verify start date is equal to "September 23, 2017"
    And difference between start and end date is of "10" days
    And I select perspective "Fund/Currency/Account/Category"
    And I verify balances csv for "TC016"

  Scenario: I set balanceTypes
    Given I am on the ladder page
    And I select balanceType "Opening Statement Balance - STANDARD:Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Forecasted Balance - STANDARD:Confirmed inc Opening - STANDARD:Opening Statement Balance - CUMULATIVE:Projected Balance - CUMULATIVE:Confirmed (Matched) cash events - CUMULATIVE:Forecasted Balance - CUMULATIVE:Confirmed inc Opening - CUMULATIVE"

  Scenario Outline: Verify that ladder shows correct balances for given date range , perspective and balance types
    Given I am on the ladder page
    And I set ladder daterange from "<startingDate>" to "<endingDate>"
    And I set perspective "<perspective>"
    And I sort <sortWith> "<sortOn>"
    And I set balanceType "<balanceType>"
    And I verify balances csv for "<testcaseNo>"

    @Smoke
    Examples:
      | testcaseNo | startingDate | endingDate | perspective                    | balanceType                                                                                                                                                                                                                                                                                                                                                       | sortWith   | sortOn                         |
      | TC018      | 22/09/2017   | 28/09/2017 | Fund/Currency/Account/Category | Opening Statement Balance - STANDARD:Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Forecasted Balance - STANDARD:Confirmed inc Opening - STANDARD:Opening Statement Balance - CUMULATIVE:Projected Balance - CUMULATIVE:Confirmed (Matched) cash events - CUMULATIVE:Forecasted Balance - CUMULATIVE:Confirmed inc Opening - CUMULATIVE | ascending  | Fund,Currency,Account,Category |
      | TC019      | 22/09/2017   | 28/09/2017 | Fund/Currency/Account          | Opening Statement Balance - STANDARD:Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Forecasted Balance - STANDARD:Confirmed inc Opening - STANDARD:Opening Statement Balance - CUMULATIVE:Projected Balance - CUMULATIVE:Confirmed (Matched) cash events - CUMULATIVE:Forecasted Balance - CUMULATIVE:Confirmed inc Opening - CUMULATIVE | descending | Fund,Currency,Account          |
      | TC020      | 25/09/2017   | 28/09/2017 | Fund/Currency/Account/Category | Opening Statement Balance - STANDARD:Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Forecasted Balance - STANDARD:Confirmed inc Opening - STANDARD:Opening Statement Balance - CUMULATIVE:Projected Balance - CUMULATIVE:Confirmed (Matched) cash events - CUMULATIVE:Forecasted Balance - CUMULATIVE:Confirmed inc Opening - CUMULATIVE | descending | Fund,Currency,Account,Category |
      | TC021      | 25/09/2017   | 28/09/2017 | Fund/Currency/Account          | Opening Statement Balance - STANDARD:Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Forecasted Balance - STANDARD:Confirmed inc Opening - STANDARD:Opening Statement Balance - CUMULATIVE:Projected Balance - CUMULATIVE:Confirmed (Matched) cash events - CUMULATIVE:Forecasted Balance - CUMULATIVE:Confirmed inc Opening - CUMULATIVE | ascending  | Fund,Currency,Account          |

  Scenario: TC114 To test pagination on ladder page
    And I login as "functional" user
    And I go to the ladder page
    And I remove sort on "Fund,Currency,Account,Category"
    And I go to page "3"
    And I sort descending "Fund,Currency"
    And I verify current page is "3"
    And I remove sort on "Fund,Currency"
    And I verify current page is "3"
