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
#loading Cashflows
@Import("BDD\features-meta\loadingCashFlows.meta")
#Alert new specific functions
@Import("BDD\features-meta\alert.meta")
@Import("BDD\features-meta\alertPreview.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#NEW Favorite specific functions
@Import("BDD\features-meta\favorite.meta")
#timeline meta
@Import("BDD\features-meta\timeline.meta")

Feature: Alert
  Test case for Alert
  As a cash manager
  I want to verify Alert

  Scenario: TC1 Verify navigation to alert page and verify page with default perspective
    Given moduleName is "alerts"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "functional" user
    And I update CBD for "TESTHSS" region to "SYSDATE"
    And I update alert execution days for fund with code "HDF" to "4" days
    And I update alert execution days for fund with code "HGF" to "4" days
    And I update alert execution days for fund with code "HPF" to "4" days
    And I login as "functional" user
    And I go to the alert page
    And I verify timeline sidebar button is not visible
    And I verify there are no alerts available

  Scenario: Verify default status of button
    And I update CBD for "TESTHSS" region to "23-SEP-17"
    And I load strategy
      | fileName  |
      | strategy1 |
      | strategy2 |
      | strategy3 |
    And I update CBD for "TESTHSS" region to "SYSDATE"
    And I login as "functional" user
    And I go to the alert page
    And I verify default status of all button

  Scenario: Test lock action for fund in open state
    And I lock fund "HPF" having status "OPEN"

  Scenario: Test unlock action for fund in open state
    And I unlock fund "HPF" having status "OPEN"

  Scenario: Add narrative to fund in open state
    And I verify narratveText limit
      | fundName | status | narrativeTextEnterred                                                                                                                                                                                                                                                        | expectedNarrativeText                                                                                                                                                                                                                                           |
      | HPF      | OPEN   | test narrative                                                                                                                                                                                                                                                               | test narrative                                                                                                                                                                                                                                                  |
      | HPF      | OPEN   | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmoprstuvwxyzabcdefghijklmnopqrabcdefghijklmnopqr | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmoprstuvwxyzabcdefghijklmnopqrabcde |
      | HPF      | OPEN   | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmoprstuvwxyzabcdefghijklmnopqrabcde              | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmoprstuvwxyzabcdefghijklmnopqrabcde |

  Scenario:TC67,69-72 To test whether adding notes works on alert screen
    And I verify notes for alert
      | fundName | status | Account Number | CCY | Amount         | Value Date | noteTextEnterred                                                                                                                                                                                                                                                             | expectedNoteText                                                                                                                                                                                                                                                |
      | HPF      | OPEN   | HPFAUDAC2      | AUD | -5,647,675,190 | 23/09/2017 | test note                                                                                                                                                                                                                                                                    | test note                                                                                                                                                                                                                                                       |
      | HPF      | OPEN   | HPFAUDAC2      | AUD | -5,647,675,190 | 23/09/2017 | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmoprstuvwxyzabcdefghijklmnopqrabcde              | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmoprstuvwxyzabcdefghijklmnopqrabcde |
      | HPF      | OPEN   | HPFAUDAC2      | AUD | -5,647,675,190 | 23/09/2017 | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmoprstuvwxyzabcdefghijklmnopqrabcdefghijklmnopqr | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmoprstuvwxyzabcdefghijklmnopqrabcde |

  Scenario:Known Issue CMS-10749. Take extract on expansion
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I verify alerts csv for "TC001"

  Scenario: Take extract on collapse
    ##And I refresh the current page
    And I wait for page to load
    And I collapse all rows on alert
    And I verify alert result for "TC002"

  Scenario: Remove one group and expand one row then extracts
    And I navigate to home page
    And I go to the alert page
    And I deselect group "HPF Group" on alerts dashboard
    ##And I refresh the current page
    And I wait for page to load
    And I expand alert for fund "HDF" having status "OPEN"
    And I verify alert result for "TC003"

  Scenario: Add One group then extracts
    And I collapse all rows on alert
    And I select group as "HPF Group" on alerts dashboard
    And I verify alert result for "TC004"

  Scenario: Open ladder page for fund "HPF" having status "OPEN"
    And I update CBD for "TESTHSS" region to "23-SEP-17"
    And I select row fund "HPF" having status "OPEN"
    And I verify balances csv for "TC005"

  Scenario: Verify swtich back to alerts page from ladder window
    And I close ladder window and verify alerts page gets displayed
    And I update CBD for "TESTHSS" region to "SYSDATE"

  Scenario:TC34 Verify email preview data and send mail and closing of alert
    And I verify closing alert and sent mail
      | fundName | status | accountCode | selection |
      | HPF      | OPEN   | HPFAUDAC2   |           |
      | HGF      | OPEN   | HGFAUDAC2   |           |
      | HDF      | OPEN   | HDFCADAC1   |           |

  Scenario: TC42,75 Triggering new open alerts
    And I update CBD for "TESTHSS" region to "23-SEP-17"
    And I load strategy
      | fileName  |
      | strategy1 |
      | strategy2 |
      | strategy3 |
      | strategy2 |
    And I update CBD for "TESTHSS" region to "SYSDATE"
    And I login as "functional" user
    And I go to the alert page
    And I verify group selector for "functional" user

  Scenario: TC35,38,76 Apply filter and take extract
    And I enter alert filter "Status:CLOSED"
    And I verify alert result for "TC006"

  Scenario: Remove filter and take extract
    And I remove alert filter "Status:CLOSED"
    And I verify alert result for "TC007"

  Scenario:TC20,68,86,88 Verify closing of alert button status for closed alerts
    And I verify button status for "HPF" having status "OPEN"
    And I verify button status for "HPF" having status "CLOSED"

  Scenario:TC28,29 Verify closing of alert without sending mail
    And I close alert "HDF" having status "OPEN"

  Scenario:TC50 Verify closing of alert button status for closed alerts
    And I lock fund "HPF" having status "OPEN"
    And I verify locking other fund "HGF" having status "OPEN"

  Scenario: Login with cash manager user and verify actions
    Given I login as "ocm" user
    And I go to the alert page
    And I verify Force Unlock button is not present

  Scenario: Login with cash manager supervisor user and verify actions
    Given I login as "cms1" user
    And I go to the alert page
    And I verify already locked fund "HPF" having status "OPEN"

  Scenario: Login with user having cash manager role but not assign to any group
    Given I login as "ngu" user
    And I go to the alert page
    And I verify there are no alerts available

  Scenario: To test whether  user having roles other than cash manager and cash manager supervisor are not able to view view alerts screen
    Given I login as "sde1" user
    And I verify user unable to view alerts screen

  Scenario:TC40,41 To test when user is associated with the single group and that group is selected then alerts for that selected group will be shown under view all alert screen
    Given I login as "hpfgroup" user
    And I go to the alert page
    And I verify group selector for "hpfgroup" user
    And I verify alert result for "TC008"

  Scenario: Login with other user and verify actions
    And I login as "functional2" user
    And I go to the alert page
    And I verify default status of all button
    And I verify already locked fund "HPF" having status "OPEN"
    And I force unlock fund "HPF" having status "OPEN"

  Scenario:Known issue CMS-11144. TC19,101-107 To test whether selection of balance level alert works for alert with open status
    And I login as "functional" user
    And I go to the alert page
    And I verify narratveText limit
      | fundName | status | narrativeTextEnterred | expectedNarrativeText |
      | HPF      | OPEN   | test                  | test                  |
    And I lock fund "HPF" having status "OPEN"
    And I verify all the alerts for fund "HPF" having status "OPEN" are included in email
    And I unselect balance level alert
      | Fund | Status | Account Number | CCY | Amount                | Value Date |
      | HPF  | OPEN   | HPFCADAC2      | CAD | -2,009,320,549.88     | 24/09/2017 |
      | HPF  | OPEN   | HPFEURAC1      | EUR | -17,734,261,075.38833 | 24/09/2017 |
      | HPF  | OPEN   | HPFJPYAC2      | JPY | -8,113,029,678.95198  | 23/09/2017 |
    And I select balance level alert
      | Fund | Status | Account Number | CCY | Amount                | Value Date |
      | HPF  | OPEN   | HPFEURAC1      | EUR | -17,734,261,075.38833 | 24/09/2017 |
    And I navigate to home page
    And I go to the alert page
    And I unlock fund "HPF" having status "OPEN"
    And I verify closing alert and sent mail
      | fundName | status | accountCode | selection |
      | HPF      | OPEN   | HPFAUDAC2   | Selected  |

  Scenario: TC108 To test whether when closed alerts are expanded then no tick is displayed against the balance level alerts that were excluded
    And I enter alert filter "Narrative:test"
    And I select fund "HPF" having status "CLOSE"
    And I expand alert for fund "HPF" having status "CLOSE"
    And I remove alert filter "Narrative:test"
    And I verify excluded mails
      | Fund | Status | Account Number | CCY | Amount               | Value Date |
      | HPF  | CLOSE  | HPFCADAC2      | CAD | -2,009,320,549.88    | 24/09/2017 |
      | HPF  | CLOSE  | HPFJPYAC2      | JPY | -8,113,029,678.95198 | 23/09/2017 |
    And I collapse alert for fund "HPF" having status "CLOSE"

  Scenario: Loading undefined category exceptional Cashflows
    And I update CBD for "TESTHSS" region to "23-SEP-17"
    And I load cashflow
      | fileName       | accountNo | referenceNo | ammount      | calKey | overallStatus | startingDate |
      | alertException | HGFCADAC2 | Alt-01      | -219383.2921 | 99     | 1002          | 01/03/2018   |

  Scenario:TC109 To test whether default category is not present on alerts dashboard and in email preview
    And I login as "functional" user
    And I go to the ladder page
    And I select perspective "Fund/Currency/Account"
    And I verify cashflow on ladder
      | startingDate | endDate    | perspective           | balanceType                               | ofdate                                               | ofperspective     | filter            |
      | 23/09/2017   | 03/10/2017 | Fund/Currency/Account | Cashflows with open exceptions - STANDARD | 23/09/2017 Cashflows with open exceptions - STANDARD | HGF:CAD:HGFCADAC2 | Account:HGFCADAC2 |
    And I update CBD for "TESTHSS" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I verify fund details are not on dashboard
      | Fund | Status | Account Number | CCY | Amount             | Value Date |
      | HGF  | OPEN   | HGFCADAC2      | CAD | -992,691,982.35041 | 24/09/2017 |
    And I click emailAndPreview
    And I verify fund details are not in mail preview
      | Account Code | Account Full Name | Amount           | Value Date  |
      | HGFCADAC2    | HGFCADAC2-NAME    | AUD -219383.2921 | 23-Sep-2017 |
    And I click cancelButton

  Scenario:Known issue CMS-11037. Favorite-TC20,21 To test add/remove to favorite on alert page
    And I navigate to home page
    And I go to the alert page
    And I deselect group "HPF Group" on alerts dashboard
    And I enter alert filter "Status:OPEN"
    And I add "alertsFilter" page to favorite
    And I navigate to home page
    And I verify favorite "alertsFilter" working
    And I verify selected groups are "HDF Group:Default Group" on alerts dashboard
    And I verify group "HPF Group" does not exist on alerts dashboard
    And I verify alert result for "TC009"
    And I delete "alertsFilter" from favorite

  Scenario:STRAT-653-TC1 Refresh the page and again validate the dashboard.
    And I login as "functional" user
    And I go to the alert page
    And I verify selected groups are "HPF Group:HDF Group:Default Group" on alerts dashboard
    And I sort descending "Strat Exec Date Time"
    ##WA##And I verify alerts csv for "STRAT-653-TC001"
    And I verify alert result for "STRAT-653-TC001"

  Scenario:STRAT-653-TC2 Refresh the page and again validate the dashboard.
    And I refresh the current page
    And I wait for page to load
    And I verify selected groups are "HPF Group:HDF Group:Default Group" on alerts dashboard
    And I sort descending "Strat Exec Date Time"
    ##WA##And I verify alerts csv for "STRAT-653-TC002"
    And I verify alert result for "STRAT-653-TC002"

  Scenario:STRAT-653-TC3 Deselect one group and validate dashboard.
    And I deselect group "HPF Group" on alerts dashboard
    And I verify selected groups are "Default Group:HDF Group" on alerts dashboard
    ##WA##And I verify alerts csv for "STRAT-653-TC003"
    And I verify alert result for "STRAT-653-TC003"

  Scenario:STRAT-653-TC4 Refresh the page and again validate the dashboard.
    And I refresh the current page
    And I wait for page to load
    And I verify selected groups are "Default Group:HDF Group" on alerts dashboard
    ##WA##And I verify alerts csv for "STRAT-653-TC004"
    And I verify alert result for "STRAT-653-TC004"

  Scenario:STRAT-653-TC5 Deselect all the groups and validate dashboard.
    And I deselect group "HDF Group" on alerts dashboard
    And I deselect group "Default Group" on alerts dashboard
    And I verify there are no alerts available

  Scenario:STRAT-653-TC6 Refresh the page and again validate the dashboard.
    And I refresh the current page
    And I wait for page to load
    And I verify there are no alerts available

  Scenario:STRAT-653-TC7 Select one group and validate dashboard.
    And I select group as "HPF Group" on alerts dashboard
    And I verify selected groups are "HPF Group" on alerts dashboard
    And I sort descending "Strat Exec Date Time"
    ##WA##And I verify alerts csv for "STRAT-653-TC005"
    And I verify alert result for "STRAT-653-TC005"

  Scenario:STRAT-653-TC8 Refresh the page and again validate the dashboard.
    And I refresh the current page
    And I wait for page to load
    And I verify selected groups are "HPF Group" on alerts dashboard
    And I sort descending "Strat Exec Date Time"
    ##WA##And I verify alerts csv for "STRAT-653-TC006"
    And I verify alert result for "STRAT-653-TC006"

  Scenario:Resotring CBD of TESTHSS region
    And I update CBD for "TESTHSS" region to "23-SEP-17"

##NA## Scenario: TC114 To test pagination on alert page
##NA##     And I navigate to home page
##NA##     And I go to the alert page
##NA##     And I expand alert for fund "HDF" having status "CLOSED"
##NA##     And I go to page "3"
##NA##     And I lock fund "HGF" having status "OPEN"
##NA##     And I verify current page is "3"
##NA##     And I unlock fund "HGF" having status "OPEN"
##NA##     And I verify current page is "3"
##NA##     And I sort ascending "Fund/Account"
##NA##     And I verify current page is "3"
