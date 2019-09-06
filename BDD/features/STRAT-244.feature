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

Feature: Cannot move any further back, No balance with Parent/Main, Holiday on CBD
  Test case for cash ladder
  As a cash manager I am validating
  1.Alerts to be generated even if CBD is holiday
  2.SI should be successful even if the Parent and Main account has no balance
  3.Sweep/Top should not be done for subsequent dates in range, if one of the Sweep/Top Fail

  Scenario:Pre-req
    Given moduleName is "strat244"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"


  Scenario: Validate balances on ladder after strategy execution with perspective "Fund/Currency/Account"
    Given testcaseName is "TC001"
    And I login as "fund8user" user
    And I load messages from "Fund8Strategy"
    And I go to the ladder page
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD"
    And I verify balances csv for "${testcaseName}"

  Scenario: Validate alert dashboard after strategy execution
    Given testcaseName is "TC002"
    And I update CBD for "FUND8REGION" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And  I sort ascending "Fund/Account"
    And I verify alerts csv for "${testcaseName}_AlertDashboard"
    And I collapse all rows on alert

  Scenario: Validate sweep dashboard after strategy execution
    Given testcaseName is "TC003"
    And I update CBD for "FUND8REGION" region to "28-OCT-18"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND8"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testcaseName}"

  Scenario: Multi Filter
    Given testcaseName is "TC004"
    And I navigate to home page
    And I go to the sweeps page
    And I apply filter on sweep
      | filterWith                                                     |
      | Fund Group:FND8GRP                                             |
      | Fund Code:FND8                                                 |
      | Fund Name:FUND8                                                |
      | Child Account Code:FND8CADP1                                   |
      | Child CCY:CAD                                                  |
      | Child Balance:22775.2                                          |
      | Transaction Type (Top/Sweep or FX):FX_SWEEP                    |
      | Status:Aborted                                                 |
      | From Account Code:FND8CADP1                                    |
      | From CCY:CAD                                                   |
      | From Amount:0                                                  |
      | To Account Code:FND8USDM                                       |
      | To CCY:USD                                                     |
      | To Amount:0                                                    |
      | From Agent Bank Name/FX Sell:BANKCAD                           |
      | From Agent Bank BIC:BANKCAD0001A                               |
      | To Agent Bank Intermediary BIC:BANKUSDT                        |
      | To Agent Bank Intermediary A/C#:USD12345                       |
      | To Agent Bank Name/FX Buy:BANKUSD                              |
      | To Agent Bank BIC:BANKUSD0001A                                 |
      | Exchange Rate:1                                                |
      | Remarks:Operation is not possible, as there is no FX available |
    And I verify default sweeps csv for "${testcaseName}"

  Scenario: STRAT-461 To Verify whether "No Actions" sweeps are not displayed on the sweep dashboard
    Given testcaseName is "TC005"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Code:FND8"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify default sweeps csv for "${testcaseName}"

  Scenario: STRAT-582 TC21 Verify that sweep dashboard shows correct sweeps for various flavours of filtering
    Given testcaseName is "TC006"
    And I navigate to home page
    And I go to the sweeps page
    And I apply filter on sweep
      | filterWith                              |
      | Fund Group:/*FND8                       |
      | Child Account Code:*AED*                |
      | Fund Code:!=FND9                        |
      | Status:/*Pro                            |
      | From Amount:25000<>100000               |
      | To Amount:<=100000                      |
      | To Agent Bank Intermediary A/C#:12345*/ |
      | To Account Code:!!FND8AEDP1             |
      | Transaction Type (Top/Sweep or FX):=TOP |
      | Child Balance:<-22220                   |
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testcaseName}"

  Scenario:  STRAT-582 TC22 Verify that sweep dashboard shows correct balances for filtering using greater than sign on numerical values
    Given testcaseName is "TC007"
    And I navigate to home page
    And I go to the sweeps page
    And I apply filter on sweep
      | filterWith           |
      | Fund Code:=FND8      |
      | Child Balance:>20000 |
      | To Amount:>=160000   |
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify default sweeps csv for "${testcaseName}"

  Scenario: STRAT-582 TC23 Verify that sweep dashboard shows correct balances for filtering on numerical values
    Given testcaseName is "TC008"
    And I navigate to home page
    And I go to the sweeps page
    And I apply filter on sweep
      | filterWith       |
      | Fund Code:=FND8  |
      | From Amount:!=0  |
      | To Amount:=16000 |
    And I verify default sweeps csv for "${testcaseName}"

  Scenario:STRAT-119 TC17 Verify only cash manager role user can see the sweep
    And I login as "ocm" user
    And I go to the sweeps page
    And first row of sweepsGrid should be displayed
