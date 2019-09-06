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


Feature: Account Groups Version History
    I want to verify version history

    Scenario: Pre-req
        Given moduleName is "accountGroupsVersionHistory"
        And I reset my gwen.web.chrome.prefs setting
        And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
        And I login as "sde1" user
        And I go to the account group page
        And I create account group
            | testcaseNo | Account Group Type | Account Group Code | Email            | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description  | Bank Legal Entity | FX Rate Type | accounts              |
            | TC001      | Fund               | TESTFUNDNAME4      | test0005@hss.com | Default Group | ''       | ''         | ''                | ''        | TESTFUNDNAME4      | addresss0005 | description1 | ''                | ''           | TESTBBGD16;TESTBBGD17 |

    Scenario: Approve Fund
        And I login as "allAccess" user
        And I go to the account group page
        Then I approve account group "TESTFUNDNAME4"

    Scenario: Add OD Action to Strategy
        And I login as "sde1" user
        And I go to the account group page
        And I open group "TESTFUNDNAME4" to edit
        And I add new strategy
            | StrategyName               | ExecutionDays | ActionName | ActionType      | ExecutionWindow | Suggestions |
            | STRATEGY FOR TESTFUNDNAME4 | ''            | OD ACT     | Overdraft Check | 4 Days          | ''          |
        And I save changes to account group "TESTFUNDNAME4"

    Scenario: Approve Fund
        And I login as "functional3" user
        And I go to the account group page
        Then I approve account group "TESTFUNDNAME4"

    Scenario: Add and remove account
        And I navigate to home page
        And I go to the account group page
        And I open group to edit
            | GroupToEdit   | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
            | TESTFUNDNAME4 | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | TESTBBGD18  | ''            |
        And I navigate to account group page
        And I open group to edit
            | GroupToEdit   | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
            | TESTFUNDNAME4 | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | ''          | TESTBBGD18    |

    Scenario: Add Sweep Action to Strategy
        And I login as "sde1" user
        And I go to the account group page
        And I open group "TESTFUNDNAME4" to edit
        And I create "SWEEP ACT" action of type "Sweep" having execution window "4 Days" for "STRATEGY FOR TESTFUNDNAME4" strategy
            | Suggestion          | SuggestionValue |
            | Primary Currency    | BGD             |
            | BGD Primary Account | TESTBBGD16      |
        And I "include" all "PROPOSED" sweep pairs for "SWEEP ACT" action of "STRATEGY FOR TESTFUNDNAME4" strategy
        And I save changes to account group "TESTFUNDNAME4"

    Scenario: Approve Fund
        And I login as "functional3" user
        And I go to the account group page
        Then I approve account group "TESTFUNDNAME4"

    Scenario: Add account to fund
        And I open group to edit
            | GroupToEdit   | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
            | TESTFUNDNAME4 | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | TESTBBGD18  | ''            |

    Scenario: Approve Fund
        And I login as "sde1" user
        And I go to the account group page
        Then I approve account group "TESTFUNDNAME4"

    Scenario: Remove account from Fund
        And I navigate to home page
        And I go to the account group page
        And I open group to edit
            | GroupToEdit   | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
            | TESTFUNDNAME4 | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | ''          | TESTBBGD18    |

    Scenario: Account History Export
        And I navigate to account group page
        And I navigate to page of account group "TESTFUNDNAME4"
        And I verify account group history dashboard csv for "FUNDSWEEPSTRATACCREMPEND"





