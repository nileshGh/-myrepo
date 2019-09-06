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
@Import("BDD\features-meta\alertProdIssuePreview.meta")
#NEW Favorite specific functions
@Import("BDD\features-meta\favorite.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")

Feature: Alerts Holidays
  Test case for to test
  prdouction bugs are resolved

  Scenario:Change CMSService properties to 3 days
    Given moduleName is "alertsHoliday"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I change cms service properties "ThreeDays"

  Scenario:Alert Issues-Set1 Prereq
    And I login as "alertUser0" user
    And I update CBD for "ALERT" region to "SYSDATE"
    And I login as "alertUser0" user
    And I load account
      | fileName       |
      | AccountHODACC1 |
      | AccountHODACC2 |
      | AccountHTDACC1 |
      | AccountHTDACC2 |
      | AccountHTDACC3 |
      | AccountHTDACC4 |
      | AccountHTDACC5 |
      | AccountHTDACC6 |
    And I load fund
      | fileName  |
      | FUNDLoad1 |
      | FUNDLoad2 |
      | FUNDLoad3 |
      | FUNDLoad4 |
    And I execute sql file "Alert2_UpdateAccountRegion"

  Scenario:Alert Issues-Scn7/18 Execute Strategy for a fund having 2 accounts and 1 account having opening bal for CBD and other not having opening bal for CBD.CBD is not a holiday./ Alert generation for zero balance on CBD but negative balance on CBD+1
    And I load cashflow
      | fileName       | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | HODACC1-13th_1 | HODACC1   | Scenario7   | -3000   | 12000  | 1003          | 13/06/2018   |
      | HTDACC1-13th_1 | HTDACC1   | Scenario7_1 | -1000   | 12002  | 1003          | 13/06/2018   |
      | HTDACC1-13th_2 | HTDACC1   | Scenario182 | 1000    | 12000  | 1003          | 13/06/2018   |
      | HTDACC1-14th_1 | HTDACC1   | Scenario183 | -1000   | 12000  | 1003          | 13/06/2018   |
    And I load strategy
      | fileName                      |
      | strategy_HODHTDFND1_Wednesday |
    And I login as "alertUser0" user
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1;Status:OPEN"
    And I expand alert for fund "HODHTDFND1" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn007"

  Scenario:Alert Issues-Scn7/18 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND1" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario07 data

  Scenario:Alert Issues Scn16 Alert generation if one of the account in the fund is in exception
    And I click cancelButton
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | HODACC2-13th_16_1 | HODACC2   | Scenario16_1 | -4000   | 99     | 1002          | 13/06/2018   |
      | HTDACC2-13th_16_1 | HTDACC2   | Scenario16_2 | -3000   | 12002  | 1003          | 13/06/2018   |
      | HTDACC2-13th_16_2 | HTDACC2   | Scenario16_3 | -2000   | 12000  | 1003          | 13/06/2018   |
    And I load strategy
      | fileName                         |
      | strategy_HODHTDFND2_Wednesday_16 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND2;Status:OPEN"
    And I expand alert for fund "HODHTDFND2" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND2"
    And I verify alert result for "Scn016"

  Scenario:Alert Issues-Scn16 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND2" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario16 data

  Scenario:Alert Issues-Scn17 Alert generation if one of the cashflow in the account belonging to the fund is in exception
    And I click cancelButton
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | HODACC2-13th_17_1 | HODACC2   | Scenario17_1 | -4000   | 12002  | 1003          | 13/06/2018   |
      | HODACC2-13th_17_2 | HODACC2   | Scenario17_2 | -3000   | 99     | 1002          | 13/06/2018   |
    And I load strategy
      | fileName                         |
      | strategy_HODHTDFND2_Wednesday_17 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND2;Status:OPEN"
    And I expand alert for fund "HODHTDFND2" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND2"
    And I verify alert result for "Scn017"

  Scenario:Alert Issues-Scn17 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND2" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario17 data

  Scenario:Alert Issues-Scn8 To test alerts for all the accounts get closed, if all the accounts in the fund are in negative and while triggering alert again , all accounts are positive
    And I click cancelButton
    And I remove following alert filter "Status:OPEN"
    And I load cashflow
      | fileName         | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | HODACC2-13th_8_1 | HODACC2   | Scenario8_1 | 7000    | 12000  | 1003          | 13/06/2018   |
      | HTDACC2-13th_8_1 | HTDACC2   | Scenario8_2 | 7000    | 12000  | 1003          | 13/06/2018   |
    And I load strategy
      | fileName                        |
      | strategy_HODHTDFND2_Wednesday_8 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND2"
    And I verify alert result for "Scn008"

  Scenario:Alert Issues-Scn22 Execute Strategy for a fund having 3 accounts and 1 account having opening bal, one account not having opening balance but the account is overdrawn for CBD, and 3rd not having opening bal for CBD and is not overdrawn for CBD but overdrawn for CBD+1
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | HTDACC1-13th_22_1 | HTDACC4   | Scenario22_1 | -5000   | 12002  | 1003          | 13/06/2018   |
      | HTDACC1-13th_22_2 | HTDACC5   | Scenario22_2 | -1000   | 12000  | 1003          | 13/06/2018   |
      | HTDACC1-14th_22_1 | HTDACC6   | Scenario22_3 | -2000   | 12000  | 1003          | 14/06/2018   |
    And I load strategy
      | fileName                         |
      | strategy_HODHTDFND4_Wednesday_22 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn022"

  Scenario:Alert Issues-Scn22 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario22 data

  Scenario:Alert Issues-Scn23 Execute Strategy for a fund having 3 accounts and 1 account having opening bal, one account not having opening balance but the account is overdrawn for CBD, and 3rd not having opening bal for CBD and is not overdrawn for CBD but overdrawn for CBD+1
    And I click cancelButton
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | HTDACC1-13th_23_1 | HTDACC5   | Scenario23_1 | -7000   | 99     | 1002          | 13/06/2018   |
      | HTDACC1-13th_23_2 | HTDACC6   | Scenario23_1 | -5000   | 99     | 1002          | 13/06/2018   |
    And I load strategy
      | fileName                         |
      | strategy_HODHTDFND4_Wednesday_23 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn023"

  Scenario:Alert Issues-Scn23 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario23 data

  Scenario:Alert Issues-Scn24/25 Execute Strategy for a fund having 3 accounts and 1 account having opening bal, one account having opening balance in exception but the account is overdrawn for CBD, and 3rd having ACT in exception for CBD+1 and account is not overdrawn for CBD but overdrawn for CBD+1 and Execute Strategy for a fund having 3 accounts and 1 account having opening bal, one account having opening balance in exception but the account is overdrawn for CBD, and 3rd having opening bal inexception for CBD and account is not overdrawn for CBD, but Overdrawn for CBD+1 and resolve one the exception.It should take the actual opening balance
    And I click cancelButton
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | HTDACC1-13th_24_2 | HTDACC6   | Scenario23_1 | -5000   | 12002  | 1003          | 13/06/2018   |
      | HTDACC1-14th_24_1 | HTDACC6   | Scenario24_3 | -10000  | 99     | 1002          | 14/06/2018   |
    And I load strategy
      | fileName                         |
      | strategy_HODHTDFND4_Wednesday_23 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn024"

  Scenario:Alert Issues-Scn24 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario24 data

  Scenario: Performs EOD for TESTHOL region from Wednesday to Thursday
    And I perform EOD for "TESTHOL" region with CBD "2018-06-13" and last EOD execution "2018-06-12"

  Scenario:Alert Issues-Scn9 To test in new alert generated for only positive accounts get closed, if all accounts in the fund are in negative and while triggering alert again , few accounts are positive
    And I load cashflow
      | fileName           | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | 1_HODACC2-14th_9_1 | HODACC1   | Scenario9_1 | -3000   | 12002  | 1003          | 14/06/2018   |
      | 1_HTDACC1-14th_9_2 | HTDACC1   | Scenario9_3 | 0       | 12002  | 1003          | 14/06/2018   |
      | 3_HTDACC2-13th_9_1 | HTDACC1   | Scenario9_2 | -2000   | 12000  | 1003          | 14/06/2018   |
    And I load strategy
      | fileName                          |
      | 4_strategy_HODHTDFND2_Wednesday_9 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1;Status:OPEN"
    And I expand alert for fund "HODHTDFND1" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn009_1"

  Scenario:Alert Issues-Scn9 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND1" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario09_1 data

  Scenario:Alert Issues-Scn9 To test in new alert generated for only positive accounts get closed, if all accounts in the fund are in negative and while triggering alert again , few accounts are positive
    And I click cancelButton
    And I load cashflow
      | fileName           | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | 5_HTDACC2-13th_9_1 | HODACC1   | Scenario9_5 | 4000    | 12000  | 1003          | 14/06/2018   |
    And I load strategy
      | fileName                          |
      | 6_strategy_HODHTDFND2_Wednesday_9 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1;Status:OPEN"
    And I expand alert for fund "HODHTDFND1" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn009_2"

  Scenario:Alert Issues-Scn9 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND1" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario09_2 data

  Scenario:Alert Issues-Scn10 To test alerts for only positive accounts get closed, if few accounts in the fund are in negative and few positive and while triggering alert again , accounts in positive remain positive and in negative remain negative
    And I click cancelButton
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC2-13th_10_1 | HTDACC1   | Scenario10_1 | -1000   | 12000  | 1003          | 14/06/2018   |
      | 5_HTDACC2-13th_10_1 | HODACC1   | Scenario10_2 | -500    | 12000  | 1003          | 14/06/2018   |
    And I load strategy
      | fileName                           |
      | 6_strategy_HODHTDFND2_Wednesday_10 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1;Status:OPEN"
    And I expand alert for fund "HODHTDFND1" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn010"

  Scenario:Alert Issues-Scn10 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND1" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario10 data

  Scenario:Alert Issues-Scn11 To test alerts for only positive accounts get closed, if few accounts in the fund are in negative and few positive and while triggering alert again , accounts in positive turn negative and in negative turn positive
    And I click cancelButton
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC2-13th_11_1 | HTDACC1   | Scenario11_1 | 6000    | 12000  | 1003          | 14/06/2018   |
      | 5_HTDACC2-13th_11_1 | HODACC1   | Scenario11_2 | -1500   | 12000  | 1003          | 14/06/2018   |
    And I load strategy
      | fileName                           |
      | 6_strategy_HODHTDFND2_Wednesday_11 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1;Status:OPEN"
    And I expand alert for fund "HODHTDFND1" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn011"

  Scenario:Alert Issues-Scn11 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND1" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario11 data

  Scenario:Alert Issues-Scn12 On CBD all negative turn positive but CBD+1 there are still negatives.
    And I click cancelButton
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC2-13th_12_1 | HTDACC1   | Scenario12_1 | -3000   | 12000  | 1003          | 15/06/2018   |
      | 5_HTDACC2-13th_12_1 | HODACC1   | Scenario12_2 | 2000    | 12000  | 1003          | 14/06/2018   |
      | 6_HTDACC2-13th_12_1 | HODACC1   | Scenario12_3 | -2000   | 12000  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 6_strategy_HODHTDFND2_Wednesday_12 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1;Status:OPEN"
    And I expand alert for fund "HODHTDFND1" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn012"

  Scenario:Alert Issues-Scn12 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND1" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario12 data

  Scenario:Alert Issues-Scn21 On CBD all are positive and also CBD+1 there are all positive
    And I click cancelButton
    And I remove following alert filter "Status:OPEN"
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC2-13th_21_1 | HTDACC1   | Scenario21_2 | 1000    | 12000  | 1003          | 15/06/2018   |
      | 6_HTDACC2-13th_21_1 | HODACC1   | Scenario21_1 | 3000    | 12000  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 6_strategy_HODHTDFND2_Wednesday_21 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn021"

  Scenario:Alert Issues-Scn13 On CBD there are few negative but CBD+1 there are all positive
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC2-13th_13_1 | HTDACC1   | Scenario13_2 | -7000   | 12000  | 1003          | 14/06/2018   |
      | 3_HTDACC2-13th_13_2 | HTDACC1   | Scenario13_3 | 7000    | 12000  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 6_strategy_HODHTDFND2_Wednesday_13 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1;Status:OPEN"
    And I expand alert for fund "HODHTDFND1" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn013"

  Scenario:Alert Issues-Scn13 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND1" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario13 data

  Scenario:Alert Issues-Scn26 Execute Strategy for a fund having 2 accounts and no account having opening balance but one account is overdrawn and check the ACKNAK for successful SI execution
    And I click cancelButton
    And I load strategy
      | fileName                         |
      | strategy_HODHTDFND4_Wednesday_26 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn026"

  Scenario:Alert Issues-Scn26 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario26 data

  Scenario: Performs EOD for TESTHOL region from Thursday to Friday
    And I perform EOD for "TESTHOL" region with CBD "2018-06-14" and last EOD execution "2018-06-13"

  Scenario:Alert Issues-Scn6 Execute Strategy when CBD is a holiday and there is no opening balance on CBD
    And I load cashflow
      | fileName             | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | HTDACC1-13th_6_1-AMD | HTDACC1   | Scenario6_1 | -6000   | 12002  | 1003          | 15/06/2018   |
      | HTDACC1-13th_6_1     | HTDACC1   | Scenario6_1 | -5000   | NULL   | 1019          | 15/06/2018   |
    And I load strategy
      | fileName                        |
      | strategy_HODHTDFND2_Wednesday_6 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1;Status:OPEN"
    And I expand alert for fund "HODHTDFND1" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn006"

  Scenario:Alert Issues-Scn6 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND1" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario06 data

  Scenario:Alert Issues-Scn1 Weekend as a holiday for one account and Friday as a holiday for another account.CBD as Friday and Strategy execution - Alerts should be successfully generated for one account for CBD and CBD+1 for other account
    And I click cancelButton
    And I load cashflow
      | fileName         | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | HTDACC1-13th_1_1 | HODACC1   | Scenario1_1 | -2000   | 12002  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                        |
      | strategy_HODHTDFND2_Wednesday_1 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND1;Status:OPEN"
    And I expand alert for fund "HODHTDFND1" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND1"
    And I verify alert result for "Scn001"

  Scenario:Alert Issues-Scn1 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND1" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario01 data

  Scenario:Alert Issues-Scn2 Weekend as a holiday and Monday also a holiday. Conf cashflow for Monday.CBD as Friday and Strategy execution - Alerts should be successfully generate for Friday,Tuesday and Wednesday.
    And I click cancelButton
    And I load cashflow
      | fileName             | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC2-13th_2_2   | HTDACC3   | Scenario2_2 | -3000   | 12000  | 1003          | 15/06/2018   |
      | 3_HTDACC2-13th_2_3   | HTDACC3   | Scenario2_3 | -4000   | 12000  | 1003          | 18/06/2018   |
      | HTDACC1-13th_2_1_opn | HTDACC3   | Scenario2_5 | 1000    | 12002  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                        |
      | strategy_HODHTDFND2_Wednesday_2 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND3;Status:OPEN"
    And I expand alert for fund "HODHTDFND3" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND3"
    And I verify alert result for "Scn002"

  Scenario:Alert Issues-Scn2 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND3" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario02 data

  Scenario:Alert Issues-Scn3 Weekend as a holiday and Monday also a holiday. cashflow for Monday and CBD balance positive but negative balance for  Tuesday CBD as Friday and Strategy execution - Alerts should be successfully generate for Tuesday,Wednesday,thursday
    And I click cancelButton
    And I load cashflow
      | fileName           | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC2-13th_3_2 | HTDACC3   | Scenario3_1 | 8000    | 12000  | 1003          | 15/06/2018   |
      | 3_HTDACC2-13th_3_3 | HTDACC3   | Scenario3_2 | -1000   | 12000  | 1003          | 19/06/2018   |
      | 3_HTDACC2-13th_3_4 | HTDACC3   | Scenario3_2 | -3000   | 12000  | 1003          | 19/06/2018   |
    And I load strategy
      | fileName                        |
      | strategy_HODHTDFND2_Wednesday_3 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND3;Status:OPEN"
    And I expand alert for fund "HODHTDFND3" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND3"
    And I verify alert result for "Scn003"

  Scenario:Alert Issues-Scn3 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND3" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario03 data

  Scenario:Alert Issues-Scn27 Perform an EOD and none of the account having opening balance not ACT balance, Execute strategy
    And I click cancelButton
    And I remove following alert filter "Status:OPEN"
    And I load strategy
      | fileName                         |
      | strategy_HODHTDFND4_Wednesday_27 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn027"

  Scenario:Alert Issues-Scn28 For above case Load ACT -ve balance for one account and -ve opening balance for the other account and execute strategy
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | HTDACC1-13th_28_1 | HTDACC4   | Scenario28_1 | -5000   | 12002  | 1003          | 15/06/2018   |
      | HTDACC1-13th_28_2 | HTDACC5   | Scenario28_2 | -2000   | 12000  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                         |
      | strategy_HODHTDFND4_Wednesday_28 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn028"

  Scenario:Alert Issues-Scn28 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario28 data

  Scenario:Alert Issues-Scn29 Fund has a account and the opening balance has a AMD and the AMD amount is 0, ACT balance is -ve. Alert generation should be successful
    And I click cancelButton
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | HTDACC1-13th_29_1 | HTDACC4   | Scenario28_1 | 0       | 12002  | 1003          | 15/06/2018   |
      | HTDACC1-13th_29_2 | HTDACC4   | Scenario29_2 | -2000   | 12000  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                         |
      | strategy_HODHTDFND4_Wednesday_29 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn029"

  Scenario:Alert Issues-Scn29 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario29 data

  Scenario:Alert Issues-Scn30 Fund has a account and the opening balance has a CAN such a way that amount is 0, ACT balance is -ve. Alert generation should be successful
    And I click cancelButton
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 1_HTDACC1-13th_30_1 | HTDACC5   | Scenario30_1 | 500     | 12002  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                                |
      | 2_strategy_HODHTDFND4_Wednesday-Copy_30 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn030_1"

  Scenario:Alert Issues-Scn30 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario30_1 data

  Scenario:Alert Issues-Scn30 Fund has a account and the opening balance has a CAN such a way that amount is 0, ACT balance is -ve. Alert generation should be successful
    And I click cancelButton
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC1-13th_30_2 | HTDACC5   | Scenario30_1 | -500    | NULL   | 1021          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 4_strategy_HODHTDFND4_Wednesday_30 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn030_2"

  Scenario:Alert Issues-Scn30 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario30_2 data

  Scenario:Alert Issues-Scn31 Fund has a account and the opening balance has a AMD such a way that amount is -ve, ACT balance is +ve but overall the balance is -ve. Alert generation should be successful
    And I click cancelButton
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC1-13th_31_2 | HTDACC5   | Scenario30_1 | -5000   | 12002  | 1003          | 15/06/2018   |
      | 4_HTDACC1-13th_31_2 | HTDACC5   | Scenario28_2 | 4000    | 12000  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 5_strategy_HODHTDFND4_Wednesday_31 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn031"

  Scenario:Alert Issues-Scn31 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario31 data

  Scenario:Alert Issues Scn19 Check alert generation, if the Opening balance is less than or equal to -10000000, and also, there is an ACT cash flow that is cancelled
    And I click cancelButton
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount   | calKey | overallStatus | startingDate |
      | 1_HTDACC1-13th_19 | HTDACC6   | Scenario19_1 | -10000000 | 12002  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 2_strategy_HODHTDFND4_Wednesday_19 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn019_1"

  Scenario:Alert Issues-Scn19 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario19_1 data

  Scenario:Alert Issues-Scn19 Check alert generation, if the Opening balance is less than or equal to -10000000, and also, there is an ACT cash flow that is cancelled
    And I click cancelButton
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC1-14th_1_19 | HTDACC6   | Scenario19_2 | -500    | 12000  | 1003          | 15/06/2018   |
      | 4_HTDACC1-14th_2_19 | HTDACC6   | Scenario19_2 | -500    | 0      | 1004          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 5_strategy_HODHTDFND4_Wednesday_19 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn019_2"

  Scenario:Alert Issues-Scn19 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario19_2 data

  Scenario:Alert Issues Scn19 Check alert generation, if the Opening balance is less than or equal to -10000000, and also, there is an ACT cash flow that is cancelled
    And I click cancelButton
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount  | calKey | overallStatus | startingDate |
      | 6_HTDACC1-13th_19 | HTDACC6   | Scenario19_6 | 10000000 | 12002  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 7_strategy_HODHTDFND4_Wednesday_19 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn019_3"

  Scenario:Alert Issues-Scn19 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario19_3 data

  Scenario:Alert Issues-Scn20 Check alert generation, if the Opening balance is less than or equal to 10000000, and also, there is an ACT cash flow that is cancelled
    And I click cancelButton
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount  | calKey | overallStatus | startingDate |
      | 1_HTDACC1-13th_20 | HTDACC6   | Scenario20_1 | 10000000 | 12002  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 2_strategy_HODHTDFND4_Wednesday_20 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn020_1"

  Scenario:Alert Issues-Scn20 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario20_1 data

  Scenario:Alert Issues-Scn20 Check alert generation, if the Opening balance is less than or equal to 10000000, and also, there is an ACT cash flow that is cancelled
    And I click cancelButton
    And I load cashflow
      | fileName            | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC1-14th_20_1 | HTDACC6   | Scenario20_2 | -500    | 12000  | 1003          | 15/06/2018   |
      | 4_HTDACC1-14th_20_2 | HTDACC6   | Scenario20_2 | -500    | 0      | 1004          | 15/06/2018   |
      | 5_HTDACC1-14th_20_3 | HTDACC6   | Scenario20_3 | -1000   | 12000  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                           |
      | 5_strategy_HODHTDFND4_Wednesday_20 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn020_2"

  Scenario:Alert Issues-Scn20 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario20_2 data

  Scenario:Alert Issues-Scn20 Check alert generation, if the Opening balance is less than or equal to 10000000, and also, there is an ACT cash flow that is cancelled
    And I click cancelButton
    And I load cashflow
      | fileName          | accountNo | referenceNo  | ammount   | calKey | overallStatus | startingDate |
      | 6_HTDACC1-13th_20 | HTDACC6   | Scenario20_6 | -10000000 | 12002  | 1003          | 15/06/2018   |
    And I load strategy
      | fileName                                |
      | 7_strategy_HODHTDFND4_Wednesday-Copy_20 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND4;Status:OPEN"
    And I expand alert for fund "HODHTDFND4" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND4"
    And I verify alert result for "Scn020_3"

  Scenario:Alert Issues-Scn20 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND4" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario20_3 data

  Scenario:Alert Issues-Scn36_P1 Load an CAN , then trigger an EOD and then load an AMD, the unexpected CAN on previous day should get removed and AMD should get balanced on value date (check without fails)
    And I click cancelButton
    And I load cashflow
      | fileName         | accountNo | referenceNo  | ammount    | calKey | overallStatus | startingDate |
      | Scenario36_Part1 | HTDACC6   | Scenario36_1 | -100000000 | NULL   | 1020          | 15/06/2018   |
    And I get "select OVERALL_STATUS from CMS_BDR_TRANSACTION where trans_ref_no='Scenario36_1'" query export "Scn36_1"

  Scenario: Performs EOD for TESTHOL region from Friday to Saturday
    And I perform EOD for "TESTHOL" region with CBD "2018-06-15" and last EOD execution "2018-06-14"

  Scenario:Alert Issues-Scn4 Check alert generation, if the Opening balance is less than or equal to 10000000, and also, there is an ACT cash flow that is cancelled
    And I load cashflow
      | fileName           | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | 3_HTDACC2-13th_4_4 | HTDACC3   | Scenario4_1 | -4000   | 12000  | 1003          | 17/06/2018   |
    And I load strategy
      | fileName                        |
      | strategy_HODHTDFND2_Wednesday_4 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND3;Status:OPEN"
    And I expand alert for fund "HODHTDFND3" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND3"
    And I verify alert result for "Scn04"

  Scenario:Alert Issues-Scn4 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND3" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario04 data

  Scenario:Alert Issues-Scn36_P2 Load an CAN , then trigger an EOD and then load an AMD, the unexpected CAN on previous day should get removed and AMD should get balanced on value date (check without fails)
    And I click cancelButton
    And I load cashflow
      | fileName         | accountNo | referenceNo  | ammount     | calKey | overallStatus | startingDate |
      | Scenario36_Part2 | HTDACC6   | Scenario36_1 | -1000000000 | 12002  | 1003          | 15/06/2018   |
    And I get "select OVERALL_STATUS,TXN_SEQUENCE_ID from CMS_BDR_TRANSACTION where trans_ref_no='Scenario36_1'" query export "Scn36_2"

  Scenario:Alert Issues-Scn37 To test whether CAN with sequnece number 3 is loaded on CAN with seuwnce number 2 which earlier have loaded on AMD with sequence number 1
    And I load cashflow
      | fileName     | accountNo | referenceNo  | ammount | calKey | overallStatus | startingDate |
      | 1_Scenario37 | HTDACC6   | Scenario36_1 | -100000 | NULL   | 1021          | 15/06/2018   |
      | 2_Scenario37 | HTDACC6   | Scenario36_1 | -10000  | NULL   | 1019          | 15/06/2018   |
    And I get "select OVERALL_STATUS,TXN_SEQUENCE_ID from CMS_BDR_TRANSACTION where trans_ref_no='Scenario36_1' order by overall_status,TXN_SEQUENCE_ID desc" query export "Scn37"

  Scenario: Performs EOD for TESTHOL region from Saturday to Sunday
    And I perform EOD for "TESTHOL" region with CBD "2018-06-16" and last EOD execution "2018-06-15"

  Scenario: Performs EOD for TESTHOL region from Sunday to Monday
    And I perform EOD for "TESTHOL" region with CBD "2018-06-17" and last EOD execution "2018-06-16"

  Scenario: Performs EOD for TESTHOL region from Monday to Tuesday
    And I perform EOD for "TESTHOL" region with CBD "2018-06-18" and last EOD execution "2018-06-17"

  Scenario:Alert Issues-Scn5 Weekend as a holiday and Monday also a holiday. Conf cashflow for Monday.
    And I load strategy
      | fileName                        |
      | strategy_HODHTDFND2_Wednesday_5 |
    And I navigate to home page
    And I go to the alert page
    And I apply alert filter "Fund/Account:HODHTDFND3;Status:OPEN"
    And I expand alert for fund "HODHTDFND3" having status "OPEN"
    And I remove alert filter "Fund/Account:HODHTDFND3"
    And I verify alert result for "Scn005"

  Scenario:Alert Issues-Scn5 Validate Preview
    And I collapse all rows on alert
    And I select fund "HODHTDFND3" having status "OPEN"
    And I click emailAndPreview
    And I verify scenario05 data
