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

Feature: SI not executed for account having exception
  Test case for cash ladder
  As a cash manager I am validating
  1.Alerts to be generated even if CBD is holiday
  2.SI should be successful even if the Parent and Main account has no balance
  3.Sweep/Top should not be done for subsequent dates in range, if one of the Sweep/Top Fail

  Scenario:Pre-req
    Given moduleName is "strat73"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"

  Scenario: Execute strategy
    And I load strategy
      | fileName       |
      | Strategy_FUND9 |

  Scenario: Validate balances on ladder after strategy execution with perspective "Fund/Currency/Account/Category"
    Given testcaseName is "TC001"
    And I login as "fund9user" user
    And I go to the ladder page
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Cashflows with open exceptions - STANDARD"
    And I verify balances csv for "${testcaseName}"


  Scenario: Validate sweep dashboard after strategy execution
    Given testcaseName is "TC002"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND9"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testcaseName}"
