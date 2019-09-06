@roles  @Smoke   @regression
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
#sweep page specific functions
@Import("BDD\features-meta\sweepPage.meta")

Feature: User Roles
  Test case for roles
  I will login as different user
  To test the roles asssign to it

  Scenario:Known Issue CMS-9818. TC1,2 Verify cash manager role
    Given moduleName is "userRoles"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "ocm" user
    And I go to the ladder page
    And I navigate to home page
    And I go to the alert page
    And I navigate to home page
    And I go to the account group page
    And I verify user can not create fund
    And I verify user can not edit fund "HSBC PENSION FUND"

  Scenario:Known Issue CMS-9818. TC3,4 Verify cash manager supervisor role
    And I login as "ocms" user
    And I go to the ladder page
    And I navigate to home page
    And I go to the alert page
    And I navigate to home page
    And I go to the account group page
    And I verify user can not create fund
    And I verify user can not edit fund "HSBC PENSION FUND"


  Scenario:TC5 Verify static data editor role
    And I login as "sde1" user
    And I go to the account group page
    And I verify user can create fund
    And I verify user can edit fund "HSBC PENSION FUND"


  Scenario:TC6 Verify static data supervisor role
    And I login as "sds1" user
    And I go to the account group page
    And I verify user can create fund
    And I verify user can edit fund "HSBC PENSION FUND"


  Scenario:TC7 Verify static data supervisor role
    And I login as "ocon" user
    And I go to the group management page
    And I verify user can create group
    And I verify user can edit group "Default Group"

  Scenario:TC8 Verify Group super user role having no group asssign
    And I login as "ogsu" user
    And I go to the ladder page
    And I verify all groups are displayed
    And I select group as "Default Group:HPF Group:HDF Group"
    And I verify balances csv for "TC001"
    And I navigate to home page
    And I go to the alert page
    And I verify all groups are displayed on alerts dashboard

  Scenario:TC9 Verify Group super user role having only one group asssign
    And I login as "functional" user
    And I go to the group management page
    And groupName is "HPF Group"
    And I edit attributes of group
      | groupName | groupDescription      | selectUser | removeUser |
      | HPF Group | HPF Group Description | OGSU       | ''         |
    And I login as "ogsu" user
    And I go to the ladder page
    And I verify all groups are displayed
    And I select group as "HPF Group"
    And I verify balances csv for "TC002"

  Scenario: TC10 Verify ladder for ngu user
    And I login as "ngu" user
    And I go to the ladder page
    And I should not get data on ladder
    And I navigate to home page
    And I go to the alert page
    And I verify there are no alerts available

  Scenario: Resotring group users to defaults
    And I login as "functional" user
    And I go to the group management page
    And I edit attributes of group
      | groupName | groupDescription      | selectUser | removeUser |
      | HPF Group | HPF Group Description | ''         | OGSU       |
