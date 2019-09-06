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

Feature: Test Remove / Remove All Buttons based on SI
  Test case for account group static
  As a cash manager,I want to verify remove/removeAll button after the sweep pair is excluded
  and I want to verify the warning message.

  Scenario: Load accounts for the New Fund
    Given moduleName is "exceptions"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "fund17user" user
    And I load account
      | fileName                |
      | STRAT-803-PAR-USD-ACC-1 |
      | STRAT-803-CHI-GBP-ACC-1 |
      | STRAT-803-CHI-GBP-ACC-2 |
      | STRAT-803-CHI-AUD-ACC-3 |
      | STRAT-803-CHI-AUD-ACC-4 |
      | STRAT-803-CHI-SGD-ACC-5 |
      | STRAT-803-CHI-SGD-ACC-6 |
    And I load fund
      | fileName       |
      | STRAT-803-FUND |

  Scenario: Create strategy to the fund and Including/Excluding Sweep Pairs
    And I login as "fund17user" user
    And I go to the account group page
    And I open group "STRAT-803" to edit
    And I create "MYACT" action of type "Sweep" having execution window "4 Days" for "Default strategy for 'STRAT-803'" strategy
      | Suggestion          | SuggestionValue |
      | Primary Currency    | USD             |
      | GBP Primary Account | GBP-803-CHI1    |
      | AUD Primary Account | AUD-803-CHI1    |
      | USD Primary Account | USD-803-PAR     |
      | SGD Primary Account | SGD-803-CHI1    |
    And I "include" all "PROPOSED" sweep pairs for "MYACT" action of "Default strategy for 'STRAT-803'" strategy

  Scenario: To test if Remove and RemoveAll button is invisible when Primary Account is selected
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I apply filter "SGD-803-CHI1" on accounts included in account group form
    And I verify "remove" button is "invisible"
    And I verify "removeAll" button is "invisible"

  Scenario: To test if Remove Button is Invisble for Primary Account but Remove All is visible when child Account is excluded
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I exclude sweep pair for "MYACT" action of "Default strategy for 'STRAT-803'" strategy
      | parentAccount | childAccount |
      | SGD-803-CHI1  | SGD-803-CHI2 |
    And I save changes to account group "STRAT-803"
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I select "SGD-803-CHI1" accounts included in account group form
    And I verify "remove" button is "invisible"
    And I verify "removeAll" button is "visible"
    And I save changes to account group "STRAT-803"

  Scenario: To test if Remove  and Remove All Button is visble for Primary Account
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I exclude sweep pair for "MYACT" action of "Default strategy for 'STRAT-803'" strategy
      | parentAccount | childAccount |
      | USD-803-PAR   | SGD-803-CHI1 |
    And I save changes to account group "STRAT-803"
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I select "SGD-803-CHI1" accounts included in account group form
    And I verify "remove" button is "visible"
    And I verify "removeAll" button is "visible"
    And I save changes to account group "STRAT-803"

  Scenario: To test Removal of Accounts for SGD currency and saving the fund
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I click removeAll button
    And I verify warning message that "2" accounts removed and "5" accounts can not be removed
    And I save changes to account group "STRAT-803"

  Scenario:Create strategy to the fund and Including/Excluding Sweep Pairs
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I exclude sweep pair for "MYACT" action of "Default strategy for 'STRAT-803'" strategy
      | parentAccount | childAccount |
      | AUD-803-CHI1  | AUD-803-CHI2 |
      | GBP-803-CHI1  | GBP-803-CHI2 |
    And I save changes to account group "STRAT-803"

  Scenario: To test if Remove and Remove all Buttons are visible when few pairs are excluded and few of them are Included
    And I login as "fund17user" user
    And I go to the account group page
    And I open group "STRAT-803" to edit
    And I select "AUD-803-CHI2;GBP-803-CHI2" accounts included in account group form
    And I verify "remove" button is "visible"
    And I verify "removeAll" button is "visible"

  Scenario: To test if Remove all Buttons is visible only when non excluded sweep pair is selected
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I select "AUD-803-CHI1" accounts included in account group form
    And I verify "removeAll" button is "visible"

  Scenario: To test if Remove and RemoveAll buttons are invisible when Included account is selected
    And I apply filter "AUD-803-CHI1" on accounts included in account group form
    And I verify "remove" button is "invisible"
    And I verify "removeAll" button is "invisible"

  Scenario: To tets if primary account is selected only RemoveAll button is available
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I select "USD-803-PAR" accounts included in account group form
    And I verify "remove" button is "invisible"

  Scenario: Removing Accounts using Remove and selecting all the accounts
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I remove accounts "AUD-803-CHI1;AUD-803-CHI2;GBP-803-CHI1;GBP-803-CHI2;USD-803-PAR" in account group form
    And I verify warning message that "2" accounts removed and "3" accounts can not be removed
    And I save changes to account group "STRAT-803"

  Scenario: Removing Accounts using RemoveAll
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I exclude sweep pair for "MYACT" action of "Default strategy for 'STRAT-803'" strategy
      | parentAccount | childAccount |
      | USD-803-PAR   | AUD-803-CHI1 |
    And I save changes to account group "STRAT-803"
    And I navigate to account group page
    And I open group "STRAT-803" to edit
    And I click removeAll button
    And I verify warning message that "1" accounts removed and "2" accounts can not be removed
