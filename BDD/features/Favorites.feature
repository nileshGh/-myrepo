@alerts @Smoke @regression
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#Date selection specific functions (without js)
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#Alert new specific functions
@Import("BDD\features-meta\alert.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#NEW Favorite specific functions
@Import("BDD\features-meta\favorite.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")
#Strategy specific functions
@Import("BDD\features-meta\strategy.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")

Feature: Favorites
  Test case for favorites
  I want to verify favorites are working

  Scenario: TC01-6,TC8-13,15,20,21 To test add/remove to favorite on alert page
    Given moduleName is "favorites"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "functional" user
    And I go to the alert page
    And I add "alert" page to favorite
    And I verify favorite option "alert" on user profile screen
    And I verify import and export for "alert" favorite
    And I create favorite with duplicate name "alert"
    And I navigate to home page
    And I verify favorite "alert" working
    And I delete "alert" from favorite

  Scenario: TC7,16,17,23 To test add/remove to favorite on ladder
    And I navigate to home page
    ##WA##Temp Revision As discussed 12/11
    And I refresh the current page
    And I wait for page to load
    And I go to the ladder page
    And I set ladder daterange from "22/09/2017" to "28/09/2017"
    And selectedPerspective is "Fund/Currency/Account/Category"
    And I set perspective "Fund/Currency/Account"
    And I deselect group "HDF Group"
    And I select balanceType "Opening Statement Balance - STANDARD:Projected Balance - STANDARD"
    And I add "ladder" page to favorite
    And I navigate to home page
    And I verify favorite "ladder" working
    And I verify balanceType "Opening Statement Balance - STANDARD:Projected Balance - STANDARD"
    And I verify start date is equal to "September 22, 2017"
    And I verify end date is equal to "September 28, 2017"
    And I verify selected perspective is "Fund/Currency/Account"
    And I verify selected groups are "HPF Group:Default Group"
    And I verify group "HDF Group" does not exist
    And I login as "functional2" user
    And I verify favorite option "ladder" is not on user profile screen
    And I login as "functional" user
    And I verify favorite "ladder" working
    And I remove "ladder" page from favorite

  Scenario:Known Issue CMS-11269.
    And I navigate to home page
    ##WA##Temp Revision As discussed 12/11
    And I refresh the current page
    And I wait for page to load
    And I go to the ladder page
    And I set ladder daterange from "22/09/2017" to "28/09/2017"
    And selectedPerspective is "Fund/Currency/Account/Category"
    And I set perspective "Fund/Currency/Account"
    And I select balanceType "Opening Statement Balance - STANDARD:Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Forecasted Balance - STANDARD:Confirmed inc Opening - STANDARD:Opening Statement Balance - CUMULATIVE:Projected Balance - CUMULATIVE:Confirmed (Matched) cash events - CUMULATIVE:Forecasted Balance - CUMULATIVE:Confirmed inc Opening - CUMULATIVE"
    And I add "ladderIssue" page to favorite
    And I navigate to home page
    And I verify favorite "ladderIssue" working
    And I verify balanceType "Opening Statement Balance - STANDARD:Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Forecasted Balance - STANDARD:Confirmed inc Opening - STANDARD:Opening Statement Balance - CUMULATIVE:Projected Balance - CUMULATIVE:Confirmed (Matched) cash events - CUMULATIVE:Forecasted Balance - CUMULATIVE:Confirmed inc Opening - CUMULATIVE"
    And I verify start date is equal to "September 22, 2017"
    And I verify end date is equal to "September 28, 2017"
    And I verify selected perspective is "Fund/Currency/Account"
    And I verify selected groups are "HPF Group:Default Group:HDF Group"
    ##WA##Temp Revision As discussed 03/12
    And I refresh the current page
    And I wait for page to load
    And I sort descending "Fund,Currency,Account"
    And I verify balances csv for "TC002"
    And I delete "ladderIssue" from favorite

  Scenario:Known Issue CMS-11235. TC18 To test add/remove to favorite on fund page
    And I navigate to home page
    And I go to the account group page
    And I enter accounts group filter "Code:=HDF"
    And I sort ascending "Name"
    And I add "fund" page to favorite
    And I navigate to home page
    And I verify favorite "fund" working
    And I sort ascending "Name"
    And I verify account group dashboard csv for "TC001"
    And I delete "fund" from favorite

  Scenario: TC19,22 To test add/remove to favorite on groupManagment and strategy page
    And I navigate to home page
    ## And I go to the strategy page
    ## And I add "strategy" page to favorite
    And I navigate to home page
    And I go to the group management page
    And I add "group management" page to favorite
    ## And I verify favorite "strategy" working
    And I navigate to home page
    And I verify favorite "group management" working
    ## And I remove "strategy" page from favorite
    And I delete "group management" from favorite
