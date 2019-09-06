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
#Alertissue preview data
@Import("BDD\features-meta\alertPreview.meta")
#NEW Favorite specific functions
@Import("BDD\features-meta\favorite.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")

Feature: Alerts User Groups Date Range
  Test case for to test
  prdouction bugs are resolved

  Scenario:Alert Issues-Set1 Prereq
    Given moduleName is "alertsUserGroupsDateRange"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "altGSU" user
    And I update CBD for "ALERT" region to "SYSDATE"
    And I load account
      | fileName    |
      | ALERTACC111 |
      | ALERTACC112 |
      | ALERTACC121 |
      | ALERTACC131 |
      | ALERTACC132 |
      | ALERTACC133 |
      | ALERTACC211 |
      | ALERTACC221 |
      | ALERTACC311 |
      | ALERTACC312 |
    And I load fund
      | fileName   |
      | ALERTFND11 |
      | ALERTFND12 |
      | ALERTFND13 |
      | ALERTFND21 |
      | ALERTFND22 |
      | ALERTFND31 |
    And I execute sql file "CMS903_UpdateAccountRegion"


  Scenario: Alert Issue Set-2 Prereq Load Cashflows
    And I load messages from "alert_issues_set2"
    And I verify load count in table "cms_bdr_transaction" for "account_id like 'ALERTACC%' and current_calc_key=12000" clause to be "140"
    And I verify load count in table "cms_bdr_transaction" for "account_id like 'ALERTACC%' and current_calc_key=12002" clause to be "10"

  Scenario Outline: Alert Issue Set-2 Prereq Load Alerts
    And I load strategy "alertIssue2_strategy_HODHTDFND4_Wednesday1"
    And I load strategy "alertIssue2_strategy_HODHTDFND4_Wednesday3"
    And I load strategy "alertIssue2_strategy_HODHTDFND4_Wednesday4"
    And I load strategy "alertIssue2_strategy_HODHTDFND4_Wednesday7"
    And I load strategy "alertIssue2_strategy_HODHTDFND4_Wednesday8"
    And I load strategy "alertIssue2_strategy_HODHTDFND4_Wednesday9"
    And I verify load count in table "cms_bdr_alert" for "fund_code like 'ALERTFND%'" clause to be "<loadCount>"
    And I execute sql file "<sqlUpdateFile>"

    Examples:
      | loadCount | sqlUpdateFile           |
      | 6         | CMS903_updateScenario1  |
      | 12        | CMS903_updateScenario2  |
      | 18        | CMS903_updateScenario3  |
      | 24        | CMS903_updateScenario4  |
      | 30        | CMS903_updateScenario4  |
      | 36        | CMS903_updateScenario5  |
      | 42        | CMS903_updateScenario6  |
      | 48        | CMS903_updateScenario7  |
      | 54        | CMS903_updateScenario8  |
      | 60        | CMS903_updateScenario9  |
      | 66        | CMS903_updateScenario10 |


  Scenario:Alert Issues2-Scn1 To test if group super user is able to see  alerts of only assigened group by default
    And I login as "altGSU" user
    And I go to the alert page
    And I verify selected groups are "ALERTGRP3" on alerts dashboard
    And I verify alert result for "Scn2_01"

  Scenario:Alert Issues2-Scn2 To test whether group super is able to select groups other than assigned groups and able to view alerts of groups other than assigned groups
    And I select group as "ALERTGRP1:ALERTGRP2" on alerts dashboard
    And I verify selected groups are "ALERTGRP3:ALERTGRP1:ALERTGRP2" on alerts dashboard
    And I verify alert result for "Scn2_02"

  Scenario:Alert Issues2-Scn8 Check if super user is able to add/remove groups and data is shown only for create date as User CBD for all the funds
    And I deselect group "ALERTGRP3" on alerts dashboard
    And I verify selected groups are "ALERTGRP1:ALERTGRP2" on alerts dashboard
    And I verify alert result for "Scn2_08"

  Scenario:Alert Issues2-Scn3 To test whether user which is not super user should  able to see alerts of assigned group by default
    And I login as "alertUG1" user
    And I go to the alert page
    And I verify selected groups are "ALERTGRP1:ALERTGRP2" on alerts dashboard
    And I verify alert result for "Scn2_03"

  Scenario:Alert Issues2-Scn4 To test whether user which is not super user is not able to see alerts of groups other than assigned group
    And I login as "alertUG2" user
    And I go to the alert page
    And I verify selected groups are "ALERTGRP2" on alerts dashboard
    And I verify user can not select groups other that assigned groups
    And I sort ascending "Fund/Account"
    And I verify alerts csv for "Scn2_04"

  Scenario:Alert Issues2-Scn6 Check if the user is associated to a group of funds that have no alerts with create date as User CBD, then alerts dashboard should be blank
    And I execute sql file "CMS903_updateRegion"
    And I login as "altGSU" user
    And I go to the alert page
    And I verify there are no alerts available
    And I execute sql file "CMS903_updateRegionOrig"

  Scenario:Alert Issues2-Scn5/7/11/12 Check if user is able to filter on Open/Closed and Accounts/Funds Alert
    And I login as "altGSU" user
    And I go to the alert page
    And I select group as "ALERTGRP1:ALERTGRP2" on alerts dashboard
    And I verify alert result for "Scn2_05"
    And I apply alert filter "Status:OPEN;Fund/Account:ALERTFND1"
    And I verify alert result for "Scn2_07"

  Scenario:Alert Issues2-Scn13/15 Check the date picker on the UI, by default should have from and to date as User CBD / Check if User can select the start range and the end date by default is max 7 days. User can change the start date and end date will automatically adjust.
    And I navigate to home page
    And I go to the alert page
    And I verify alert start date is equal to "June 18, 2018"
    And I check alert end date is not visible
    And I change alert page start date to "27/05/2018"
    And I verify alert start date is equal to "May 27, 2018"
    And I verify alert end date is equal to "June 2, 2018"
    And I select group as "ALERTGRP1:ALERTGRP2" on alerts dashboard
    And I remove alert filter "Status:OPEN;Fund/Account:ALERTFND1"
    And I verify alert result for "Scn2_13"

  Scenario:Alert Issues2-Scn18 user should be able to select date picker range of less than 7 days as well, but end date can Max be CBD. Check if the data visible is as per the range selected in date picker
    And I login as "alertUG2" user
    And I go to the alert page
    And I change alert page start date to "14/06/2018"
    And I verify alert start date is equal to "June 14, 2018"
    And I verify alert end date is equal to "June 18, 2018"
    And I verify alert result for "Scn2_18"

  Scenario:Alert Issues2-Scn16 Check if the seven days date range with multiple start date selection and check if data visible is correct
    And I login as "altGSU" user
    And I go to the alert page
    And I select group as "ALERTGRP1:ALERTGRP2" on alerts dashboard
    And I change alert page start date to "14/06/2018"
    And I verify alert start date is equal to "June 14, 2018"
    And I change alert page end date to "14/06/2018"
    And I verify alert end date is equal to "June 14, 2018"
    And I verify alert result for "Scn2_16_1"
    And I deselect group "ALERTGRP1" on alerts dashboard
    And I change alert page start date to "15/06/2018"
    And I verify alert start date is equal to "June 15, 2018"
    And I change alert page end date to "17/06/2018"
    And I verify alert end date is equal to "June 17, 2018"
    And I select group as "ALERTGRP1" on alerts dashboard
    And I verify alert result for "Scn2_16_2"
    And I change alert page start date to "10/06/2018"
    And I verify alert start date is equal to "June 10, 2018"
    And I verify alert end date is equal to "June 16, 2018"
    And I verify alert result for "Scn2_16_3"

  Scenario:Pre Issues2-Scn20 login using a group super user having atleast 1 group allocated ->Then 'send and close' a alert - expand fund icon & The Email Sent status icon should be present on alert ui after loading the page
    And I login as "altGSU" user
    And I go to the alert page
    And I verify selected groups are "ALERTGRP3" on alerts dashboard
    And I add narrarative "Check the Sent Icon" to fund "ALERTFND31" having status "OPEN" and expect narrative as "Check the Sent Icon"
    And I deselect group "ALERTGRP3" on alerts dashboard
    And I verify there are no alerts available
    And I select group as "ALERTGRP3" on alerts dashboard
    And I expand alert for fund "ALERTFND31" having status "OPEN"
    And I verify closing alert and sent mail
      | fundName   | status | accountCode | selection |
      | ALERTFND31 | OPEN   | ALERTACC311 |           |

  Scenario:Issues2-Scn20
    And I apply alert filter "Narrative:Check the Sent Icon"
    And I deselect group "ALERTGRP3" on alerts dashboard
    And I verify there are no alerts available
    And I select group as "ALERTGRP3" on alerts dashboard
    And I verify email sent icon for fund "ALERTFND31" having status "CLOSED" is present
    And I verify alerts csv for "Scn2_20_1"

  Scenario:Issues2-Scn19 login using a group super having 1 group allocated and the group having alerts-> then deselect the groups and select again- expand fund icon & The Email Sent status icon should be present on alert ui after loading the page
    And I login as "altGSU" user
    And I go to the alert page
    And I apply alert filter "Narrative:Check the Sent Icon"
    And I deselect group "ALERTGRP3" on alerts dashboard
    And I verify there are no alerts available
    And I select group as "ALERTGRP3" on alerts dashboard
    And I select group as "ALERTGRP2" on alerts dashboard
    And I verify email sent icon for fund "ALERTFND31" having status "CLOSED" is present
    And I collapse all rows on alert
    And I expand alert for fund "ALERTFND31" having status "CLOSED"
    And I remove alert filter "Narrative:Check the Sent Icon"
    And I expand alert for fund "ALERTFND21" having status "OPEN"
    And I verify alert result for "Scn2_19"

  Scenario:Issues2-Scn21/22 login using a group super user not having any group allocated ->Then select one group having alerts and some sent alerts and then check the UI - expand fund icon & The Email Sent status icon should be present on alert ui after loading the page
    And I execute sql file "903_AddUserInNoGroup"
    And I login as "altGSU" user
    And I go to the alert page
    And I verify there are no alerts available
    And I select group as "ALERTGRP3" on alerts dashboard
    And I expand alert for fund "ALERTFND31" having status "CLOSED"
    And I apply alert filter "Narrative:Check the Sent Icon"
    And I verify email sent icon for fund "ALERTFND31" having status "CLOSED" is present
    And I remove alert filter "Narrative:Check the Sent Icon"

  Scenario:Issues2-Scn23/24 login using a non group super having 2 groups allocated &  group having alerts ->then deselect the groups and select again- expand fund icon & login using a non group super having 2 groups allocated &  group having alerts ->then deselect the groups and select only 1 group and hard refresh- expand fund icon & The Email Sent status icon should be present on alert ui after loading the page
    And I login as "alertUG3" user
    And I go to the alert page
    And I verify selected groups are "ALERTGRP3" on alerts dashboard
    And I deselect group "ALERTGRP3" on alerts dashboard
    And I verify there are no alerts available
    And I select group as "ALERTGRP3" on alerts dashboard
    And I expand alert for fund "ALERTFND31" having status "CLOSED"
    And I apply alert filter "Narrative:Check the Sent Icon"
    And I verify email sent icon for fund "ALERTFND31" having status "CLOSED" is present
    And I deselect group "ALERTGRP3" on alerts dashboard
    And I refresh the current page
    And I wait for page to load
    And I verify there are no alerts available
    And I select group as "ALERTGRP3" on alerts dashboard
    And I refresh the current page
    And I wait for page to load
    And I expand alert for fund "ALERTFND31" having status "CLOSED"
    And I apply alert filter "Narrative:Check the Sent Icon"
    And I verify email sent icon for fund "ALERTFND31" having status "CLOSED" is present

  Scenario:Alert Issues2-Scn9 Trigger EOD for user region and then verify alert dashboard, should be blank
    And I execute sql file "903_AddUserInThreeGroups"
    And I login as "alertUG" user
    And I go to the alert page
    And I verify selected groups are "ALERTGRP3:ALERTGRP1:ALERTGRP2" on alerts dashboard
    And I verify there are no alerts available


  Scenario: Alert Issue Set-2 Prereq for few cases
    And I load strategy
      | fileName                                   |
      | alertIssue2_strategy_HODHTDFND4_Wednesday1 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday3 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday4 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday7 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday8 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday9 |
    And I verify load count in table "cms_bdr_alert" for "fund_code like 'ALERTFND%'" clause to be "72"
    And I load strategy
      | fileName                                   |
      | alertIssue2_strategy_HODHTDFND4_Wednesday1 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday3 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday4 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday7 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday8 |
      | alertIssue2_strategy_HODHTDFND4_Wednesday9 |
    And I verify load count in table "cms_bdr_alert" for "fund_code like 'ALERTFND%'" clause to be "78"


  Scenario:Alert Issues2-Scn10/14 Trigger fresh alerts after above step and alerts should be visible only with create date as User CBD and check the time & Check if the data displayed on the alert dashboard is sorted by Status with All Open alerts on top and all Closed alerts in bottom
    And I login as "alertUG" user
    And I go to the alert page
    And I verify selected groups are "ALERTGRP3:ALERTGRP1:ALERTGRP2" on alerts dashboard
    And I verify alerts csv for "Scn2_14"
