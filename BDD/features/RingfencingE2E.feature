@ladder @Smoke @regression
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#loading Cashflows
@Import("BDD\features-meta\loadingCashFlows.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")
#alert specific functions
@Import("BDD\features-meta\alert.meta")
#NEW Cash tlmview grid specific functions
@Import("BDD\features-meta\gridLib.meta")
#NEW Cash tlmviewDashboard specific functions
@Import("BDD\features-meta\tlmviewDashboard.meta")
#sweep page specific functions
@Import("BDD\features-meta\sweepPage.meta")
#timeline meta
@Import("BDD\features-meta\timeline.meta")

Feature: RingfencingE2EViaFeed
   Test case for cash ladder
   As a cash manager
   for Ringfencing feature

   Scenario:Create group
      Given moduleName is "ringfencingE2E"
      And I reset my gwen.web.chrome.prefs setting
      And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
      Then I login as "fund5user" user
      And I go to the group management page
      And I create group
         | groupName | groupDescription          | selectUser |
         | FND5GRP   | FND5GRP Group Description | FND5USR    |

   Scenario:Edit account group
      Then I login as "fund5user" user
      And I go to the account group page
      And I open group to edit
         | GroupToEdit | Account Group Type | Account Group Code | Email | Group   | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
         | FUND5       | ''                 | ''                 | ''    | FND5GRP | ''       | ''         | ''                | ''        | ''                 | ''      | Fund5 Test  | ''                | ''           | ''          | ''            |
      And  I navigate to page of account group "FUND5"
      And I verify account group have "Fund" "FND5" "QaAutomation@smartstream-stp.com" "FND5GRP" "''" "''" "Full" "FUND5" "Fund5 Address" "Fund5 Test" "''" "''" "FND5USDM;FND5USDC1;FND5USDC2;FND5HKDP1;FND5HKDC1;FND5HKDP2;FND5HKDC2;FND5GBPP1;FND5GBPC1;FND5GBPC2;FND5GBPC3;FND5AEDP1;FND5AEDC1;FND5AEDC2;FND5JPYP1;FND5JPYC1;FND5CADP1;FND5CADC1;FND5AUDP1;FND5AUDC1;FND5AUDC2"
      And I verify Execution Days for "Default strategy for 'FND5'" strategy is "4 Days"
      And I verify Type is having value "Overdraft Check" for "Default Action" action of "Default strategy for 'FND5'" strategy
      And I verify Execution Window is having value "4 Days" for "Default Action" action of "Default strategy for 'FND5'" strategy

   Scenario:Add strategy in account group
      And I navigate to account group page
      And I open group "FUND5" to edit
      And I change Execution Window to "5 Days" for "Default Action" action of "Default strategy for 'FND5'" strategy
      And I create "SI EXEC FOR PREFUNNDINGWITHHOLIDAY" action of type "Sweep" having execution window "5 Days" for "Default strategy for 'FND5'" strategy
         | Suggestion          | SuggestionValue |
         | Primary Currency    | USD             |
         | AED Primary Account | FND5AEDP1       |
         | AUD Primary Account | FND5AUDP1       |
         | CAD Primary Account | FND5CADP1       |
         | GBP Primary Account | FND5GBPP1       |
         | HKD Primary Account | FND5HKDP1       |
         | JPY Primary Account | FND5JPYP1       |
         | USD Primary Account | FND5USDM        |
      And I "include" all "PROPOSED" sweep pairs for "SI EXEC FOR PREFUNNDINGWITHHOLIDAY" action of "Default strategy for 'FND5'" strategy
      And I exclude sweep pair for "SI EXEC FOR PREFUNNDINGWITHHOLIDAY" action of "Default strategy for 'FND5'" strategy
         | parentAccount | childAccount |
         | FND5HKDP1     | FND5HKDP2    |
   ## Scenario:Add strategy in account group
   ##   And I login as "functional" user
   ##   And I go to the account group page
   ##   Then I approve account group "FUND5"

   Scenario: Execute strategy
      And I load strategy
         | fileName       |
         | Strategy_FUND5 |

   Scenario:  Validate balances on ladder after strategy execution with perspective "Fund/Currency/Account/Category"
      Given testcaseName is "TC002"
      And I login as "fund5user" user
      And I go to the ladder page
      And I set ladder daterange from "28/10/2018" to "05/11/2018"
      And I select perspective "Fund/Currency/Account/Category"
      And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD"
      And I verify balances csv for "${testcaseName}"

   Scenario Outline: Verify transaction ladder for selected balance from ladder
      Given I am on the ladder page
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      @smoke
      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC003      | Confirmed (Matched) cash events - STANDARD | 28/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:USD:FND5USDC2:SWEEP | Account:=FND5USDC2 |
         | TC004      | Ringfenced - STANDARD                      | 28/10/2018 Ringfenced - STANDARD                      | FND5:USD:FND5USDC2:SWEEP | Account:=FND5USDC2 |
         | TC005      | Ringfenced - STANDARD                      | 29/10/2018 Ringfenced - STANDARD                      | FND5:USD:FND5USDC2:SWEEP | Account:=FND5USDC2 |

   Scenario: Validate alert dashboard after strategy execution
      Given testcaseName is "TC006"
      And I update CBD for "FUND5REGION" region to "SYSDATE"
      And I navigate to home page
      And I go to the alert page
      And I expand all rows on alert
      And  I sort ascending "Fund/Account"
      And I verify alerts csv for "${testcaseName}_AlertDashboard"
      And I collapse all rows on alert
      And emailHeadingFND5 is "FUND5"
      And emailAndPreviewFND5 is " Please note that we have identified a potential funding shortfalls on FUND5 per the following details:Account Code: FND5USDMAccount Full Name: Fund5USDMAmount: USD -21,267,781,147.756Value Date: 28-Oct-2018Opening Statement Balance17,000.000Sweep-21,267,798,147.756Account Code: FND5USDMAccount Full Name: Fund5USDMAmount: USD -20,119,392,153.014Value Date: 29-Oct-2018Opening Balance-21,267,781,147.756Sweep1,148,358,994.342Trade30,000.400Account Code: FND5USDMAccount Full Name: Fund5USDMAmount: USD -144,248,233,802.723Value Date: 30-Oct-2018Opening Balance-20,119,392,153.014Sweep-124,128,871,651.109Trade30,001.400Account Code: FND5USDMAccount Full Name: Fund5USDMAmount: USD -144,260,956,025.038Value Date: 31-Oct-2018Opening Balance-144,248,233,802.723FX30,002.400Sweep-12,752,224.715Account Code: FND5USDMAccount Full Name: Fund5USDMAmount: USD -144,260,933,104.615Value Date: 01-Nov-2018Opening Balance-144,260,956,025.038FX30,003.400Sweep-7,082.977IMPORTANT NOTE: The potential funding shortfall herein is provided to you by The Hongkong and Shanghai Banking Corporation Limited (\"HSBC\") on your relevant cash accounts opened in accordance with your custody terms with HSBC. This is provided for information purposes only and based on transactions which we are aware of and anticipate posting to your relevant cash account today and/or future calendar days applicable, i.e. our forecast at the time of this email, however HSBC has no obligation to send this email and reserves the right to not send any similar notifications in the future. HSBC does not make any guarantee, representations or warranties to the accuracy or completeness of the information in this email, and shall have no liability to you or any other person arising from the provision of this email."
      And I verify closing alert and sent mail
         | fundName | status | accountCode | selection |
         | FND5     | OPEN   | FND5USDM    |           |

   Scenario: Validate sweep dashboard after strategy execution
      Given testcaseName is "TC007"
      And I update CBD for "FUND5REGION" region to "28-OCT-18"
      And I navigate to home page
      And I go to the sweeps page
      And I apply sweep filter "Fund Name:FUND5"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify sweeps csv for "${testcaseName}"

   Scenario: ReExecute strategy
      And I load strategy
         | fileName       |
         | Strategy_FUND5 |

   Scenario: Validate ladder dashboard after strategy re-sexecution
      Given testcaseName is "TC015"
      And I login as "fund5user" user
      And I go to the ladder page
      And I set ladder daterange from "28/10/2018" to "05/11/2018"
      And I select perspective "Fund/Currency/Account/Category"
      And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD"
      And I verify balances csv for "${testcaseName}"

   Scenario: Validate sweep dashboard after strategy re-execution
      Given testcaseName is "TC016"
      And I navigate to home page
      And I go to the sweeps page
      And I verify timeline sidebar button is not visible
      And I apply sweep filter "Fund Name:FUND5"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify sweeps csv for "${testcaseName}"

   Scenario: Cancel sweep
      And I navigate to home page
      And I go to the sweeps page
      And I submit to cancel sweep "1" with reason "Cancelling Fund5 sweep by automation"
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND5USDM        | FND5USDC2     | 2468558710 |
      And I login as "fund6user" user
      And I go to the sweeps page
      And I approve cancel "1" sweep
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND5USDM        | FND5USDC2     | 2468558710 |

   Scenario:  Validate balances on ladder after strategy execution with perspective "Fund/Currency/Account/Category" after cancel sweep
      Given testcaseName is "TC008"
      And I login as "fund5user" user
      And I go to the ladder page
      And I set ladder daterange from "28/10/2018" to "05/11/2018"
      And I select perspective "Fund/Currency/Account/Category"
      And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD"
      And I verify balances csv for "${testcaseName}"

   Scenario Outline: Verify transaction ladder for selected balance from ladder after cancel sweep
      Given I am on the ladder page
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I verify all transaction from transaction grid for testcase "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC010      | Confirmed (Matched) cash events - STANDARD | 28/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:USD:FND5USDC2:SWEEP | Account:=FND5USDC2 |
         | TC011      | Ringfenced - STANDARD                      | 28/10/2018 Ringfenced - STANDARD                      | FND5:USD:FND5USDC2:SWEEP | Account:=FND5USDC2 |
         | TC012      | Ringfenced - STANDARD                      | 29/10/2018 Ringfenced - STANDARD                      | FND5:USD:FND5USDC2:SWEEP | Account:=FND5USDC2 |

   Scenario:Get transaction history of Ringfenced transaction after cancel sweep
      And  I apply ladder filter "Account:=FND5USDC2"
      And  I open transaction details of "29/10/2018 Ringfenced - STANDARD" and "FND5:USD:FND5USDC2:SWEEP"
      And  I check showAllTransactions
      And I open transaction history details for transaction with "Account" "FND5USDC2"
      And I extract transaction history csv for "TC013"

   Scenario: Get transaction history of sweeped transaction after cancel sweep
      And  I select balanceType "Confirmed (Matched) cash events - STANDARD"
      And  I apply ladder filter "Account:=FND5USDM"
      And  I open transaction details of "28/10/2018 Confirmed (Matched) cash events - STANDARD" and "FND5:USD:FND5USDM:SWEEP"
      And  I check showAllTransactions
      And I open transaction history details for transaction with "Amount" "-2,468,558,710.000"
      And I extract transaction history csv for "TC014"

   Scenario: sweep is ringfenced and replaced by a transaction with a different amount
      And I get transaction reference number for account "FND5AEDP1" having value date "31-OCT-18" amount "-9063.12" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5AEDC1:2018-10-31:2018-10-31:1000:DPS:ACT:CNF:STRAT_6321:${transactionReferenceNumber}:1:AED:FND5:Cash"
      And I navigate to home page
      And I go to the ladder page
      And I select perspective "Fund/Currency/Account/Category"

   Scenario Outline: sweep is ringfenced and replaced by a transaction with a different amount
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC020      | Confirmed (Matched) cash events - STANDARD | 31/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:AED:FND5AEDC1:SWEEP | Account:=FND5AEDC1 |
         | TC021      | Confirmed (Matched) cash events - STANDARD | 31/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:AED:FND5AEDC1:Cash  | Account:=FND5AEDC1 |
         | TC022      | Ringfenced - STANDARD                      | 31/10/2018 Ringfenced - STANDARD                      | FND5:AED:FND5AEDC1:SWEEP | Account:=FND5AEDC1 |

   Scenario: sweep is ringfenced and replaced by a transaction. AMD is received for that transaction then ringfenced transaction is also superseded by the new AMD transaction
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5AEDC1:2018-10-31:2018-10-31:1111:DPS:ACT:AMD:STRAT_6321:${transactionReferenceNumber}:3:AED:FND5:Cash"
      And I navigate to home page
      And I go to the ladder page

   Scenario Outline: sweep is ringfenced and replaced by a transaction. AMD is received for that transaction then ringfenced transaction is also superseded by the new AMD transaction
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC023      | Confirmed (Matched) cash events - STANDARD | 31/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:AED:FND5AEDC1:SWEEP | Account:=FND5AEDC1 |
         | TC024      | Confirmed (Matched) cash events - STANDARD | 31/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:AED:FND5AEDC1:Cash  | Account:=FND5AEDC1 |
         | TC025      | Ringfenced - STANDARD                      | 31/10/2018 Ringfenced - STANDARD                      | FND5:AED:FND5AEDC1:SWEEP | Account:=FND5AEDC1 |

   Scenario Outline: STRAT754- Cancelling a partially replaced ringfenced replacement should not change the sweep status
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5AEDC1:2018-10-31:2018-10-31:1111:DPS:ACT:CAN:STRAT_6321:${transactionReferenceNumber}:4:AED:FND5:Cash"
      Given testcaseName is "STRAT754_1"
      And I navigate to home page
      And I go to the sweeps page
      And I apply sweep filter "From Account Code:FND5AEDP1;To Account Code:FND5AEDC1;From Amount:9063.12"
      And I verify sweeps csv for "${testcaseName}"

   Scenario: sweep is ringfenced and CAN is received for replaced Parent transaction. ringfenced transactions are NOT cancelled
      And I get transaction reference number for account "FND5HKDC1" having value date "31-OCT-18" amount "-628694750.2" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5HKDP1:2018-10-31:2018-10-31:628694750.4:DPS:ACT:NEW:STRAT_6323:${transactionReferenceNumber}:1:HKD:FND5:Cash"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5HKDP1:2018-10-31:2018-10-31:628694750.4:DPS:ACT:CAN:STRAT_6323:${transactionReferenceNumber}:2:HKD:FND5:Cash"
      And I navigate to home page
      And I go to the ladder page

   Scenario Outline: sweep is ringfenced and CAN is received for replaced Parent transaction. ringfenced transactions are NOT cancelled
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC026      | Confirmed (Matched) cash events - STANDARD | 31/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:HKD:FND5HKDP1:SWEEP | Account:=FND5HKDP1 |
         | TC029      | Confirmed (Matched) cash events - STANDARD | 31/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:HKD:FND5HKDC1:SWEEP | Account:=FND5HKDC1 |
         | TC030      | Ringfenced - STANDARD                      | 29/10/2018 Ringfenced - STANDARD                      | FND5:HKD:FND5HKDC1:SWEEP | Account:=FND5HKDC1 |
         | TC031      | Ringfenced - STANDARD                      | 30/10/2018 Ringfenced - STANDARD                      | FND5:HKD:FND5HKDC1:SWEEP | Account:=FND5HKDC1 |
         | TC027      | Confirmed (Matched) cash events - STANDARD | 31/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:HKD:FND5HKDP1:Cash  | Account:=FND5HKDP1 |

   Scenario: Verify transaction history balances
      And I apply ladder filter "Account:=FND5HKDP1"
      And I open transaction details of "31/10/2018 Confirmed (Matched) cash events - STANDARD" and "FND5:HKD:FND5HKDP1:Cash"
      And I check showAllTransactions
      And I open transaction history details for transaction with "Transaction Reference" "STRAT_6323"
      And I extract transaction history csv for "TC028"

   Scenario: sweep is ringfenced and CAN is received for replaced Child transaction. ringfenced transactions are also cancelled
      And I get transaction reference number for account "FND5HKDC1" having value date "31-OCT-18" amount "-628694750.2" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5HKDC1:2018-10-31:2018-10-31:-628694750.4:DPS:ACT:NEW:STRAT_6324_1:${transactionReferenceNumber}:1:HKD:FND5:Cash"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5HKDC1:2018-10-31:2018-10-31:628694750.4:DPS:ACT:CAN:STRAT_6324_1:${transactionReferenceNumber}:2:HKD:FND5:Cash"
      And I navigate to home page
      And I go to the ladder page

   Scenario Outline: sweep is ringfenced and CAN is received for replaced Child transaction. ringfenced transactions are also cancelled
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending on transaction ladder for "Amount,Trade Type,Overall Status"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType           | ofdate                           | ofperspective            | filter             |
         | TC034      | Ringfenced - STANDARD | 30/10/2018 Ringfenced - STANDARD | FND5:HKD:FND5HKDC1:SWEEP | Account:=FND5HKDC1 |
         | TC032      | Ringfenced - STANDARD | 29/10/2018 Ringfenced - STANDARD | FND5:HKD:FND5HKDC1:SWEEP | Account:=FND5HKDC1 |

   Scenario: Verify transaction history balances
      And I apply ladder filter "Account:=FND5HKDC1"
      And I open transaction details of "29/10/2018 Ringfenced - STANDARD" and "FND5:HKD:FND5HKDC1:SWEEP"
      And I check showAllTransactions
      And I open transaction history details for transaction with "Transaction Reference" "${transactionReferenceNumber}-RF-1"
      And I extract transaction history csv for "TC033"

   Scenario Outline: STRAT754- Cancelling a partially replaced ringfenced replacement should not change the sweep status
      Given testcaseName is "STRAT754_2"
      And I navigate to home page
      And I go to the sweeps page
      And I apply sweep filter "From Account Code:FND5HKDC1;To Account Code:FND5HKDP1;From Amount:628694750.2"
      And I verify sweeps csv for "${testcaseName}"

   Scenario: sweep is replaced by a transaction and AMD is received for that transaction with same trans_ref_no as the sweep replacement and different related ref no then the replacement is superseded
      And I get transaction reference number for account "FND5AUDP1" having value date "01-NOV-18" amount "-27309" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5AUDP1:2018-11-01:2018-11-01:-19368.085:DPS:ACT:NEW:STRAT_6325:${transactionReferenceNumber}:1:AUD:FND5:Cash"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5AUDP1:2018-11-01:2018-11-01:-1000.085:DPS:ACT:NEW:STRAT_6325:STRAT_6325Diff:2:AUD:FND5:Cash"
      And I navigate to home page
      And I go to the ladder page

   Scenario Outline: sweep is replaced by a transaction and AMD is received for that transaction with same trans_ref_no as the sweep replacement and different related ref no then the replacement is superseded
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending on transaction ladder for "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC036      | Confirmed (Matched) cash events - STANDARD | 01/11/2018 Confirmed (Matched) cash events - STANDARD | FND5:AUD:FND5AUDP1:SWEEP | Account:=FND5AUDP1 |
         | TC037      | Confirmed (Matched) cash events - STANDARD | 01/11/2018 Confirmed (Matched) cash events - STANDARD | FND5:AUD:FND5AUDP1:Cash  | Account:=FND5AUDP1 |

   Scenario:  replacement is received with no related reference tag then the sweep is not replaced and the transaction is balanced as a new cashflow
      And I load cashflow for transaction "${transactionReferenceNumber}" with details "FND5USDM:2018-11-01:2018-11-01:1000:DPS:ACT:AMD:${transactionReferenceNumber}:1:USD:FND5:Cash"

   Scenario: sweep is replaced by a transaction and AMD is received for that transaction with different trans_ref_no and same related reference as the sweep replacement  then the replacement is not superseded
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5USDM:2018-11-01:2018-11-01:2000:DPS:ACT:AMD:STRAT_6326Diff:${transactionReferenceNumber}:1:USD:FND5:Cash"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5USDM:2018-11-01:2018-11-01:3000:DPS:ACT:AMD:STRAT_6326Diff1:${transactionReferenceNumber}:3:USD:FND5:Cash"

   Scenario: sweep is replaced by a transaction and AMD is received for that transaction with same trans_ref_no and no related reference then the replacement is superseded
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5USDM:2018-11-01:2018-11-01:4000:DPS:ACT:CNF:STRAT_6326Diff1:NA:4:USD:FND5:Cash"
      And I navigate to home page
      And I go to the ladder page

   Scenario Outline: sweep is not replaced if no related ref is passed and replacement is not superseded if AMD is received with different trans_ref_no
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective           | filter            |
         | TC038      | Confirmed (Matched) cash events - STANDARD | 01/11/2018 Confirmed (Matched) cash events - STANDARD | FND5:USD:FND5USDM:SWEEP | Account:=FND5USDM |
         | TC039      | Confirmed (Matched) cash events - STANDARD | 01/11/2018 Confirmed (Matched) cash events - STANDARD | FND5:USD:FND5USDM:Cash  | Account:=FND5USDM |

   Scenario: sweep is replaced by a transaction and CAN is received for that transaction with same trans_ref_no as the sweep replacement and different related ref no then the replacement is Cancelled
      And I get transaction reference number for account "FND5GBPC2" having value date "28-OCT-18" amount "-6104.9" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5GBPC2:2018-11-01:2018-11-01:-1000:DPS:ACT:CNF:STRAT_6327:${transactionReferenceNumber}:1:GBP:FND5:Cash"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5GBPC2:2018-11-01:2018-11-01:-1000.085:DPS:ACT:CAN:STRAT_6327:STRAT_6327Diff3:2:GBP:FND5:Cash"
      And I navigate to home page
      And I go to the ladder page

   Scenario Outline: sweep is replaced by a transaction and CAN is received for that transaction with same trans_ref_no as the sweep replacement and different related ref no then the replacement is Cancelled
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC040      | Confirmed (Matched) cash events - STANDARD | 28/10/2018 Confirmed (Matched) cash events - STANDARD | FND5:GBP:FND5GBPC2:SWEEP | Account:=FND5GBPC2 |
         | TC041      | Confirmed (Matched) cash events - STANDARD | 01/11/2018 Confirmed (Matched) cash events - STANDARD | FND5:GBP:FND5GBPC2:Cash  | Account:=FND5GBPC2 |

   Scenario: Verify transaction history balances
      And  I apply ladder filter "Account:=FND5GBPC2"
      And  I open transaction details of "01/11/2018 Confirmed (Matched) cash events - STANDARD" and "FND5:GBP:FND5GBPC2:Cash"
      And I check showAllTransactions
      And I open transaction history details for transaction with "Transaction Reference" "STRAT_6327"
      And I extract transaction history csv for "TC042"

   Scenario:  Replacement is received with null value in related reference tag then the sweep is not replaced and the transaction is balanced as a new cashflow
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5GBPP1:2018-11-01:2018-11-01:1000:DPS:ACT:CNF:${transactionReferenceNumber}::1:GBP:FND5:Cash"

   Scenario: sweep is replaced by a transaction and CAN is received for that transaction with same trans_ref_no as the sweep replacement and no related ref then the replacement is Cancelled
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5GBPP1:2018-11-01:2018-11-01:1000:DPS:ACT:AMD:STRAT_6327Diff4:${transactionReferenceNumber}:1:GBP:FND5:Cash"
      And I load cashflow for transaction with related reference "${transactionReferenceNumber}" with details "FND5GBPP1:2018-11-01:2018-11-01:1000:DPS:ACT:CAN:STRAT_6327Diff5:${transactionReferenceNumber}:2:GBP:FND5:Cash"
      And I load cashflow for transaction "${transactionReferenceNumber}" with details "FND5GBPP1:2018-11-01:2018-11-01:1000:DPS:ACT:CAN:STRAT_6327Diff4:2:GBP:FND5:Cash"
      
#   And I navigate to home page
#    And I go to the ladder page
# Scenario Outline: sweep is replaced by a transaction and CAN is received for that transaction with same trans_ref_no as the sweep replacement and different related ref no then the replacement is Cancelled
#   And I select balanceType "<balanceType>"
#   And I apply ladder filter "<filter>"
#   And I open transaction details of "<ofdate>" and "<ofperspective>"
#   And I check showAllTransactions
#   And I remove ladder filter for "<filter>"
#   And I extract transaction csv for "<testcaseNo>"
#   Examples:
#|testcaseNo|                balanceType               |                        ofdate                       |      ofperspective     |      filter      |
#|   TC043  |Confirmed (Matched) cash events - STANDARD|28/10/2018 Confirmed (Matched) cash events - STANDARD|FND5:GBP:FND5GBPC2:SWEEP|Account:=FND5GBPC2|
#|   TC044  |Confirmed (Matched) cash events - STANDARD|01/11/2018 Confirmed (Matched) cash events - STANDARD| FND5:GBP:FND5GBPC2:Cash|Account:=FND5GBPC2|
# Scenario: Verify transaction history balances
#   And I apply ladder filter "Account:=FND5GBPC2"
#   And I open transaction details of "01/11/2018 Confirmed (Matched) cash events - STANDARD" and "FND5:GBP:FND5GBPC2:Cash"
#   And I check showAllTransactions
# And I sort ascending on transaction ladder for "Amount,Trade Type,Overall Status"
#   And I open transaction history details for transaction with "Transaction Reference" "STRAT_6327Diff4"
#   And I extract transaction history csv for "TC045"
