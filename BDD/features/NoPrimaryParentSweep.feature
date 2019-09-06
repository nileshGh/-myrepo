@tlmViewDashBoard
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#NEW Cash tlmview grid specific functions
@Import("BDD\features-meta\gridLib.meta")
#NEW Cash tlmviewDashboard specific functions
@Import("BDD\features-meta\tlmviewDashboard.meta")
#Ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#Various utilities
@Import("BDD\features-meta\loadingCashFlows.meta")
#Alert new specific functions
@Import("BDD\features-meta\alert.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Favorite specific functions
@Import("BDD\features-meta\favorite.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")
#Strategy specific functions
@Import("BDD\features-meta\strategy.meta")
#sweep page specific functions
@Import("BDD\features-meta\sweepPage.meta")


Feature: No Primary Parent Sweep
  Test cases
  I want to verify sweeps are getting
  generated even when primary currency is not selected

  Scenario: Pre-req
    Given moduleName is "noPrimaryParentSweep"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "fund20user" user
    And I go to the account group page

  Scenario:STRAT-651/690/701/718 Verify select accounts but not primary currency multi currency
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group    | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description   | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND20      | ''                 | ''                 | ''    | FND20GRP | ''       | ''         | ''                | ''        | ''                 | ''      | description20 | ''                | ''           | ''          | ''            |
    And I navigate to account group page
    And I open group "FUND20" to edit
    And I create "MYACT2" action of type "Sweep" having execution window "3 Days" for "Default strategy for 'FND20'" strategy
      | Suggestion          | SuggestionValue |
      | AED Primary Account | FND20AEDP1      |
      | AUD Primary Account | FND20AUDP1      |
      | CAD Primary Account | FND20CADP1      |
      | GBP Primary Account | FND20GBPP1      |
      | HKD Primary Account | FND20HKDP1      |
      | JPY Primary Account | FND20JPYP1      |
      | USD Primary Account | FND20USDM       |

  Scenario:STRAT-651/690/701/718 Verify select accounts but not primary currency multi currency
    And I navigate to account group page
    And I open group "FUND20" to edit
    And I verify "0" error and "1" warning messages in popup
      | MessageType | Message                   | ActionName | StrategyName                 |
      | warning     | ${primaryCurrencyWarning} | MYACT2     | Default strategy for 'FND20' |
    And I navigate to account group page
    And I open group "FUND20" to edit
    And I verify "Primary Currency" suggest structure field warning "${primaryCurrencyWarning}" for "MYACT2" action of "Default strategy for 'FND20'" strategy
    And I verify in suggest structure "Primary Currency" has value "" for "Default strategy for 'FND20'" strategy with "MYACT2" action
    And I verify sweep pair for strategy "Default strategy for 'FND20'" having action "MYACT2" should be present
    And I save changes to account group "FUND20"
    And I verify sweep pair dashboard csv extract for "MYACT2" action of "Default strategy for 'FND20'" strategy as "TC005_beforeInclude"
    And I navigate to account group page
    And I open group "FUND20" to edit
    And I "include" all "PROPOSED" sweep pairs for "MYACT2" action of "Default strategy for 'FND20'" strategy
    And I verify options of sweep pair for "MYACT2" action of "Default strategy for 'FND20'" strategy
      | sweepPairs                          | include | exclude |
      | '':FND20AEDP1;FND20AEDP1:FND20AEDC1 | absent  | absent  |
      | '':FND20AUDP1;FND20AUDP1:FND20AUDC1 | absent  | absent  |
    And I save changes to account group "FUND20"
    And I verify sweep pair for strategy "Default strategy for 'FND20'" having action "MYACT2" should be present
    And I verify in suggest structure "Primary Currency" has value "" for "Default strategy for 'FND20'" strategy with "MYACT2" action
    And I verify sweep pair dashboard csv extract for "MYACT2" action of "Default strategy for 'FND20'" strategy as "TC005"

  Scenario:STRAT-690/701 triggerring strategy for primary currency not selected in multi currency fund
    And testCaseNo is "STRAT-690-TC001"
    And I load cashflow
      | fileName   | accountNo  | referenceNo    | ammount | calKey | overallStatus | startingDate |
      | FND20-AED1 | FND20AEDC1 | FND20AEDC1TXN1 | -3000   | 12000  | 1003          | 29/10/2018   |
      | FND20AUDC1 | FND20AUDC1 | FND20AUDC1TXN1 | -4000   | 12000  | 1003          | 29/10/2018   |
      | FND20GBPC1 | FND20GBPC1 | FND20GBPC1TXN1 | 5000    | 12000  | 1003          | 29/10/2018   |
    And I load strategy
      | fileName      |
      | FND20Strategy |
    And I update CBD for "FUND20REGION" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I verify alerts csv for "${testCaseNo}_AlertDashboard"
    And I update CBD for "FUND20REGION" region to "29-OCT-18"
    And I login as "fund20user" user
    And I go to the ladder page
    And I set ladder daterange from "29/10/2018" to "01/11/2018"
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Cashflows with open exceptions - STANDARD"
    And I verify balances csv for "${testCaseNo}_LadderDashboard"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND20"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testCaseNo}_SweepDashboard"

  Scenario:STRAT-651/690/701 Primary Currency is selected when viewing Structure generated without Primary Currency selected single currency
    And I login as "fund690user" user
    And I go to the account group page
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email           | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | accounts            |
      | TC001      | Fund               | FUND690            | FUND690@hss.com | FND690GRP | ''       | ''         | ''                | ''        | FUND690            | FUND690 | FUND690     | ''                | ''           | TESTBBGD6;TESTBBGD7 |
    And I open group "FUND690" to edit
    And I add new strategy
      | StrategyName         | ExecutionDays | ActionName | ActionType      | ExecutionWindow | Suggestions |
      | STRATEGY FOR FUND690 | ''            | ODACT      | Overdraft Check | 3 Days          | ''          |
    And I navigate to account group page
    And I open group "FUND690" to edit
    And I create "SWEEP ACT" action of type "Sweep" having execution window "4 Days" for "STRATEGY FOR FUND690" strategy
      | Suggestion          | SuggestionValue |
      | BGD Primary Account | TESTBBGD6       |
    And I navigate to account group page
    And I open group "FUND690" to edit
    And I verify "Primary Currency" suggest structure field warning "${primaryCurrencyWarning}" for "SWEEP ACT" action of "STRATEGY FOR FUND690" strategy
    And I verify save strategy button for "STRATEGY FOR FUND690" strategy is not visible
    And I verify in suggest structure "Primary Currency" has value "" for "STRATEGY FOR FUND690" strategy with "SWEEP ACT" action
    And I verify sweep pair for strategy "STRATEGY FOR FUND690" having action "SWEEP ACT" should be present
    And I save changes to account group "FUND690"
    And I verify sweep pair dashboard csv extract for "SWEEP ACT" action of "STRATEGY FOR FUND690" strategy as "TC006_beforeInclude"
    And I navigate to account group page
    And I open group "FUND690" to edit
    And I "include" all "PROPOSED" sweep pairs for "SWEEP ACT" action of "STRATEGY FOR FUND690" strategy
    And I save changes to account group "FUND690"
    And I verify sweep pair for strategy "STRATEGY FOR FUND690" having action "SWEEP ACT" should be present
    And I verify in suggest structure "Primary Currency" has value "" for "STRATEGY FOR FUND690" strategy with "SWEEP ACT" action
    And I verify sweep pair dashboard csv extract for "SWEEP ACT" action of "STRATEGY FOR FUND690" strategy as "TC006"

  Scenario:STRAT-690/701 triggerring strategy for primary currency not selected in single currency fund
    And testCaseNo is "STRAT-690-TC002"
    And I load cashflow
      | fileName   | accountNo | referenceNo   | ammount | calKey | overallStatus | startingDate |
      | FND690TXN1 | TESTBBGD7 | TESTBBGD7TXN1 | -5000   | 12000  | 1003          | 16/10/2015   |
    And I load strategy
      | fileName       |
      | FND690Strategy |
    And I update CBD for "TESTHSST" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I verify alerts csv for "${testCaseNo}_AlertDashboard"
    And I update CBD for "TESTHSST" region to "16-OCT-15"
    And I login as "fund690user" user
    And I go to the ladder page
    And I set ladder daterange from "16/10/2015" to "20/10/2015"
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Cashflows with open exceptions - STANDARD"
    And I verify balances csv for "${testCaseNo}_LadderDashboard"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND690"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testCaseNo}_SweepDashboard"

  Scenario: STRAT-125 To verify status as aborted for the sweep whose amount is more than 15 characters(with decimals)
    And testCaseNo is "STRAT-125-TC001"
    And I load cashflow
      | fileName        | accountNo | referenceNo    | ammount            | calKey | overallStatus | startingDate |
      | FND690TXN1_15WD | TESTBBGD7 | TESTBBGD7TXN11 | -50004567854646.67 | 12000  | 1003          | 16/10/2015   |
    And I load strategy
      | fileName       |
      | FND690Strategy |
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND690;Status:Aborted"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testCaseNo}_SweepDashboard"

  Scenario: STRAT-125 To verify status as aborted for the sweep whose amount is more than 15 characters(without decimals)
    And testCaseNo is "STRAT-125-TC002"
    And I load cashflow
      | fileName         | accountNo | referenceNo    | ammount           | calKey | overallStatus | startingDate |
      | FND690TXN1_15WOD | TESTBBGD7 | TESTBBGD7TXN10 | -5000456785464667 | 12000  | 1003          | 16/10/2015   |
    And I load strategy
      | fileName       |
      | FND690Strategy |
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND690;Status:Aborted"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testCaseNo}_SweepDashboard"
