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


Feature: Account Group Single Save Button
  As statis data editor validating
  Single save button changes

  Scenario:TC04 Fund created with strategy, no validation errors, Fund And Strategy both get saved
    Given moduleName is "accountGroupsSinleSave"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "sde1" user
    And I go to the account group page
    And I fill create account group form
      | testcaseNo | Account Group Type | Account Group Code | Email                            | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address        | Description  | Bank Legal Entity | FX Rate Type | accounts   |
      | TC001      | Fund               | FND4891            | QaAutomation@smartstream-stp.com | Default Group | ''       | ''         | Full              | ''        | FND4891            | Fund16 Address | description1 | ''                | ''           | TESTBBGD10 |
    And I add new strategy
      | StrategyName         | ExecutionDays | ActionName | ActionType      | ExecutionWindow | Suggestions |
      | STRATEGY FOR FND4891 | ''            | OD ACT     | Overdraft Check | 3 Days          | ''          |
    And I navigate to account group page
    And I navigate to page of account group "FND4891"
    And I verify Type is having value "Overdraft Check" for "OD ACT" action of "STRATEGY FOR FND4891" strategy
    And I verify Execution Window is having value "3 Days" for "OD ACT" action of "STRATEGY FOR FND4891" strategy

  Scenario:TC05 Fund created with strategy, has validation errors in fund, Fund And Strategy both did not get saved
    And I navigate to account group page
    And I fill create account group form
      | testcaseNo | Account Group Type | Account Group Code | Email | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address        | Description  | Bank Legal Entity | FX Rate Type | accounts   |
      | TC002      | Fund               | FND4892            | ''    | Default Group | ''       | ''         | Full              | ''        | FND4892            | Fund16 Address | description1 | ''                | ''           | TESTBBGD11 |
    And I add new strategy of name "STRATEGY FOR FND4892" having "''" execution days
    And I add action "OD ACT" of type "Overdraft Check" having execution window "3 Days" for "STRATEGY FOR FND4892" strategy
    And I verify "1" error and "0" warning messages in popup
      | MessageType | Message                    | ActionName | StrategyName |
      | error       | Email Address is required. | ''         | ''           |
    And I navigate to account group page
    And I verify account group with "Name" as "FND4892" is not present

  Scenario:TC06C Fund created with strategy, has validation errors in strategy not in fund, Fund And Strategy both did not get saved
    And I navigate to account group page
    And I fill create account group form
      | testcaseNo | Account Group Type | Account Group Code | Email         | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address        | Description  | Bank Legal Entity | FX Rate Type | accounts   |
      | TC003      | Fund               | FND4893            | test@mail.com | Default Group | ''       | ''         | Full              | ''        | FND4893            | Fund16 Address | description1 | ''                | ''           | TESTBBGD11 |
    And I scroll to the top of strategiesHeader
    And I add new strategy of name "STRATEGY FOR FND4893" having "''" execution days
    And I add action "OD ACT" of type "Overdraft Check" having execution window "''" for "STRATEGY FOR FND4893" strategy
    And I verify "1" error and "0" warning messages in popup
      | MessageType | Message                       | ActionName | StrategyName |
      | error       | Execution window is required. | OD ACT     | ''           |
    And I navigate to account group page
    And I verify account group with "Name" as "FND4893" is not present

  Scenario:TC06B Fund created with strategy, has validation warnings in strategy not in fund, Fund And Strategy both did not get saved
    And I navigate to account group page
    And I fill create account group form
      | testcaseNo | Account Group Type | Account Group Code | Email         | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address        | Description  | Bank Legal Entity | FX Rate Type | accounts              |
      | TC004      | Fund               | FND4894            | test@mail.com | Default Group | ''       | ''         | Full              | ''        | FND4894            | Fund16 Address | description1 | ''                | ''           | TESTBBGD11;TESTBBGD12 |
    And I scroll to the top of strategiesHeader
    And I add new strategy of name "STRATEGY FOR FND4894" having "''" execution days
    And I add action "SWEEP ACT" of type "Sweep" having execution window "3 Days" for "STRATEGY FOR FND4894" strategy
    And I edit suggest structure with "BGD Primary Account:TESTBBGD11" for "STRATEGY FOR FND4894" strategy with "SWEEP ACT" action
    And I click on create suggestion for "SWEEP ACT" action of "STRATEGY FOR FND4894" strategy
    And I scroll to top of page
    And I click account group form cancelButton
    And I navigate to account group page
    And I verify account group with "Name" as "FND4894" is not present

  Scenario:TC06A Fund created with strategy, has validation warnings in strategy not in fund, Fund And Strategy both get saved
    And I navigate to account group page
    And I fill create account group form
      | testcaseNo | Account Group Type | Account Group Code | Email         | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address        | Description  | Bank Legal Entity | FX Rate Type | accounts              |
      | TC005      | Fund               | FND4895            | test@mail.com | Default Group | ''       | ''         | Full              | ''        | FND4895            | Fund16 Address | description1 | ''                | ''           | TESTBBGD11;TESTBBGD12 |
    And I scroll to the top of strategiesHeader
    And I add new strategy of name "STRATEGY FOR FND4895" having "''" execution days
    And I add action "SWEEP ACT" of type "Sweep" having execution window "3 Days" for "STRATEGY FOR FND4895" strategy
    And I edit suggest structure with "BGD Primary Account:TESTBBGD11" for "STRATEGY FOR FND4895" strategy with "SWEEP ACT" action
    And I click on create suggestion for "SWEEP ACT" action of "STRATEGY FOR FND4895" strategy
    And I save and confirm account group
    And I navigate to account group page
    And I navigate to page of account group "FND4895"
    And I verify Type is having value "Sweep" for "SWEEP ACT" action of "STRATEGY FOR FND4895" strategy
    And I verify Execution Window is having value "3 Days" for "SWEEP ACT" action of "STRATEGY FOR FND4895" strategy

  Scenario:Fund exists, strategy added, has validation warnings
    And I navigate to account group page
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email            | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description  | Bank Legal Entity | FX Rate Type | accounts              |
      | TC006      | Fund               | FND4896            | test0005@hss.com | Default Group | ''       | ''         | ''                | ''        | FND4896            | addresss0005 | description1 | ''                | ''           | TESTBBGD13;TESTBBGD14 |
    And I navigate to account group page
    And I open group "FND4896" to edit
    And I add new strategy of name "STRATEGY FOR FND4896" having "''" execution days
    And I add action "SWEEP ACT" of type "Sweep" having execution window "3 Days" for "STRATEGY FOR FND4896" strategy
    And I edit suggest structure with "BGD Primary Account:TESTBBGD13" for "STRATEGY FOR FND4896" strategy with "SWEEP ACT" action
    And I click on create suggestion for "SWEEP ACT" action of "STRATEGY FOR FND4896" strategy
    And I scroll to top of page
    And I click account group form cancelButton
    And I navigate to account group page
    And I open group "FND4896" to edit
    And I add new strategy
      | StrategyName | ExecutionDays | ActionName | ActionType      | ExecutionWindow | Suggestions |
      | MYSTRAT      | ''            | MYACT      | Overdraft Check | 3 Days          | ''          |

  Scenario:STRAT-798 No of warnings should be same as of actual after saving account group
    And I navigate to account group page
    And I open group "FND4896" to edit
    And I add action "SWEEP ACT" of type "Sweep" having execution window "3 Days" for "MYSTRAT" strategy
    And I click on create suggestion for "SWEEP ACT" action of "MYSTRAT" strategy
    And I verify "0" error and "2" warning messages in popup
      | MessageType | Message                                                                                  | ActionName | StrategyName |
      | warning     | ${primaryCurrencyWarning}                                                                | SWEEP ACT  | MYSTRAT      |
      | warning     | No FX/Sweep will be performed for BGD as Primary Accounts are not set for this currency. | SWEEP ACT  | MYSTRAT      |
    And I save changes to account group "FND4896"
    And I navigate to account group page
    And I open group "FND4896" to edit
    And I verify "0" error and "2" warning messages in popup
      | MessageType | Message                                                                                  | ActionName | StrategyName |
      | warning     | ${primaryCurrencyWarning}                                                                | SWEEP ACT  | MYSTRAT      |
      | warning     | No FX/Sweep will be performed for BGD as Primary Accounts are not set for this currency. | SWEEP ACT  | MYSTRAT      |