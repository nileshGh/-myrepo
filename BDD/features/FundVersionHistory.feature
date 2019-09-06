@fundAction  @Smoke @regression
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#functions related to export balances and verify with expected balances
@Import("BDD\features-meta\ladder.meta")
#Date selection specific functions (without js)
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#cash flow loading specific functions (without js)
@Import("BDD\features-meta\loadingCashFlows.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")

Feature:FundVersionHistory

   Scenario: Login to AccountGroupPage
      Given moduleName is "FundVersionHistory"
      And I reset my gwen.web.chrome.prefs setting
      And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
      And I login as "fund9user" user

   Scenario: Adding a new account to fund with No Strategy and Fund has previous Approved version
      Given I go to the account group page
      And I load account
         | fileName     |
         | FND4201AEDC1 |
         | FND4201AEDC2 |
         | FND4201AEDP1 |
         | FND4201USDM  |
         | FND4201USDC1 |
      And I open create account group form
      And I create account group
         | testcaseNo | Account Group Type | Account Group Code | Email            | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address         | Description          | Bank Legal Entity | FX Rate Type | accounts                              |
         | TC001      | Fund               | FND4201            | FUND4201@hss.com | Default Group | ''       | ''         | ''                | ''        | FUND4201           | FUND4201Address | FUND4201-Description | ''                | ''           | FND4201AEDC1;FND4201AEDP1;FND4201USDM |
      And I login as "cashManager" user
      And I go to the account group page
      And I approve account group "FUND4201"
      And I load fund "FND4201_1"
      And I navigate to home page
      And I go to the account group page
      And I navigate to page of account group "FUND4201"
      And I verify account group history dashboard csv for "TC001"

   Scenario: Removing an account to fund with No Strategy and Fund has previous Approved version
      Given I load fund "FND4201_2"
      And I navigate to account group page
      And I navigate to page of account group "FUND4201"
      And I verify account group history dashboard csv for "TC002"

   Scenario: Latest version Pending approval and previous version Approved and does not affect strategy
      Given I login as "fund9user" user
      And I go to the account group page
      And I open group to edit
         | GroupToEdit | Account Group Type | Account Group Code | Email            | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name   | Address            | Description                                                    | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
         | FUND4201    | Fund               | FND4201            | FUND4201@hss.com | Default Group | ''       | ''         | ''                | ''        | FUNDNAMECHANGEDVIAUI | FUND4201 - Address | Last version Pending approval and Second last version Approved | ''                | ''           | ''          | ''            |
      And I open group "FUNDNAMECHANGEDVIAUI" to edit
      And I add new strategy
         | StrategyName                   | ExecutionDays | ActionName | ActionType | ExecutionWindow | Suggestions                                                                           |
         | DEFAULT STRATEGY FOR 'FND4201' | ''            | MYACT      | Sweep      | 1 Day           | Primary Currency:USD;AED Primary Account:FND4201AEDP1;USD Primary Account:FND4201USDM |
      And I scroll to top of page
      And I load fund "FND4201_3"
      And I navigate to home page
      And I go to the account group page
      And I navigate to page of account group "FUNDNAMECHANGEDVIAUI"
      And I verify account group history dashboard csv for "TC007"

   Scenario: Adding a new account to fund with OverDraft Check Strategy and Fund has previous Approved version
      #Given I load fund "FND42_Inital_Setup"
      And I load fund "FND42_3"
      And I navigate to home page
      And I go to the account group page
      And I am on account group page
      And I navigate to page of account group "FUND42"
      And I verify account group history dashboard csv for "TC003"

   Scenario: Removing Account from fund with OverDraft Check Strategy and Fund has previous Pending Approval version
      And I login as "fund9user" user
      And I go to the account group page
      And I open group to edit
         | GroupToEdit | Account Group Type | Account Group Code | Email          | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address          | Description   | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
         | FUND42      | Fund               | FND42              | FUND42@hss.com | Default Group | ''       | ''         | ''                | ''        | FUND42             | FUND42 - Address | description42 | ''                | ''           | ''          | ''            |
      And I load fund "FND42_4"
      And I navigate to home page
      And I go to the account group page
      And I navigate to page of account group "FUND42"
      And I verify account group history dashboard csv for "TC004"

   Scenario: Adding a new account to fund with Strategy and Fund has last Pending Approval version
      Given I load fund "FND42_6_1"
      And I navigate to home page
      And I go to the account group page
      And I open group "FUND42" to edit
      And I add new strategy
         | StrategyName                 | ExecutionDays | ActionName | ActionType | ExecutionWindow | Suggestions                                                                       |
         | Default strategy for 'FND42' | 4             | MYACT      | Sweep      | 1 Day           | Primary Currency:USD;HKD Primary Account:FND42HKDP1;USD Primary Account:FND42USDM |
      And I "include" all "PROPOSED" sweep pairs for "MYACT" action of "Default strategy for 'FND42'" strategy
      And I load fund "FND42_6_2"
      And I navigate to home page
      And I go to the account group page
      And I navigate to page of account group "FUND42"
      And I verify account group history dashboard csv for "TC006"

   Scenario: Verifying Proposed status of Newly added account in Fund
      And I verify sweep pair dashboard csv extract for "MYACT" action of "Default strategy for 'FND42'" strategy as "TC008"

   Scenario: Removing Account from fund with Strategy and Fund has last Approved
      Given I login as "cashManager" user
      And I go to the account group page
      And I approve account group "FUND42"
      And I load fund "FND42_5"
      And I navigate to account group page
      And I navigate to page of account group "FUND42"
      And I verify account group history dashboard csv for "TC005"
