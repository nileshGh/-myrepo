#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")
#strategy groups
@Import("BDD\features-meta\strategy.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")

Feature: Account Groups Static strat543
  Test case for account group static
  As a cash manager,I want to verify user access


  Scenario: Verify user with Static data editor role should be able to view details about the fund and should not have the ability to view a strategy on that fund
    Given I login as "fund21user" user
    And I load account
      | fileName    |
      | ACCOUNT5431 |
      | ACCOUNT5432 |
      | ACCOUNT5433 |
      | ACCOUNT5434 |
      | ACCOUNT5435 |
    And I go to the account group page
    And I navigate to page of account group "FUND21"
    And I verify account group have "Fund" "FND21" "QaAutomation@smartstream-stp.com" "FND21GRP" "''" "''" "Full" "FUND21" "Fund21 Address" "''" "''" "''" "''"
    Then I verify user can not view strategySection

  Scenario: Verify user with Static data editor should be able create a fund but should not have the ability to create a strategy on that fund
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email            | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description  | Bank Legal Entity | FX Rate Type | accounts    |
      | TC001      | Fund               | AUTOCODE120015     | test0125@hss.com | Default Group | ''       | ''         | ''                | ''        | AUTOFUND213        | addresss0005 | description1 | ''                | ''           | ACCOUNT5435 |
    And I navigate to page of account group "AUTOFUND213"
    Then I verify user can not view strategySection


  Scenario: Verify user with Static data editor should be able edit a fund but should not have the ability to create a strategy on that fund
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description  | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | AUTOFUND213 | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | description2 | ''                | ''           | ACCOUNT5434 | ACCOUNT5435   |
    And I navigate to page of account group "AUTOFUND213"
    Then I verify user can not view strategySection

  Scenario: Verify user with Static data supervisor role should be able to view details about the fund and should not have the ability to view a strategy on that fund
    Given I login as "fund22user" user
    And I go to the account group page
    And I navigate to page of account group "FUND22"
    And I verify account group have "Fund" "FND22" "QaAutomation@smartstream-stp.com" "FND22GRP" "''" "''" "Full" "FUND22" "Fund22 Address" "''" "''" "''" "''"
    Then I verify user can not view strategySection

  Scenario: Verify user with Static data supervisor should be able create a fund but should not have the ability to create a strategy on that fund
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email            | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description  | Bank Legal Entity | FX Rate Type | accounts    |
      | TC002      | Fund               | AUTOCODE220015     | test0235@hss.com | Default Group | ''       | ''         | ''                | ''        | AUTOFUND335        | addresss0025 | description1 | ''                | ''           | ACCOUNT5432 |
    And I navigate to page of account group "AUTOFUND335"
    Then I verify user can not view strategySection

  Scenario: Verify user with Static data supervisor should be able edit a fund but should not have the ability to create a strategy on that fund
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description  | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | AUTOFUND335 | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | description2 | ''                | ''           | ACCOUNT5431 | ACCOUNT5432   |
    And I navigate to page of account group "AUTOFUND335"
    Then I verify user can not view strategySection

  Scenario: Verify user with Strategy Configurer role should be able to view details about the fund and should have the ability to view a strategy on that fund
    Given I login as "fund23user" user
    And I go to the account group page
    And I navigate to page of account group "FUND23"
    And I verify account group have "Fund" "FND23" "QaAutomation@smartstream-stp.com" "FND23GRP" "''" "''" "Full" "FUND23" "Fund23 Address" "''" "''" "''" "''"
    And strategySection should be displayed
