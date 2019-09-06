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


Feature:Account Groups and Strategy Editing
  Test cases
  As a cash manager
  I want to verify Fund Code,Fund Name,Email address is populated as Null in ALERT_CONFIG
  when the Fund is created via UI and edited to add Alert action later

  Scenario:STRAT-628 Create account group
    Given moduleName is "strat628"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "fund628user" user
    And I go to the account group page
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email                            | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | accounts            |
      | TC001      | Fund               | FND628             | QaAutomation@smartstream-stp.com | FND628GRP | ''       | ''         | ''                | ''        | FUND628            | Address | FUND628     | ''                | ''           | TESTBBGD1;TESTBBGD3 |

  Scenario:STRAT-628 Create strategy and add Sweep Action to the fund
    And I navigate to account group page
    And I open group "FUND628" to edit
    And I add new strategy
      | StrategyName         | ExecutionDays | ActionName | ActionType | ExecutionWindow | Suggestions                                        |
      | STRATEGY FOR FUND628 | ''            | SWEEP ACT  | Sweep      | 4 Days          | Primary Currency:BGD;BGD Primary Account:TESTBBGD1 |
    And I save changes to account group "FUND628"

  Scenario:STRAT-628 Add second sweep action to the fund
    And I navigate to account group page
    And I open group "FUND628" to edit
    And I add action "OD ACT" of type "Overdraft Check" having execution window "4 Days" for "STRATEGY FOR FUND628" strategy
    And I save changes to account group "FUND628"

  Scenario:STRAT-628 [AGD50] Then Fields like Code, Name, Email address should be populated in CMS_REF_ALERT_CONFIG  as provided on the UI
    And I navigate to account group page
    And I navigate to page of account group "FUND628"
    And I verify account group have "Fund" "FND628" "QaAutomation@smartstream-stp.com" "FND628GRP" "''" "''" "''" "FUND628" "Address" "FUND628" "''" "''" "TESTBBGD1;TESTBBGD3"
    And I get "select * from CMS_REF_ALERT_CONFIG where code='FND628'" query export "TC001"

  Scenario:STRAT-628 Create account group
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email                            | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | accounts            |
      | TC002      | Fund               | FND6282            | QaAutomation@smartstream-stp.com | FND628GRP | ''       | ''         | ''                | ''        | FUND6282           | Address | FUND6282    | ''                | ''           | TESTBBGD4;TESTBBGD5 |

  Scenario:STRAT-628 Create strategy and add Sweep Action to the fund
    And I navigate to account group page
    And I open group "FUND6282" to edit
    And I add new strategy
      | StrategyName          | ExecutionDays | ActionName | ActionType      | ExecutionWindow | Suggestions |
      | STRATEGY FOR FUND6282 | ''            | OD ACT     | Overdraft Check | 4 Days          | ''          |
    And I save changes to account group "FUND6282"
    And I get "select * from CMS_REF_ALERT_CONFIG where code='FND6282'" query export "TC002"

  Scenario:STRAT-628 Add second sweep action to the fund
    And I navigate to account group page
    And I open group "FUND6282" to edit
    And I create "SWEEP ACT" action of type "Sweep" having execution window "4 Days" for "STRATEGY FOR FUND6282" strategy
      | Suggestion          | SuggestionValue |
      | Primary Currency    | BGD             |
      | BGD Primary Account | TESTBBGD4       |
    And I save changes to account group "FUND6282"

  Scenario:STRAT-628 [AGD50] Then Fields like Code, Name, Email address should be populated in CMS_REF_ALERT_CONFIG  as provided on the UI
    And I navigate to account group page
    And I navigate to page of account group "FUND6282"
    And I verify account group have "Fund" "FND6282" "QaAutomation@smartstream-stp.com" "FND628GRP" "''" "''" "''" "FUND6282" "Address" "FUND6282" "''" "''" "TESTBBGD4;TESTBBGD5"
    And I get "select * from CMS_REF_ALERT_CONFIG where code='FND6282'" query export "TC003"
