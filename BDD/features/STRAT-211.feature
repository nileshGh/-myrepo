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

Feature: Account participation in Sweep execution
  Test case for cash ladder

  Scenario:Pre-req
    Given moduleName is "strat211"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"


  Scenario:I verify fund details
    Given I login as "fund10user" user
    And I navigate to home page
    And I go to the account group page
    And I navigate to page of account group "FUND10"
    And I verify account group have "Fund" "FND10" "QaAutomation@smartstream-stp.com" "FND10GRP" "''" "''" "Full" "FUND10" "Fund10 Address" "''" "''" "''" "FND10USDM;FND10USDC1;FND10USDC2;FND10HKDP1;FND10HKDC1;FND10HKDP2;FND10HKDC2;FND10GBPP1;FND10GBPC1;FND10GBPC2;FND10GBPC3;FND10AEDP1;FND10AEDC1;FND10AEDC2;FND10JPYP1;FND10JPYC1;FND10CADP1;FND10CADC1;FND10AUDP1;FND10AUDC1;FND10AUDC2"
    And I verify Execution Days for "Default strategy for 'FND10'" strategy is "4 Days"
    And I verify Type is having value "Overdraft Check" for "Default Action" action of "Default strategy for 'FND10'" strategy
    And I verify Execution Window is having value "4 Days" for "Default Action" action of "Default strategy for 'FND10'" strategy

  Scenario: TEST 39-44 Create sweep configuration
    Given I login as "fund10user" user
    And I navigate to home page
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description   | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND10      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | 'Fund10 Test' | ''                | ''           | ''          | ''            |
    And I navigate to account group page
    And I open group "FUND10" to edit
    And I create "MYACT" action of type "Sweep" having execution window "3 Days" for "Default strategy for 'FND10'" strategy
      | Suggestion          | SuggestionValue |
      | Primary Currency    | USD             |
      | AED Primary Account | FND10AEDP1      |
      | AUD Primary Account | FND10AUDP1      |
      | CAD Primary Account | FND10CADP1      |
      | GBP Primary Account | FND10GBPP1      |
      | HKD Primary Account | FND10HKDP1      |
      | JPY Primary Account | FND10JPYP1      |
      | USD Primary Account | FND10USDM       |
    And I "include" all "PROPOSED" sweep pairs for "MYACT" action of "Default strategy for 'FND10'" strategy
  Scenario: Verify sweep pair
    And I navigate to home page
    And I go to the account group page
    And I navigate to page of account group "FUND10"
    And I verify sweep pair dashboard csv extract for "MYACT" action of "Default strategy for 'FND10'" strategy as "TC001"

  Scenario: Exclude sweep pair
    And I navigate to home page
    And I go to the account group page
    And I open group "FUND10" to edit
    And I exclude sweep pair for "MYACT" action of "Default strategy for 'FND10'" strategy
      | parentAccount | childAccount |
      | FND10AEDP1    | FND10AEDC2   |
      | FND10USDM     | FND10AUDP1   |
      | FND10HKDP1    | FND10HKDC2   |


  Scenario:load account, fund
    And I load account
      | fileName     |
      | FND10EURC1   |
      | FND10EURP1   |
      | FND10JPYC2   |
      | FND10SGDC1   |
      | FND10SGDUIC1 |
      | FND10EURUIC1 |
      | FND10EURUIP1 |
      | FND10JPYUIC2 |

    And I update region "FUND10REGION" of account group "FND10"
    And I load fund
      | fileName              |
      | Fund10UpdatedAccounts |

  Scenario:Edit Fund
    Given I login as "fund10user" user
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description   | Bank Legal Entity | FX Rate Type | addAccounts                                                    | removeAccount |
      | FUND10      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | 'Fund10 Test' | ''                | ''           | FND10EURUIC1;FND10EURUIP1;FND10JPYUIC2;FND10SGDUIC1;FND10SGDC1 | ''            |
    And I verify status of group "Name:FUND10" is "PENDING_APPROVAL"

  Scenario:Approve fund
    And I login as "functional" user
    And I go to the account group page
    Then I approve account group "FUND10"

  Scenario:Load cashfows
    And I load messages from "CashFlowsFund10"

  Scenario:Verify Fund
    Given I login as "fund10user" user
    And I go to the account group page
    And I navigate to page of account group "FUND10"
    And I verify sweep pair dashboard csv extract for "MYACT" action of "Default strategy for 'FND10'" strategy as "TC002"

  Scenario: Execute strategy
    And I load strategy
      | fileName        |
      | Strategy_FUND10 |

  Scenario: Validate sweep dashboard after strategy execution
    Given testcaseName is "TC003"
    And I navigate to home page
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND10"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testcaseName}"

  Scenario: Validate alert dashboard after strategy execution
    Given testcaseName is "TC003"
    And I update CBD for "FUND10REGION" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And  I sort ascending "Fund/Account"
    And I verify alerts csv for "${testcaseName}_AlertDashboard"

  Scenario:Include pending sweep pairs
    And I update CBD for "FUND10REGION" region to "19-SEP-18"
    Given I login as "fund10user" user
    And I go to the account group page
    And I open group "FUND10" to edit
    And I wait 3 seconds
    And I edit "MYACT" action of type "Sweep" to execution window "4 Days" for "Default strategy for 'FND10'" strategy
      | Suggestion          | SuggestionValue |
      | EUR Primary Account | FND10EURC1      |
      | SGD Primary Account | FND10SGDC1      |
    And I include sweep pair for "MYACT" action of "Default strategy for 'FND10'" strategy
      | parentAccount | childAccount |
      | FND10SGDC1    | FND10SGDUIC1 |
      | FND10USDM     | FND10SGDC1   |
      | FND10EURC1    | FND10EURP1   |
      | FND10JPYP1    | FND10JPYC2   |
      | FND10EURC1    | FND10EURUIC1 |
      | FND10USDM     | FND10EURC1   |

  Scenario:Approve fund
    And I login as "functional" user
    And I go to the account group page
    Then I approve account group "FUND10"

  Scenario: Execute strategy
    And I load strategy
      | fileName        |
      | Strategy_FUND10 |

  Scenario: Validate sweep dashboard after strategy execution
    Given testcaseName is "TC004"
    Given I login as "fund10user" user
    And I go to the sweeps page
    And I apply sweep filter "Fund Name:FUND10"
    And I sort ascending sweep columns "fromAccountCode,toAccountCode,toAmount,valueDate"
    And I verify sweeps csv for "${testcaseName}"

  Scenario:Exclude and change primay account for ccy
    And I navigate to home page
    And I go to the account group page
    And I open group "FUND10" to edit
    And I exclude sweep pair for "MYACT" action of "Default strategy for 'FND10'" strategy
      | parentAccount | childAccount |
      | FND10USDM     | FND10EURC1   |
    And I edit "MYACT" action of type "Sweep" to execution window "4 Days" for "Default strategy for 'FND10'" strategy
      | Suggestion          | SuggestionValue |
      | EUR Primary Account | FND10EURUIP1    |
    And I validate status of sweep pair for "Default strategy for 'FND10'" action of "MYACT" strategy
      | parentAccount | childAccount | status   |
      | FND10USDM     | FND10EURUIP1 | INCLUDED |

  Scenario:change primay account for ccy with pending account
    And I edit "MYACT" action of type "Sweep" to execution window "4 Days" for "Default strategy for 'FND10'" strategy
      | Suggestion          | SuggestionValue |
      | JPY Primary Account | FND10JPYUIC2    |
    And I validate status of sweep pair for "Default strategy for 'FND10'" action of "MYACT" strategy
      | parentAccount | childAccount | status   |
      | FND10USDM     | FND10JPYUIC2 | INCLUDED |


  Scenario: Navigating to ladder page
    And I navigate to home page
    And I go to the ladder page
    And I select perspective "Fund/Currency/Account"
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD"


  Scenario Outline: Verify that ladder shows correct balances for given date range , perspective and balance types
    Given I am on the ladder page
    And I set ladder daterange from "<startingDate>" to "<endingDate>"
    And I set perspective "<perspective>"
    And I sort <sortWith> "<sortOn>"
    And I set balanceType "<balanceType>"
    And I apply ladder filter "<filter>"
    And I verify balances csv for "<testcaseNo>"

    @Smoke
    Examples:
      | testcaseNo | startingDate | endingDate | perspective                    | balanceType                                                                                                                              | sortWith  | sortOn                         | filter              |
      | TC005      | 19/09/2018   | 21/09/2018 | Fund/Currency/Account/Category | Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD | ascending | Fund,Currency,Account,Category | Account:=FND10JPYC2 |
      | TC006      | 19/09/2018   | 21/09/2018 | Fund/Currency/Account/Category | Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - CUMULATIVE:Ringfenced - STANDARD | ascending | Fund,Currency,Account,Category | Account:=FND10EURC1 |


  Scenario: Validate alert dashboard after strategy execution
    Given testcaseName is "TC007"
    And I update CBD for "FUND10REGION" region to "SYSDATE"
    And I navigate to home page
    And I go to the alert page
    And I expand all rows on alert
    And I sort ascending "Fund/Account"
    And I verify alerts csv for "${testcaseName}_AlertDashboard"

  Scenario:Reverting region
    And I update CBD for "FUND10REGION" region to "19-SEP-18"