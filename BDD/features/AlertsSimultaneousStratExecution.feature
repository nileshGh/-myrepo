#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Date selection specific functions (without js)
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#cash flow loading specific functions (without js)
@Import("BDD\features-meta\loadingCashFlows.meta")
#functions related to load account
@Import("BDD\features-meta\fund.meta")
#Strategy specific functions
@Import("BDD\features-meta\strategy.meta")
#Roles specific functions
@Import("BDD\features-meta\roles.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#Alert new specific functions
@Import("BDD\features-meta\alert.meta")
#NEW Favorite specific functions
@Import("BDD\features-meta\favorite.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")

Feature: Alerts Simultaneous Strat Execution
  Test case for to test
  prdouction bugs are resolved

  Scenario:Prereq
    Given moduleName is "alertsSimultaneousStratExecution"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "fund628user" user
    And I go to the account group page
    And I load fund
      | fileName      |
      | CMS11696_FUND |
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description    | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | TSTALERT1   | ''                 | ''                 | ''    | FND628GRP | ''       | ''         | ''                | ''        | ''                 | ''      | TSTALERT1 Desc | ''                | ''           | ''          | ''            |

  Scenario:Alerts-174-No open alerts present.Load 2 Strategies for fund ALERTFND31 at the same time and check both the alerts with same Strat Exec Time are present on UI with status as Open
    And I update CBD for "TESTHSST" region to "16-OCT-15"
    And I load cashflow
      | fileName         | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | CMS11696_ACTUAL1 | TESTBBGD8 | 337351      | -6000   | 12000  | 1003          | 25/10/2016   |
      | CMS11696_ACTUAL2 | TESTBBGD9 | 337352      | -6000   | 12000  | 1003          | 25/10/2016   |
    And I load messages from "alertsSimultaneousStratExecution"
    And I update CBD for "TESTHSST" region to "SYSDATE"
    And I login as "fund628user" user
    And I wait 5 seconds
    And I go to the alert page
    And I verify all alerts have same execution time
    And I verify alert result for "TC001"

  Scenario:Alerts-175-Load 1 Strategy for fund 'ALERTFND31'  and check this new one is open and the previous 2 are closed
    And I update CBD for "TESTHSST" region to "16-OCT-15"
    And I load strategy
      | fileName          |
      | CMS11696_Strategy |
    And I navigate to home page
    And I update CBD for "TESTHSST" region to "SYSDATE"
    And I go to the alert page
    And I verify alert result for "TC002"

  Scenario:Alerts-176-One open alert present. Load 2 Strategies for fund ALERTFND31 at the same time and check both the alerts are with same Strat Exec Time are present on UI one with status as Open and other with status as closed. The previous open alert should be closed
    And I update CBD for "TESTHSST" region to "16-OCT-15"
    And I load messages from "alertsSimultaneousStratExecution"
    And I navigate to home page
    And I update CBD for "TESTHSST" region to "SYSDATE"
    And I go to the alert page
    And I verify alert result for "TC003"

  Scenario:Alerts-177-Two open alerts should be present.Load a cashflow for account ALERTACC311 in such a way that balance from CBD-CBD+4 is positive and then load 2 Strategies again. Both the alerts are with same Strat Exec Time are present on UI with status as Open for only account ALERTACC312 and the previous ones should be closed
    And I update CBD for "TESTHSST" region to "16-OCT-15"
    And I load cashflow
      | fileName         | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | CMS11696_ACTUAL3 | TESTBBGD8 | 337355      | 6000    | 12000  | 1003          | 25/10/2016   |
    And I load messages from "alertsSimultaneousStratExecution"
    And I navigate to home page
    And I update CBD for "TESTHSST" region to "SYSDATE"
    And I go to the alert page
    And I enter alert filter "Status:OPEN"
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I verify alerts csv for "TC004"

  Scenario:Alerts-178-Two open alerts should be present.Load a cashflow for account ALERTACC312 in such a way that balance from CBS-CBD+4 is positive and then load 2 Strategies again. Previous both ones should get closed and no new alert should be created
    And I update CBD for "TESTHSST" region to "16-OCT-15"
    And I load cashflow
      | fileName         | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | CMS11696_ACTUAL4 | TESTBBGD9 | 337356      | 6000    | 12000  | 1003          | 25/10/2016   |
    And I load messages from "alertsSimultaneousStratExecution"
    And I navigate to home page
    And I update CBD for "TESTHSST" region to "SYSDATE"
    And I go to the alert page
    And I verify alert result for "TC005"

  Scenario: Resotring CBD to default
    And I update CBD for "TESTHSST" region to "16-OCT-15"
