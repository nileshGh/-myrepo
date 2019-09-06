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
#sweep page specific functions
@Import("BDD\features-meta\sweepPage.meta")

Feature: Only SI no alert and sweep generation for an amount which is 15 characters
  Test case for cash ladder
  As a cash manager I am validating
  1.Alerts to be generated even if CBD is holiday
  2.SI should be successful even if the Parent and Main account has no balance
  3.Sweep/Top should not be done for subsequent dates in range, if one of the Sweep/Top Fail

  Scenario:Pre-req
    Given moduleName is "strat125"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"

  Scenario:Remove default strategy in account group
    Given I login as "fund6user" user
    And I go to the account group page
    And I enter accounts group filter "Code:=FND6"
    And I open group "FUND6" to edit
    And I remove action "Default Action" for "Default strategy for 'FND6'" strategy
    And I create "SI EXEC" action of type "Sweep" having execution window "6 Days" for "Default strategy for 'FND6'" strategy
      | Suggestion          | SuggestionValue |
      | Primary Currency    | USD             |
      | AED Primary Account | FND6AEDP1       |
      | AUD Primary Account | FND6AUDP1       |
      | CAD Primary Account | FND6CADP1       |
      | GBP Primary Account | FND6GBPP1       |
      | HKD Primary Account | FND6HKDP1       |
      | JPY Primary Account | FND6JPYP1       |
      | USD Primary Account | FND6USDM        |
    And I "include" all "PROPOSED" sweep pairs for "SI EXEC" action of "Default strategy for 'FND6'" strategy
    And I exclude sweep pair for "SI EXEC" action of "Default strategy for 'FND6'" strategy
      | parentAccount | childAccount |
      | FND6AEDP1     | FND6AEDC2    |
      | FND6USDM      | FND6AUDP1    |

  ##   Scenario: Approve account group
  ##     Given I login as "functional" user
  ##     And I go to the account group page
  ##     Then I approve account group "FUND6"

  Scenario: Execute strategy
    And I load strategy
      | fileName       |
      | Strategy_FUND6 |

  Scenario: Validate balances on ladder after strategy execution with perspective "Fund/Currency/Account/Category"
    Given testcaseName is "TC001"
    And I login as "fund6user" user
    And I go to the ladder page
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD"
    And I verify balances csv for "${testcaseName}"

  Scenario Outline: Verify transaction ladder for selected balance from ladder
    Given I am on the ladder page
    And I select balanceType "<balanceType>"
    And I apply ladder filter "<filter>"
    And I open transaction details of "<ofdate>" and "<ofperspective>"
    And I check showAllTransactions
    And I sort ascending "Amount,Trade Type"
    And I remove ladder filter for "<filter>"
    And I extract transaction csv for "<testcaseNo>"

    @smoke
    Examples:
      | testcaseNo | balanceType                                | ofdate                                                | ofperspective           | filter            |
      | TC002      | Confirmed (Matched) cash events - STANDARD | 19/09/2018 Confirmed (Matched) cash events - STANDARD | FND6:USD:FND6USDM:SWEEP | Account:=FND6USDM |

  Scenario: Get transaction history of sweeped transaction
    And I open transaction history details for transaction with "Amount" "-123,456,788,157,510.660"
    And I extract transaction history csv for "TC003"

  Scenario: Verify alerts are not generated
    And I update CBD for "FUND6REGION" region to "SYSDATE-3"
    And I navigate to home page
    And I go to the alert page
    And I verify there are no alerts available

  Scenario: Validate sweep dashboard after strategy execution
    Given testcaseName is "TC004"
    And I update CBD for "FUND6REGION" region to "19-SEP-18"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND6"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testcaseName}"
