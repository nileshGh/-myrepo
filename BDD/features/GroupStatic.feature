@groupmanagement
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")
#functions related to load account
@Import("BDD\features-meta\fund.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#Alert new specific functions
@Import("BDD\features-meta\alert.meta")
#loading Cashflows
@Import("BDD\features-meta\loadingCashFlows.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")
#timeline meta
@Import("BDD\features-meta\timeline.meta")

Feature: Group Static
  Test case for group management
  As a configurer
  I want to verify create/edit/delete operations on groups

  Scenario: TC16,18 Verify user has configurer role associated to it then option to create group is available to user on UI and check the headiings on UI
    Given moduleName is "groupStatic"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    Then I login as "functional" user
    And I go to the group management page
    And I verify timeline sidebar button is not visible
    And I check for the headings
      | heading     |
      | ID          |
      | Name        |
      | Description |

  Scenario: Creating the group
    And I create group
      | groupName   | groupDescription       | selectUser |
      | autogroup01 | autogroupdescription01 | HPF1       |
      | autogroup02 | autogroupdescription02 | CM1,CM2    |
      | autogroup03 | autogroupdescription03 | HDF1,HDF2  |

  Scenario: TC20 Verify updating group detail retains after refreshing the page
    And I edit attributes of group
      | groupName   | groupDescription          | selectUser | removeUser |
      | autogroup99 | newautogroupdescription99 | CM1        | ''         |
      | autogroup04 | newautogroupdescription04 | ''         | CM1        |

  Scenario: Creating the duplicate group
    And I create duplicate group
      | groupName   | groupDescription       | selectUser |
      | autogroup02 | autogroupdescription02 | CM1,CM2    |

  Scenario: TC21,22 Verify that if group details are updating with duplicate name red toast message should display and after refreshing the page previous details should not be updated
    And I edit group name as duplicate
      | groupName   | newGroupName | groupDescription        | selectUser | removeUser |
      | autogroup02 | autogroup01  | testgroupdescriptionnew | ''         | ''         |

  Scenario: TC23,24 Verify that group name input field and group name input field have limit of 30 character
    And I verify length of input fields for group management
      | groupName                                            | expectedGroupName              | groupDescription                                     | expectedGroupDescription       |
      | abcdefghijklmnopqrstuvwxyzabcd                       | abcdefghijklmnopqrstuvwxyzabcd | abcdefghijklmnopqrstuvwxyzabcd                       | abcdefghijklmnopqrstuvwxyzabcd |
      | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz | abcdefghijklmnopqrstuvwxyzabcd | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz | abcdefghijklmnopqrstuvwxyzabcd |
      | abcdefghijklmnopqrstuvwxyzabcd                       | abcdefghijklmnopqrstuvwxyzabcd | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz | abcdefghijklmnopqrstuvwxyzabcd |
      | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz | abcdefghijklmnopqrstuvwxyzabcd | abcdefghijklmnopqrstuvwxyzabcd                       | abcdefghijklmnopqrstuvwxyzabcd |

  Scenario:Verify create group form mandatory input field
    And I verify group name is mandatory for group creation

  Scenario: TC30-45 Verify user filtering in create group form
    And I select users "HDF1,HDF2" by applying "HDF" on users filter
    And I verify "HDF1,HDF2" users can be removed
    And I verify select all and remove all users
    And I remove users filter
    And I close create group form
    And I open create group form
    And I verify "CM1,CM2" users can be selected
    And I verify unassociated users
    And I apply filter "MAS$ER" on users
    And I remove users filter
    And I verify select all and remove all users

  Scenario: TC17 Verify user has non configurer role associated to it then option to create group is not available to user on UI
    And I login as "unauthorized" user
    And I verify user is unable to view group management menu

  Scenario:To test when group is associated with fund verify cash ladder
    And I login as "functional" user
    And I go to the account group page
    And I open group to edit
      | GroupToEdit       | Account Group Type | Account Group Code | Email | Group       | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description      | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | HSBC PENSION FUND | ''                 | ''                 | ''    | autogroup01 | ''       | ''         | ''                | ''        | ''                 | ''      | autogroup01 Test | ''                | ''           | ''          | ''            |
    And I login as "hpfgroup" user
    And I go to the ladder page
    And I deselect group "HPF Group"
    And I verify selected groups are "autogroup01"
    And I select perspective "Fund/Currency/Account/Category"
    And I remove grouping
    And I verify balances csv for "TC001"

  Scenario:GroupManagent To test when group is associated with fund verify alerts
    And I navigate to home page
    And I update CBD for "TESTHSS" region to "SYSDATE"
    And I go to the alert page
    And I deselect group "HPF Group" on alerts dashboard
    And I verify selected groups are "autogroup01" on alerts dashboard
    And I verify alert result for "TC010"

  Scenario: Resotring fund group to default
    And I update CBD for "TESTHSS" region to "23-SEP-17"
    And I login as "functional" user
    And I go to the account group page
    And I open group to edit
      | GroupToEdit       | Account Group Type | Account Group Code | Email | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description    | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | HSBC PENSION FUND | ''                 | ''                 | ''    | HPF Group | ''       | ''         | ''                | ''        | ''                 | ''      | HPF Group Test | ''                | ''           | ''          | ''            |
