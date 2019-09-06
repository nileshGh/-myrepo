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
@Import("BDD\features-meta\alertPreview.meta")
#NEW Cash tlmview grid specific functions
@Import("BDD\features-meta\gridLib.meta")
#NEW Cash tlmviewDashboard specific functions
@Import("BDD\features-meta\tlmviewDashboard.meta")
#sweep page specific functions
@Import("BDD\features-meta\sweepPage.meta")

Feature: Prefunding and FX rate using FX Rate Calculation Currency
   Test case for cash ladder
   As a cash manager
   for Ringfencing feature

   Scenario:Pre-req
      Given moduleName is "strat218"
      And I reset my gwen.web.chrome.prefs setting
      And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"

   Scenario: Verify external Calculation key
      And I verify external calculation key is "EUR"

   Scenario: Fx rates not available directly, but the "from CCY -> calculation CCY" and "calculation CCY -> to CCY" fxs are available
      And I delete fx rates
      And I load messages from "LoadFX_Set2"

   Scenario: Execute strategy
      And I load strategy
         | fileName       |
         | Strategy_FUND4 |

   Scenario: Validate balances on ladder after strategy execution with perspective "Fund/Currency/Account/Category"
      Given testcaseName is "TC001"
      And I login as "fund4user" user
      And I go to the ladder page
      And I select perspective "Fund/Currency/Account/Category"
      And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD"
      And I verify balances csv for "${testcaseName}"

   Scenario: Validate sweep dashboard after strategy execution
      Given testcaseName is "TC002"
      And I navigate to home page
      And I go to the sweeps page
      And I apply sweep filter "Fund Name:FUND4"
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "disabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify sweeps csv for "${testcaseName}"

   Scenario: Verify can not cancel aborted sweep
      And I navigate to home page
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status  |
         | FND4JPYP1       | FND4USDM      | 0          | aborted |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "disabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"


   Scenario: Verify can not do multiple cancel sweeps if one is projected sweep and one is aborted sweep
      And I navigate to home page
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status    |
         | FND4GBPC1       | FND4GBPP1     | 5103.9     | projected |
         | FND4JPYP1       | FND4USDM      | 0          | aborted   |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "disabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"


   Scenario: Verify Reject from cancellation for one projected sweep
      And I navigate to home page
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status    |
         | FND4GBPC1       | FND4GBPP1     | 5103.9     | projected |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "enabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"
      And I submit to cancel sweep "1" with reason "Cancelling sweep by automation"
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4GBPC1       | FND4GBPP1     | 5103.9     |
      And I login as "fund6user" user
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status                     |
         | FND4GBPC1       | FND4GBPP1     | 5103.9     | submitted for cancellation |
      And I verify "Reject from cancellation" button on sweep dashboard is "enabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "disabled"
      And I verify "Approve cancellation" button on sweep dashboard is "enabled"
      And I navigate to home page
      And I go to the sweeps page
      And I reject cancellation of "1" sweep with reason "Rejecting FUND4 sweep cancellation by automation"
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4GBPC1       | FND4GBPP1     | 5103.9     |

   Scenario: Verify Reject from cancellation for multiple projected sweeps
      And I login as "fund4user" user
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status    |
         | FND4GBPC1       | FND4GBPP1     | 5103.9     | projected |
         | FND4GBPC2       | FND4GBPP1     | 6104.9     | projected |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "enabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"
      And I submit to cancel sweep "2" with reason "Cancelling sweep by automation"
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4GBPC1       | FND4GBPP1     | 5103.9     |
         | ''        | FND4GBPC2       | FND4GBPP1     | 6104.9     |
      And I login as "fund6user" user
      And I go to the sweeps page
      And I reject cancellation of "2" sweep with reason "Rejecting FUND4 sweep cancellation by automation"
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4GBPC1       | FND4GBPP1     | 5103.9     |
         | ''        | FND4GBPC2       | FND4GBPP1     | 6104.9     |
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status    |
         | FND4GBPC1       | FND4GBPP1     | 5103.9     | projected |
         | FND4GBPC2       | FND4GBPP1     | 6104.9     | projected |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "enabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"

   Scenario: Verify multiple projected sweep cancellation is successfull if all are in projected status
      And I login as "fund4user" user
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status    |
         | FND4GBPC1       | FND4GBPP1     | 5103.9     | projected |
         | FND4GBPC2       | FND4GBPP1     | 6104.9     | projected |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "enabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"
      And I submit to cancel sweep "2" with reason "Cancelling sweep by automation"
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4GBPC1       | FND4GBPP1     | 5103.9     |
         | ''        | FND4GBPC2       | FND4GBPP1     | 6104.9     |
      And I login as "fund6user" user
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status                     |
         | FND4GBPC1       | FND4GBPP1     | 5103.9     | Submitted for Cancellation |
         | FND4GBPC2       | FND4GBPP1     | 6104.9     | Submitted for Cancellation |
      And I verify "Reject from cancellation" button on sweep dashboard is "enabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "disabled"
      And I verify "Approve cancellation" button on sweep dashboard is "enabled"
      And I approve cancel "2" sweep
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4GBPC1       | FND4GBPP1     | 5103.9     |
         | ''        | FND4GBPC2       | FND4GBPP1     | 6104.9     |
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status    |
         | FND4GBPC1       | FND4GBPP1     | 5103.9     | cancelled |
         | FND4GBPC2       | FND4GBPP1     | 6104.9     | cancelled |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "disabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"


   Scenario: Verify can not cancel already cancelled sweep
      And I login as "fund4user" user
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status    |
         | FND4GBPC1       | FND4GBPP1     | 5103.9     | cancelled |
         | FND4GBPC2       | FND4GBPP1     | 6104.9     | cancelled |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "disabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"

   Scenario:  Export after sweep cancellation
      Given testcaseName is "TC004"
      And I navigate to home page
      And I go to the sweeps page
      And I apply sweep filter "Reason For Cancellation:Cancelling sweep by automation"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify sweeps csv for "${testcaseName}"

   Scenario: Verify sweep not gets cancelled on selecting No option on reasoning form
      Given testcaseName is "TC005"
      And I navigate to home page
      And I go to the sweeps page
      And I verify sweep not gets cancelled on selecting No option on reasoning form
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4GBPC3       | FND4GBPP1     | 7105.9     |
      And I apply sweep filter "From Account Code:FND4GBPC3;To Account Code:FND4GBPP1;From Amount:7105.9"
      And I verify sweeps csv for "${testcaseName}"

   Scenario:Strat470 Manage transactions where replacement has the valuedate altered valuedate+1
      And I get transaction reference number for account "FND4HKDP1" having value date "30-OCT-18" amount "989889759994" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReference}" with details "FND4USDM:2018-10-31:2018-10-31:-1262614.8:DPS:ACT:NEW:STRATFND4_6321:${transactionReference}:1:USD:FND4:Trade"

   Scenario: Validate sweep dashboard for partial replace
      Given testcaseName is "TC006"
      And I navigate to home page
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount       | status             |
         | FND4USDM        | FND4HKDP1     | 126261448978.827 | Partially Replaced |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "enabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"
      And I apply sweep filter "Fund Name:FUND4;From Account Code:FND4USDM;Status:Partially Replaced"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify default sweeps csv for "${testcaseName}"

   Scenario: Loading cashflow for fully replace
      And I load cashflow for transaction with related reference "${transactionReference}" with details "FND4HKDP1:2018-10-30:2018-10-30:989889759994:DPS:ACT:NEW:STRATFND4_6329:${transactionReference}:1:HKD:FND4:Trade"

   Scenario: Validate sweep dashboard for fully replace
      Given testcaseName is "TC007"
      And I navigate to home page
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount       | status   |
         | FND4USDM        | FND4HKDP1     | 126261448978.827 | Replaced |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "disabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"
      And I apply sweep filter "Fund Name:FUND4;From Account Code:FND4USDM;Status:Replaced"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify default sweeps csv for "${testcaseName}"

   Scenario: Navigating to ladder page
      And I navigate to home page
      And I go to the ladder page

   Scenario Outline: Verify transaction ladder for selected balance from ladder
      Given I am on the ladder page
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC008      | Confirmed (Matched) cash events - STANDARD | 30/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:HKD:FND4HKDP1:SWEEP | Account:=FND4HKDP1 |
         | TC009      | Confirmed (Matched) cash events - STANDARD | 30/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:HKD:FND4HKDP1:Trade | Account:=FND4HKDP1 |
         | TC010      | Confirmed (Matched) cash events - STANDARD | 30/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:USD:FND4USDM:SWEEP  | Account:=FND4USDM  |
         | TC011      | Confirmed (Matched) cash events - STANDARD | 31/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:USD:FND4USDM:Trade  | Account:=FND4USDM  |

   Scenario:STRAT-535 Behaviour of sweeps when one leg is cancelled (Replacement with same value Date)
      And I get transaction reference number for account "FND4USDM" having value date "28-OCT-18" amount "7917.399" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReference}" with details "FND4AEDP1:2018-10-28:2018-10-28:-29323.7:DPS:ACT:NEW:STRATFND4_6322:${transactionReference}:1:AED:FND4:Cash"

   Scenario: Validate sweep dashboard for partial replace
      Given testcaseName is "TC012"
      And I navigate to home page
      And I go to the sweeps page
      And I apply sweep filter "Fund Name:FUND4;From Account Code:FND4AEDP1;Status:Partially Replaced"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify default sweeps csv for "${testcaseName}"

   Scenario: Verify  projected sweep cancellation is successfull
      And I navigate to home page
      And I go to the sweeps page
      And I submit to cancel sweep "1" with reason "Cancel only one leg"
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4AEDP1       | FND4USDM      | 29323.7    |
      And I login as "fund6user" user
      And I go to the sweeps page
      And I approve cancel "1" sweep
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4AEDP1       | FND4USDM      | 29323.7    |


   Scenario:  Export after sweep cancellation
      Given testcaseName is "TC013"
      And I login as "fund4user" user
      And I go to the sweeps page
      And I apply sweep filter "Reason For Cancellation:Cancel only one leg"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify sweeps csv for "${testcaseName}"

   Scenario: Navigating to ladder page
      And I navigate to home page
      And I go to the ladder page

   Scenario Outline: Verify transaction ladder for selected balance from ladder
      Given I am on the ladder page
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending "Amount,Trade Type"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC014      | Confirmed (Matched) cash events - STANDARD | 28/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:AED:FND4AEDP1:SWEEP | Account:=FND4AEDP1 |
         | TC015      | Confirmed (Matched) cash events - STANDARD | 28/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:AED:FND4AEDP1:Cash  | Account:=FND4AEDP1 |
         | TC016      | Confirmed (Matched) cash events - STANDARD | 28/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:USD:FND4USDM:SWEEP  | Account:=FND4USDM  |

   Scenario:Strat535 If both the legs are replaced even with a different value date cancellation should not be possible
      And I get transaction reference number for account "FND4AEDP1" having value date "31-OCT-18" amount "-9063.12" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReference}" with details "FND4AEDC1:2018-10-30:2018-10-30:9063.12:DPS:ACT:NEW:STRATFND4_6323:${transactionReference}:1:AED:FND4:Cash"
      And I load cashflow for transaction with related reference "${transactionReference}" with details "FND4AEDP1:2018-10-30:2018-10-30:-9063.12:DPS:ACT:NEW:STRATFND4_6324:${transactionReference}:1:AED:FND4:Cash"

   Scenario: Validate sweep dashboard for replaced
      Given testcaseName is "TC017"
      And I navigate to home page
      And I go to the sweeps page
      And I apply sweep filter "Fund Name:FUND4;From Account Code:FND4AEDP1;Status:Replaced"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify default sweeps csv for "${testcaseName}"

   Scenario: Verify can not cancel if sweep is replaced
      And I navigate to home page
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status   |
         | FND4AEDP1       | FND4AEDC1     | 9063.12    | Replaced |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "disabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"

   Scenario:STRAT-535 Behaviour of sweeps when one leg is cancelled (Replacement with different value Date and amount)
      And I get transaction reference number for account "FND4AEDC2" having value date "28-OCT-18" amount "-10108.9" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReference}" with details "FND4AEDC2:2018-10-30:2018-10-30:-101.9:DPS:ACT:NEW:STRATFND4_6325:${transactionReference}:1:AED:FND4:Cash"

   Scenario: Verify  projected sweep cancellation is successfull
      And I navigate to home page
      And I go to the sweeps page
      And I select sweep on sweep page
         | fromAccountCode | toaccountCode | fromamount | status    |
         | FND4AEDC2       | FND4AEDP1     | 10108.9    | Projected |
      And I verify "Reject from cancellation" button on sweep dashboard is "disabled"
      And I verify "Submit for cancellation" button on sweep dashboard is "enabled"
      And I verify "Approve cancellation" button on sweep dashboard is "disabled"
      And I submit to cancel sweep "1" with reason "Cancel one leg for different value Date"
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4AEDC2       | FND4AEDP1     | 10108.9    |
      And I login as "fund6user" user
      And I go to the sweeps page
      And I approve cancel "1" sweep
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4AEDC2       | FND4AEDP1     | 10108.9    |

   Scenario:  Export after sweep cancellation
      Given testcaseName is "TC018"
      And I login as "fund4user" user
      And I go to the sweeps page
      And I apply sweep filter "Reason For Cancellation:Cancel one leg for different value Date"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify sweeps csv for "${testcaseName}"

   Scenario:STRAT-535 Behaviour of sweeps when one leg is cancelled (Replacement with different value Date for ringfenced balance)
      And I get transaction reference number for account "FND4AUDP1" having value date "28-OCT-18" amount "-9099102" and source system id "SWEEP"
      And I load cashflow for transaction with related reference "${transactionReference}" with details "FND4AUDC1:2018-10-30:2018-10-30:9099102:DPS:ACT:NEW:STRATFND4_6326:${transactionReference}:1:AUD:FND4:Cash"

   Scenario: Verify  projected sweep cancellation is successfull
      And I navigate to home page
      And I go to the sweeps page
      And I submit to cancel sweep "1" with reason "Ringfenced partially cancelled"
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4AUDP1       | FND4AUDC1     | 9099102    |
      And I login as "fund6user" user
      And I go to the sweeps page
      And I approve cancel "1" sweep
         | valueDate | fromAccountCode | toaccountCode | fromamount |
         | ''        | FND4AUDP1       | FND4AUDC1     | 9099102    |

   Scenario:  Export after sweep cancellation
      Given testcaseName is "TC019"
      And I login as "fund4user" user
      And I go to the sweeps page
      And I apply sweep filter "Reason For Cancellation:Ringfenced partially cancelled"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify sweeps csv for "${testcaseName}"

   Scenario: Navigating to ladder page
      And I navigate to home page
      And I go to the ladder page

   Scenario Outline: Verify transaction ladder for selected balance from ladder
      Given I am on the ladder page
      And I select balanceType "<balanceType>"
      And I apply ladder filter "<filter>"
      And I open transaction details of "<ofdate>" and "<ofperspective>"
      And I check showAllTransactions
      And I sort ascending on transaction ladder for "Amount,Trade Type,Overall Status"
      And I remove ladder filter for "<filter>"
      And I extract transaction csv for "<testcaseNo>"

      Examples:
         | testcaseNo | balanceType                                | ofdate                                                | ofperspective            | filter             |
         | TC020      | Confirmed (Matched) cash events - STANDARD | 28/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:AUD:FND4AUDC1:SWEEP | Account:=FND4AUDC1 |
         | TC021      | Confirmed (Matched) cash events - STANDARD | 30/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:AUD:FND4AUDC1:Cash  | Account:=FND4AUDC1 |
         | TC022      | Confirmed (Matched) cash events - STANDARD | 28/10/2018 Confirmed (Matched) cash events - STANDARD | FND4:AUD:FND4AUDP1:SWEEP | Account:=FND4AUDP1 |
         | TC023      | Ringfenced - STANDARD                      | 28/10/2018 Ringfenced - STANDARD                      | FND4:AUD:FND4AUDC1:SWEEP | Account:=FND4AUDC1 |
         | TC024      | Ringfenced - STANDARD                      | 29/10/2018 Ringfenced - STANDARD                      | FND4:AUD:FND4AUDC1:SWEEP | Account:=FND4AUDC1 |

   Scenario: Load new fx rates
      And I delete fx rates
      And I load messages from "LoadFX_Set3"

   Scenario: Execute strategy
      And I load strategy
         | fileName       |
         | Strategy_FUND4 |

   Scenario: Fx rates not available directly, but the "from CCY -> calculation CCY" and "calculation CCY -> to CCY" fxs are available
      Given testcaseName is "TC003"
      And I navigate to home page
      And I go to the sweeps page
      And I apply sweep filter "Fund Name:FUND4"
      And I apply sweep filter "Child Account Code:FND4CADP1"
      And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
      And I verify sweeps csv for "${testcaseName}"

   Scenario: Restore fx rates
      And I delete fx rates
      And I execute script "LoadFxRates"
