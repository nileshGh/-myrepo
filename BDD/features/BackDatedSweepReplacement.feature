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
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#Various utilities
@Import("BDD\features-meta\loadingCashFlows.meta")
#Alert new specific functions
@Import("BDD\features-meta\alert.meta")
@Import("BDD\features-meta\accountGroups.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#sweep page specific functions
@Import("BDD\features-meta\sweepPage.meta")
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")

Feature: Back Dated Sweep Replacement

   Scenario: Pre-req
      Given moduleName is "backDatedSweepReplacement"
      And I reset my gwen.web.chrome.prefs setting
      And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
      And I login as "fund101user" user

   Scenario: Creation of new Fund and Sweep Structure
      Given I go to the account group page
      And I load account
         | fileName             |
         | ACCOUNT_AEDC1_FND101 |
         | ACCOUNT_AEDP1_FND101 |
         | ACCOUNT_USDM_FND101  |
      And I execute query "UPDATE CMS_REF_ACCOUNT_PARAM SET REGION_NAME='FUND101REGION' WHERE NAME LIKE 'FND101%'" to update " " rows
      And I execute query "UPDATE CMS_REF_ACCOUNT_PARAM SET HOLIDAY_ID='NoHol' WHERE REGION_NAME='FUND101REGION'" to update " " rows
      And I open create account group form
      And I create account group
         | testcaseNo | Account Group Type | Account Group Code | Email          | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address         | Description         | Bank Legal Entity | FX Rate Type | accounts                           |
         | TC001      | Fund               | FND101             | FND101@HSS.COM | FND101GRP | ''       | ''         | ''                | ''        | FUND101            | FUND101 Address | FUND101-Description | ''                | ''           | FND101AEDC1;FND101AEDP1;FND101USDM |
      And I open group "FUND101" to edit
      And I add new strategy
         | StrategyName                | ExecutionDays | ActionName | ActionType | ExecutionWindow | Suggestions                                                                         |
         | DEFAULT STRATEGY FOR FND101 | ''            | MYACT      | Sweep      | 4 Days          | Primary Currency:USD;AED Primary Account:FND101AEDP1;USD Primary Account:FND101USDM |
      And I "include" all "PROPOSED" sweep pairs for "MYACT" action of "DEFAULT STRATEGY FOR FND101" strategy

   Scenario: Load Cashflow and Strategy for Day1
      Given I update CBD for "FUND101REGION" region to "22-JUN-18"
      And I navigate to home page
      And I go to the ladder page
      And I load cashflow
         | fileName                           | accountNo   | referenceNo                     | ammount | calKey | overallStatus | startingDate |
         | ACTUAL_FND101AEDC1_NEGATIVEBALANCE | FND101AEDC1 | FND101AEDC1_ORIGNAL_TRANSACTION | -4000   | 12000  | 1003          | 22/06/2018   |
      And I load strategy
         | fileName        |
         | STRATEGY_FND101 |

   Scenario: Verify Ladder dashboard before Rollover EOD
      Given testcaseName is "TC001"
      And I navigate to home page
      And I go to the ladder page
      And I set ladder daterange from "22/06/2018" to "24/06/2018"
      And selectedPerspective is "Fund/Currency/Account/Category"
      And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE"
      And I verify balances csv for "${testcaseName}"

   Scenario: Verify Sweep dashboard before Rollover EOD
      Given testcaseName is "TC002"
      And I navigate to home page
      And I go to the sweeps page
      And I verify sweeps csv for "${testcaseName}"

   Scenario: Run EOD and Partially Replace Backdated Sweeps
      Given I navigate to home page
      And I perform EOD for "FUND101REGION" region with CBD "2018-06-22" and last EOD execution "2018-06-21"
      And I load cashflow
         | fileName                         | accountNo   | referenceNo                 | ammount | calKey | overallStatus | startingDate |
         | OPEN_FND101AEDC1_NEGATIVEBALANCE | FND101AEDC1 | FND101AEDC1_OPENING_BALANCE | -4000   | 12002  | 1003          | 23/06/2018   |
      And I get transaction reference number for account "FND101AEDC1" having value date "22-JUN-18" amount "4000" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReference}" with details "FND101AEDC1:2018-06-22:2018-06-23:4000:DPS:ACT:NEW:REPLACEMENT_SWEEP1_CHILDACC:${transactionReference}:1:AED:FND101:Trade"
      And I get transaction reference number for account "FND101USDM" having value date "22-JUN-18" amount "1080" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReference}" with details "FND101USDM:2018-06-23:2018-06-23:-1080:DPS:ACT:NEW:REPLACEMENT_SWEEP2_PARENTACC:${transactionReference}:1:USD:FND101:Trade"
      And I load strategy
         | fileName        |
         | STRATEGY_FND101 |

   Scenario: Verify Ladder dashboard after Rollover EOD
      Given testcaseName is "TC003"
      And I go to the ladder page
      And I set ladder daterange from "23/06/2018" to "24/06/2018"
      And selectedPerspective is "Fund/Currency/Account/Category"
      And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:"
      And I verify balances csv for "${testcaseName}"

   Scenario: Verify Sweep dashboard after Rollover EOD
      Given testcaseName is "TC004"
      And I navigate to home page
      And I go to the sweeps page
      And I verify sweeps csv for "${testcaseName}"
