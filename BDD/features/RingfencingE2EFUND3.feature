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

Feature: RingfencingE2EViaUI
  Test case for cash ladder
  As a cash manager
  for Ringfencing feature

  Scenario:Pre-req
    Given moduleName is "ringfencingE2EFUND3"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"

  Scenario:Edit account group
    Then I login as "fund3user" user
    And I go to the account group page
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email                            | Group   | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address       | Description  | Bank Legal Entity | FX Rate Type | accounts                                                                                                                                                                                                         |
      | TC001      | Fund               | FND3               | QaAutomation@smartstream-stp.com | FND3GRP | ''       | ''         | Full              | ''        | FUND3              | Fund3 Address | description1 | ''                | ''           | FND3AEDC1;FND3AEDC2;FND3AEDP1;FND3AUDC1;FND3AUDC2;FND3AUDP1;FND3CADC1;FND3CADP1;FND3GBPC1;FND3GBPC2;FND3GBPC3;FND3GBPP1;FND3HKDC1;FND3HKDC2;FND3HKDP1;FND3HKDP2;FND3JPYC1;FND3JPYP1;FND3USDC1;FND3USDC2;FND3USDM |

  Scenario:Add strategy in account group
    And I navigate to account group page
    And I open group "FUND3" to edit
    And I add new strategy
      | StrategyName      | ExecutionDays | ActionName     | ActionType      | ExecutionWindow | Suggestions |
      | STRATEGY FOR FND3 | ''            | DEFAULT ACTION | Overdraft Check | 5 Days          | ''          |
    And I navigate to account group page
    And I open group "FUND3" to edit
    And I create "SI EXECUTION FOR ACCOUNTS WITH HOLODAY" action of type "Sweep" having execution window "5 Days" for "STRATEGY FOR FND3" strategy
      | Suggestion          | SuggestionValue |
      | Primary Currency    | USD             |
      | AED Primary Account | FND3AEDP1       |
      | AUD Primary Account | FND3AUDP1       |
      | CAD Primary Account | FND3CADP1       |
      | GBP Primary Account | FND3GBPP1       |
      | HKD Primary Account | FND3HKDP1       |
      | JPY Primary Account | FND3JPYP1       |
      | USD Primary Account | FND3USDM        |
    And I "include" all "PROPOSED" sweep pairs for "SI EXECUTION FOR ACCOUNTS WITH HOLODAY" action of "STRATEGY FOR FND3" strategy
    And I exclude sweep pair for "SI EXECUTION FOR ACCOUNTS WITH HOLODAY" action of "STRATEGY FOR FND3" strategy
      | parentAccount | childAccount |
      | FND3HKDP1     | FND3HKDP2    |
      | FND3AEDP1     | FND3AEDC2    |
      | FND3USDM      | FND3AUDP1    |


  Scenario: Execute strategy
    And I load strategy
      | fileName       |
      | Strategy_FUND3 |

  Scenario Outline:STRAT-45 Get Balancing Details
    And I login as "<userName>" user
    And I go to the ladder page
    And I set ladder daterange from "28/10/2018" to "05/11/2018"
    And I select perspective "<perspective>"
    And I select balanceType "<balanceType>"
    And I sort <sortWith> "<sortOn>"
    And I verify balances csv for "<testcaseNo>"
    Examples:
      | testcaseNo | userName  | perspective           | balanceType                                                                                                                              | sortWith  | sortOn                |
      | TC002      | fund3user | Fund/Currency/Account | Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD | ascending | Fund,Currency,Account |


  Scenario: Validate alert dashboard after strategy execution
    Given testcaseName is "TC005"
    And I update CBD for "FUND3REGION" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I verify alerts csv for "${testcaseName}_AlertDashboard"
    And I collapse all rows on alert
    And emailHeadingFND3 is "FUND3"
    And emailAndPreviewFND3 is " Please note that we have identified a potential funding shortfalls on FUND3 per the following details:Account Code: FND3CADC1Account Full Name: Fund3CADC1Amount: CAD -85,888.00Value Date: 28-Oct-2018Opening Statement Balance13,000.00Cash-98,888.00Account Code: FND3JPYP1Account Full Name: Fund3JPYP1Amount: JPY -91,109.90000Value Date: 28-Oct-2018Opening Statement Balance0.00000Cash-91,109.90000Account Code: FND3USDMAccount Full Name: Fund3USDMAmount: USD -264,965,216,984.710Value Date: 28-Oct-2018Opening Statement Balance0.000FX100.000Sweep-264,965,217,084.710Account Code: FND3CADC1Account Full Name: Fund3CADC1Amount: CAD -84,888.00Value Date: 29-Oct-2018Opening Balance-85,888.00Trade1,000.00Account Code: FND3JPYP1Account Full Name: Fund3JPYP1Amount: JPY -91,109.90000Value Date: 29-Oct-2018Opening Balance-91,109.90000Account Code: FND3CADC1Account Full Name: Fund3CADC1Amount: CAD -83,888.00Value Date: 30-Oct-2018Opening Balance-84,888.00Trade1,000.00Account Code: FND3CADP1Account Full Name: Fund3CADP1Amount: CAD -22,395,937,088.10Value Date: 30-Oct-2018Opening Balance13,111.90Cash-7,098,987,800.00Corporate Action-5,098,987,800.00Trade-9,098,986,800.00Account Code: FND3JPYP1Account Full Name: Fund3JPYP1Amount: JPY -91,109.90000Value Date: 30-Oct-2018Opening Balance-91,109.90000Account Code: FND3USDMAccount Full Name: Fund3USDMAmount: USD -2,853,352,694,841.451Value Date: 30-Oct-2018Opening Balance-264,965,214,979.930Corporate Action1,005.780FX1,000.000Sweep-2,588,387,481,867.301Account Code: FND3AUDP1Account Full Name: Fund3AUDP1Amount: AUD -92,068,194,857Value Date: 31-Oct-2018Opening Balance54,343Cash-90,987,800Corporate Action-987,787,800Sweep-899,000Trade-90,987,786,800Account Code: FND3CADP1Account Full Name: Fund3CADP1Amount: CAD -22,395,936,088.10Value Date: 31-Oct-2018Opening Balance-22,395,937,088.10Trade1,000.00Account Code: FND3JPYP1Account Full Name: Fund3JPYP1Amount: JPY -91,109.90000Value Date: 31-Oct-2018Opening Balance-91,109.90000Account Code: FND3CADC1Account Full Name: Fund3CADC1Amount: CAD -81,888.00Value Date: 01-Nov-2018Opening Balance-82,888.00Trade1,000.00Account Code: FND3CADP1Account Full Name: Fund3CADP1Amount: CAD -22,395,935,088.10Value Date: 01-Nov-2018Opening Balance-22,395,936,088.10Trade1,000.00Account Code: FND3JPYP1Account Full Name: Fund3JPYP1Amount: JPY -91,109.90000Value Date: 01-Nov-2018Opening Balance-91,109.90000Account Code: FND3AUDP1Account Full Name: Fund3AUDP1Amount: AUD -92,068,188,857Value Date: 02-Nov-2018Opening Balance-92,068,193,857Sweep4,000Trade1,000Account Code: FND3CADP1Account Full Name: Fund3CADP1Amount: CAD -22,395,935,088.10Value Date: 02-Nov-2018Opening Balance-22,395,935,088.10Account Code: FND3CADC1Account Full Name: Fund3CADC1Amount: CAD -81,888.00Value Date: 03-Nov-2018Opening Balance-81,888.00Trade0.00IMPORTANT NOTE: The potential funding shortfall herein is provided to you by The Hongkong and Shanghai Banking Corporation Limited (\"HSBC\") on your relevant cash accounts opened in accordance with your custody terms with HSBC. This is provided for information purposes only and based on transactions which we are aware of and anticipate posting to your relevant cash account today and/or future calendar days applicable, i.e. our forecast at the time of this email, however HSBC has no obligation to send this email and reserves the right to not send any similar notifications in the future. HSBC does not make any guarantee, representations or warranties to the accuracy or completeness of the information in this email, and shall have no liability to you or any other person arising from the provision of this email."
    And I verify closing alert and sent mail
      | fundName | status | accountCode | selection |
      | FND3     | OPEN   | FND3CADC1   |           |

  Scenario: Validate sweep dashboard after strategy execution
    Given testcaseName is "TC006"
    And I update CBD for "FUND3REGION" region to "28-OCT-18"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND3"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testcaseName}"
