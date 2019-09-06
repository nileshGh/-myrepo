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
#Various utilities
@Import("BDD\features-meta\loadingCashFlows.meta")
#Alert new specific functions
@Import("BDD\features-meta\alert.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Favorite specific functions
@Import("BDD\features-meta\favorite.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")
#Strategy specific functions
@Import("BDD\features-meta\strategy.meta")
#sweep page specific functions
@Import("BDD\features-meta\sweepPage.meta")



Feature:Sweep Pair Status
  Check various status available for end user
  For vairous type of account and there parent child relation


  Scenario:Prereq When a fund is created through UI/feed the icon will be green.
    Given moduleName is "sweepPairStatus"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "fund17user" user
    And I load fund
      | fileName |
      | FND17-1  |
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group    | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND17      | ''                 | ''                 | ''    | FND17GRP | ''       | ''         | ''                | ''        | ''                 | ''      | FUND17 Desc | ''                | ''           | ''          | ''            |

  Scenario:STRAT-408-TC002 Non Funded Accounts are excluded from participating in Primary CCY/Account dropdowns (AED)
    And testCaseNo is "STRAT-408-TC002"
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I click on add action for "Default strategy for 'FND17'" strategy
    And I change Type to "Sweep" for "ACTION X: ACTION NAME" action of "Default strategy for 'FND17'" strategy
    And I verify for "AED Primary Account" action type field options are ",FND17AEDC1,FND17AEDP1" for "ACTION X: ACTION NAME" action of "Default strategy for 'FND17'" strategy
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I create "SWEEP ACT" action of type "Sweep" having execution window "3 Days" for "Default strategy for 'FND17'" strategy
      | Suggestion          | SuggestionValue |
      | Primary Currency    | USD             |
      | AED Primary Account | FND17AEDP1      |
      | CAD Primary Account | FND17CADP1      |
      | HKD Primary Account | FND17HKDP1      |
      | JPY Primary Account | FND17JPYP1      |
      | USD Primary Account | FND17USDM       |
    And I "include" all "PROPOSED" sweep pairs for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
    And I exclude sweep pair for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
      | parentAccount | childAccount |
      | ''            | FND17JPYC1   |
    And I save changes to account group "FUND17"
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I verify for "AED Primary Account" action type field options are ",FND17AEDC1,FND17AEDP1" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy


  Scenario:STRAT-408-TC004 Viewing Non Funded Accounts in Sweep Pair structure (AED)
    And testCaseNo is "STRAT-408-TC004"
    And I navigate to home page
    And I go to the account group page
    And I navigate to page of account group "FUND17"
    And I validate sweep pair having parent account "" and child account "FND17AEDC2" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy is "NON FUNDED"
    And I verify sweep pair dashboard csv extract for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy as "${testCaseNo}"
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I verify sweep pair having parent account "" and child account "FND17AEDC2" with status "NON FUNDED" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy can not be part of sweep


  Scenario:STRAT-408-TC003 Prereq Non Funded Accounts are excluded from Sweep Pair structure (AED)
    And testCaseNo is "STRAT-408-TC003"
    And I load cashflow
      | fileName              | accountNo  | referenceNo           | ammount | calKey | overallStatus | startingDate |
      | STRAT408_FND17AEDC1_1 | FND17AEDC1 | FND17AEDC1            | -1000   | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17AEDC1_2 | FND17AEDC1 | FND17AEDC130          | -100    | 12000  | 1003          | 30/10/2018   |
      | STRAT408_FND17AEDC1_3 | FND17AEDC1 | FND17AEDC131          | -100    | 12000  | 1003          | 31/10/2018   |
      | STRAT408_FND17AEDC2_1 | FND17AEDC2 | FND17AEDC2            | -500    | NULL   | 1024          | 29/10/2018   |
      | STRAT408_FND17AEDC2_2 | FND17AEDC2 | FND17AEDC230          | -500    | NULL   | 1024          | 30/10/2018   |
      | STRAT408_FND17AEDC2_3 | FND17AEDC2 | FND17AEDC231          | -100    | NULL   | 1024          | 31/10/2018   |
      | STRAT408_FND17AEDP1_1 | FND17AEDP1 | FND17AEDP1            | 1000    | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17AEDP1_2 | FND17AEDP1 | FND17AEDP130          | 100     | 12000  | 1003          | 30/10/2018   |
      | STRAT408_FND17AEDP1_3 | FND17AEDP1 | FND17AEDP131          | 1000    | 12000  | 1003          | 31/10/2018   |
      | STRAT408_FND17AUDC1_1 | FND17AUDC1 | FND17AUDC1            | -500    | NULL   | 1024          | 29/10/2018   |
      | STRAT408_FND17AUDC1_2 | FND17AUDC1 | FND17AUDC130          | -600    | NULL   | 1024          | 30/10/2018   |
      | STRAT408_FND17AUDC1_3 | FND17AUDC1 | FND17AUDC131          | -200    | NULL   | 1024          | 31/10/2018   |
      | STRAT408_FND17AUDC2_1 | FND17AUDC2 | FND17AUDC2            | 500     | NULL   | 1024          | 29/10/2018   |
      | STRAT408_FND17AUDC2_2 | FND17AUDC2 | FND17AUDC230          | 300     | NULL   | 1024          | 30/10/2018   |
      | STRAT408_FND17AUDC2_3 | FND17AUDC2 | FND17AUDC231          | 100     | NULL   | 1024          | 31/10/2018   |
      | STRAT408_FND17BGDC1_1 | FND17BGDC1 | FND17BGDC1NonFunded   | -500    | NULL   | 1024          | 29/10/2018   |
      | STRAT408_FND17BGDC1_2 | FND17BGDC1 | FND17BGDC1NonFunded30 | -100    | NULL   | 1024          | 30/10/2018   |
      | STRAT408_FND17BGDC1_3 | FND17BGDC1 | FND17BGDC1NonFunded31 | -100    | NULL   | 1024          | 31/10/2018   |
      | STRAT408_FND17CADC1_1 | FND17CADC1 | FND17CADC1Nonfunded   | -500    | NULL   | 1024          | 29/10/2018   |
      | STRAT408_FND17CADC1_2 | FND17CADC1 | FND17CADC1Nonfunded30 | -200    | NULL   | 1024          | 30/10/2018   |
      | STRAT408_FND17CADC1_3 | FND17CADC1 | FND17CADC1Nonfunded31 | -500    | NULL   | 1024          | 31/10/2018   |
      | STRAT408_FND17CADP1_1 | FND17CADP1 | FND17CADP1            | -500    | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17CADP1_2 | FND17CADP1 | FND17CADP130          | -600    | 12000  | 1003          | 30/10/2018   |
      | STRAT408_FND17CADP1_3 | FND17CADP1 | FND17CADP131          | 400     | 12000  | 1003          | 31/10/2018   |
      | STRAT408_FND17GBPC1_1 | FND17GBPC1 | FND17GBPC1            | 500     | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17GBPC1_2 | FND17GBPC1 | FND17GBPC130          | -500    | 12000  | 1003          | 30/10/2018   |
      | STRAT408_FND17GBPC1_3 | FND17GBPC1 | FND17GBPC131          | 300     | 12000  | 1003          | 31/10/2018   |
      | STRAT408_FND17GBPC2_1 | FND17GBPC2 | FND17GBPC2            | -500    | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17GBPC2_2 | FND17GBPC2 | FND17GBPC230          | -1500   | 12000  | 1003          | 30/10/2018   |
      | STRAT408_FND17GBPC2_3 | FND17GBPC2 | FND17GBPC231          | -200    | 12000  | 1003          | 31/10/2018   |
      | STRAT408_FND17JPYC1_1 | FND17JPYC1 | FND17JPYC1            | -1000   | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17JPYC1_2 | FND17JPYC1 | FND17JPYC130          | -5000   | 12000  | 1003          | 30/10/2018   |
      | STRAT408_FND17JPYC1_3 | FND17JPYC1 | FND17JPYC131          | -100    | 12000  | 1003          | 31/10/2018   |
      | STRAT408_FND17JPYP1_1 | FND17JPYP1 | FND17JPYP1            | 200     | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17JPYP1_2 | FND17JPYP1 | FND17JPYP130          | -200    | 12000  | 1003          | 30/10/2018   |
      | STRAT408_FND17JPYP1_3 | FND17JPYP1 | FND17JPYP131          | -200    | 12000  | 1003          | 31/10/2018   |
      | STRAT408_FND17SGDC1_1 | FND17SGDC1 | FND17SGDC1NonFunded   | -500    | NULL   | 1024          | 29/10/2018   |
      | STRAT408_FND17SGDC1_2 | FND17SGDC1 | FND17SGDC1NonFunded30 | -1500   | NULL   | 1024          | 30/10/2018   |
      | STRAT408_FND17SGDC1_3 | FND17SGDC1 | FND17SGDC1NonFunded31 | -500    | NULL   | 1024          | 31/10/2018   |
      | STRAT408_FND17USDM_1  | FND17USDM  | FND17USDM             | 10000   | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17USDM_2  | FND17USDM  | FND17USDM30           | 1000    | 12000  | 1003          | 30/10/2018   |
      | STRAT408_FND17USDM_3  | FND17USDM  | FND17USDM31           | 10000   | 12000  | 1003          | 31/10/2018   |

  Scenario:STRAT-408-TC003 Non Funded Accounts are excluded from Sweep Pair structure (AED)
    And I load strategy
      | fileName      |
      | FND17Strategy |
    And I update CBD for "FUND17REGION" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I verify alerts csv for "${testCaseNo}_AlertDashboard"
    And I update CBD for "FUND17REGION" region to "29-OCT-18"
    And I login as "fund17user" user
    And I go to the ladder page
    And I set ladder daterange from "29/10/2018" to "01/11/2018"
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Cashflows with open exceptions - STANDARD"
    And I verify balances csv for "${testCaseNo}_LadderDashboard"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND17"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testCaseNo}_SweepDashboard"

  Scenario:STRAT-408-TC005 All accounts in a CCY are NON FUNDED  (AUD)
    And testCaseNo is "STRAT-408-TC005"
    And I navigate to home page
    And I go to the account group page
    And I open group "FUND17" to edit
    And I verify for "Primary Currency" action type field options are ",AED,CAD,GBP,HKD,JPY,USD" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
    And I verify in suggest structure "AUD Primary Account" for "Default strategy for 'FND17'" strategy with "SWEEP ACT" action is not present


  Scenario: STRAT-616  Can not change account type when account is part of the fund
    And I can not modify "AccountType" of account "FND17JPYC1" from "NOSTRO" to "NON FUNDED"

  Scenario:STRAT-408-TC006 Funded account changed to non funded  (JPY)
    And testCaseNo is "STRAT-408-TC006"
    And I navigate to account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND17      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | ''          | FND17JPYC1    |
    And I change account type
      | accountName | currency | bank    | accountRegion | holidayID | legalEntity    | accountType |
      | FND17JPYC1  | JPY      | BANKJPY | FUND17REGION  | NoHol     | HSSLEGALENTITY | NON FUNDED  |

  Scenario:Intermittent Known Issue- Approve the fund before adding account back to fund
    And I login as "functional" user
    And I go to the account group page
    And I approve account group "FUND17"

  Scenario: STRAT-408-TC006 Funded account changed to non funded  (JPY)
    And I login as "fund17user" user
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND17      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | FND17JPYC1  | ''            |
    And I navigate to account group page
    And I navigate to page of account group "FUND17"
    And I verify sweep pair having parent account "" and child account "FND17JPYC1" with status "NON FUNDED" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy can not be part of sweep
    And I verify sweep pair dashboard csv extract for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy as "${testCaseNo}"


  Scenario:STRAT-408-TC007 Prereq Non Funded account changed to funded, primary account exists  (CAD,AED)
    And testCaseNo is "STRAT-408-TC007"
    And I navigate to account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount         |
      | FUND17      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | ''          | FND17CADC1;FND17AEDC2 |
    And I change account type
      | accountName | currency | bank    | accountRegion | holidayID | legalEntity    | accountType |
      | FND17CADC1  | CAD      | BANKCAD | FUND17REGION  | NoHol     | HSSLEGALENTITY | NOSTRO      |
      | FND17AEDC2  | AED      | BANKAED | FUND17REGION  | NoHol     | HSSLEGALENTITY | NOSTRO      |

  Scenario:Intermittent known issue-Approve the fund before adding account back to fund
    And I login as "functional" user
    And I go to the account group page
    And I approve account group "FUND17"

  Scenario:STRAT-408-TC007 Prereq Non Funded account changed to funded, primary account exists  (CAD,AED)
    And I login as "fund17user" user
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts           | removeAccount |
      | FUND17      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | FND17CADC1;FND17AEDC2 | ''            |
    And I navigate to account group page
    And I navigate to page of account group "FUND17"
    And I validate sweep pair having parent account "FND17CADP1" and child account "FND17CADC1" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy is "PROPOSED"
    And I validate sweep pair having parent account "FND17AEDP1" and child account "FND17AEDC2" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy is "PROPOSED"
    And I verify sweep pair dashboard csv extract for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy as "${testCaseNo}"

  Scenario:STRAT-408-TC007 Non Funded account changed to funded, primary account exists  (CAD,AED)
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I exclude sweep pair for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
      | parentAccount | childAccount |
      | FND17AEDP1    | FND17AEDC2   |
    And I include sweep pair for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
      | parentAccount | childAccount |
      | FND17CADP1    | FND17CADC1   |
    And I save changes to account group "FUND17"


  Scenario:STRAT-408-TC008 Prereq Non Funded account changed to funded, primary account does not exist (SGD,BGD)
    And testCaseNo is "STRAT-408-TC008"
    And I navigate to account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount         |
      | FUND17      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | ''          | FND17SGDC1;FND17BGDC1 |
    And I change account type
      | accountName | currency | bank    | accountRegion | holidayID | legalEntity    | accountType |
      | FND17SGDC1  | SGD      | BANKSGD | FUND17REGION  | NoHol     | HSSLEGALENTITY | NOSTRO      |
      | FND17BGDC1  | BGD      | BANKBGD | FUND17REGION  | NoHol     | HSSLEGALENTITY | NOSTRO      |

  Scenario:Approve the fund before adding account back to fund
    And I login as "functional" user
    And I go to the account group page
    And I approve account group "FUND17"
  
  Scenario:STRAT-408-TC008 Prereq Non Funded account changed to funded, primary account does not exist (SGD,BGD)
    And I login as "fund17user" user
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts           | removeAccount |
      | FUND17      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | FND17SGDC1;FND17BGDC1 | ''            |
    And I navigate to account group page
    And I navigate to page of account group "FUND17"
    And I verify in suggest structure "SGD Primary Account" has value "" for "Default strategy for 'FND17'" strategy with "SWEEP ACT" action
    And I verify in suggest structure "BGD Primary Account" has value "" for "Default strategy for 'FND17'" strategy with "SWEEP ACT" action
    And I validate sweep pair having parent account "" and child account "FND17SGDC1" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy is "NO PARENT"
    And I validate sweep pair having parent account "" and child account "FND17BGDC1" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy is "NO PARENT"
    And I verify sweep pair dashboard csv extract for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy as "${testCaseNo}"

  Scenario:STRAT-408-TC008 Non Funded account changed to funded, primary account does not exist (SGD,BGD)
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I verify sweep pair having parent account "" and child account "FND17SGDC1" with status "NO PARENT" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy can not be part of sweep
    And I verify sweep pair having parent account "" and child account "FND17BGDC1" with status "NO PARENT" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy can not be part of sweep
    And I load cashflow
      | fileName              | accountNo  | referenceNo      | ammount | calKey | overallStatus | startingDate |
      | STRAT408_FND17AEDC2_4 | FND17AEDC2 | FND17AEDC2Funded | -500    | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17BGDC1_4 | FND17BGDC1 | FND17BGDC1Funded | -500    | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17CADC1_4 | FND17CADC1 | FND17CADC1Funded | -500    | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17SGDC1_4 | FND17SGDC1 | FND17SGDC1Funded | -500    | 12000  | 1003          | 29/10/2018   |
      | STRAT408_FND17JPYC1_4 | FND17JPYC1 | FND17JPYC1       | -1000   | NULL   | 1024          | 29/10/2018   |
    And I load strategy
      | fileName      |
      | FND17Strategy |
    And I update CBD for "FUND17REGION" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I verify alerts csv for "${testCaseNo}_AlertDashboard"
    And I update CBD for "FUND17REGION" region to "29-OCT-18"
    And I login as "fund17user" user
    And I go to the ladder page
    And I set ladder daterange from "29/10/2018" to "01/11/2018"
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Cashflows with open exceptions - STANDARD"
    And I verify balances csv for "${testCaseNo}_LadderDashboard"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND17"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testCaseNo}_SweepDashboard"
    And I get "select ACCOUNT_ID,trans_ref_no,AMOUNT,current_calc_key,overall_status from cms_bdr_transaction where trans_ref_no like 'FND17JPYC1' ORDER BY OVERALL_STATUS" query export "TC68-01"


  Scenario:STRAT-408-TC009 If that is the only account in that currency and it is changed to funded (SGD,BGD)
    And testCaseNo is "STRAT-408-TC009"
    And I navigate to home page
    And I go to the account group page
    And I open group "FUND17" to edit
    And I edit "SWEEP ACT" action of type "Sweep" to execution window "3 Days" for "Default strategy for 'FND17'" strategy
      | Suggestion          | SuggestionValue |
      | BGD Primary Account | FND17BGDC1      |
      | SGD Primary Account | FND17SGDC1      |
    And I exclude sweep pair for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
      | parentAccount | childAccount |
      | FND17USDM     | FND17BGDC1   |
    And I include sweep pair for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
      | parentAccount | childAccount |
      | FND17USDM     | FND17SGDC1   |
    And I save changes to account group "FUND17"
    And I load strategy
      | fileName      |
      | FND17Strategy |
    And I update CBD for "FUND17REGION" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I sort descending "Strat Exec Date Time"
    And I verify alerts csv for "${testCaseNo}_AlertDashboard"
    And I update CBD for "FUND17REGION" region to "29-OCT-18"
    And I login as "fund17user" user
    And I go to the ladder page
    And I set ladder daterange from "29/10/2018" to "01/11/2018"
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Cashflows with open exceptions - STANDARD"
    And I verify balances csv for "${testCaseNo}_LadderDashboard"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND17"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testCaseNo}_SweepDashboard"


  Scenario:STRAT-508-TC001 New Account added - No Parent in that currency (GBP) / STRAT-718
    And testCaseNo is "STRAT-508-TC001"
    And I load fund
      | fileName |
      | FND17-2  |
    And I login as "fund17user" user
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND17      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | FUND17 Desc | ''                | ''           | ''          | ''            |
    And I navigate to account group page
    And I navigate to page of account group "FUND17"
    And I verify in suggest structure "GBP Primary Account" has value "" for "Default strategy for 'FND17'" strategy with "SWEEP ACT" action
    And I validate sweep pair having parent account "" and child account "FND17GBPC1" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy is "NO PARENT"
    And I validate sweep pair having parent account "" and child account "FND17GBPC2" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy is "NO PARENT"
    And I verify sweep pair dashboard csv extract for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy as "${testCaseNo}"
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I verify options of sweep pair for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
      | sweepPairs                          | include | exclude |
      | '':FND17GBPC1;FND17USDM:FND17AEDP1  | absent  | absent  |
      | '':FND17GBPC2;FND17AEDP1:FND17AEDC2 | absent  | absent  |

  Scenario:STRAT-508-TC002 New Account added - Parent exists for that currency
    And testCaseNo is "STRAT-508-TC002"
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I edit "SWEEP ACT" action of type "Sweep" to execution window "3 Days" for "Default strategy for 'FND17'" strategy
      | Suggestion          | SuggestionValue |
      | GBP Primary Account | FND17GBPP1      |
    And I include sweep pair for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
      | parentAccount | childAccount |
      | FND17USDM     | FND17GBPP1   |
      | FND17GBPP1    | FND17GBPC1   |
    And I exclude sweep pair for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
      | parentAccount | childAccount |
      | FND17GBPP1    | FND17GBPC2   |
    And I save changes to account group "FUND17"
    And I navigate to account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND17      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | FND17GBPC3  | ''            |
    And I navigate to account group page
    And I navigate to page of account group "FUND17"
    And I verify in suggest structure "GBP Primary Account" has value "FND17GBPP1" for "Default strategy for 'FND17'" strategy with "SWEEP ACT" action
    And I verify sweep pair dashboard csv extract for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy as "${testCaseNo}"

  Scenario: STRAT-718 Multi select
    And testCaseNo is "STRAT-718-TC001"
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I verify options of sweep pair for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
      | sweepPairs                                  | include | exclude |
      | FND17AEDP1:FND17AEDC1;FND17USDM:FND17AEDP1  | absent  | present |
      | FND17AEDP1:FND17AEDC2;FND17USDM:FND17BGDC1  | present | absent  |
      | FND17AEDP1:FND17AEDC1;FND17GBPP1:FND17GBPC3 | absent  | present |
      | FND17AEDP1:FND17AEDC2;FND17GBPP1:FND17GBPC3 | present | absent  |
      | '':FND17AUDC1;FND17USDM:FND17AEDP1          | absent  | absent  |
      | '':FND17AUDC2;FND17USDM:FND17BGDC1          | absent  | absent  |
      | '':FND17AUDC2;'':FND17USDM                  | absent  | absent  |
    And I select sweep pair for parent account "FND17GBPP1" and child account "FND17GBPC3" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
    And I select sweep pair for parent account "FND17AEDP1" and child account "FND17AEDC2" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
    And I right click rowToBeSelected
    And I click includeSweepButton
    And I unselect all sweep pairs for "Default strategy for 'FND17'" strategy with "SWEEP ACT" action
    And I select sweep pair for parent account "FND17AEDP1" and child account "FND17AEDC1" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
    And I select sweep pair for parent account "FND17USDM" and child account "FND17AEDP1" for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy
    And I right click rowToBeSelected
    And I click excludeSweepButton
    And I save changes to account group "FUND17"
    And I verify sweep pair dashboard csv extract for "SWEEP ACT" action of "Default strategy for 'FND17'" strategy as "${testCaseNo}"


  Scenario:STRAT-195-TC001 Change the primary currency and sweep
    And testCaseNo is "STRAT-195-TC001"
    And I navigate to account group page
    And I open group "FUND17" to edit
    And I edit "SWEEP ACT" action of type "Sweep" to execution window "3 Days" for "Default strategy for 'FND17'" strategy
      | Suggestion       | SuggestionValue |
      | Primary Currency | AED             |
    And I save changes to account group "FUND17"
    And I load cashflow
      | fileName              | accountNo  | referenceNo | ammount | calKey | overallStatus | startingDate |
      | STRAT408_FND17GBPC3_5 | FND17GBPC3 | FND17GBPC3  | -500    | 12000  | 1003          | 29/10/2018   |
    And I load strategy
      | fileName      |
      | FND17Strategy |
    And I update CBD for "FUND17REGION" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I sort descending "Strat Exec Date Time"
    And I verify alerts csv for "${testCaseNo}_AlertDashboard"
    And I update CBD for "FUND17REGION" region to "29-OCT-18"
    And I login as "fund17user" user
    And I go to the ladder page
    And I set ladder daterange from "29/10/2018" to "01/11/2018"
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Cashflows with open exceptions - STANDARD"
    And I verify balances csv for "${testCaseNo}_LadderDashboard"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND17"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testCaseNo}_SweepDashboard"

  Scenario: STRAT-616 Can not change bank when account is part of the fund
    And I can not modify "Bank" of account "FND17JPYC1" from "BANKJPY" to "BANKDGD"

  Scenario: STRAT-616  Can not change account type when account is part of the fund
    And I can not modify "AccountType" of account "FND17JPYC1" from "NON FUNDED" to "NOSTRO"

  Scenario: STRAT-616 Can change accountType when account is removed from fund
    And I navigate to home page
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND17      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | ''          | FND17JPYC1    |
    And I change account type
      | accountName | currency | bank    | accountRegion | holidayID | legalEntity    | accountType |
      | FND17JPYC1  | JPY      | BANKJPY | FUND17REGION  | NoHol     | HSSLEGALENTITY | NOSTRO      |

  Scenario: STRAT-616  Can change Bank after removing account from fund
    And I change "Bank" for "FND17JPYC1" account to "BANKDGD"
    And I verify "Bank" of account "FND17JPYC1" is "BANKDGD"