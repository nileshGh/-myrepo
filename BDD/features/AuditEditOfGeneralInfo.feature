
@fundAction  @Smoke @regression
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#functions related to export balances and verify with expected balances
@Import("BDD\features-meta\ladder.meta")
#Date selection specific functions (without js)
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#cash flow loading specific functions (without js)
@Import("BDD\features-meta\loadingCashFlows.meta")
#account groups
@Import("BDD\features-meta\accountGroups.meta")
#Timeline
@Import("BDD\features-meta\timeline.meta")

Feature: Audit Edit Of General Info
  Test case for audit edit of general information
  As a cash manager,I want to validate the Audit created for the Edit Operation on funds

  @smoke
  Scenario: Fund created via UI and all fields updated
    Given moduleName is "AuditEditOfGeneralInfo"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    Then I login as "fund14user" user
    And I go to the account group page
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email                            | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address        | Description  | Bank Legal Entity | FX Rate Type | accounts                                                                                                                                                                                                                   |
      | TC001      | Fund               | FND14              | QaAutomation@smartstream-stp.com | Default Group | ''       | ''         | Full              | ''        | FUND14             | Fund14 Address | description1 | ''                | ''           | FND14AEDC1;FND14AEDC2;FND14AEDP1;FND14AUDC1;FND14AUDC2;FND14AUDP1;FND14CADC1;FND14CADP1;FND14GBPC1;FND14GBPC2;FND14GBPC3;FND14GBPP1;FND14HKDC1;FND14HKDC2;FND14HKDP1;FND14HKDP2;FND14JPYC1;FND14JPYP1;FND14USDC1;FND14USDM |
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email                             | Group    | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address          | Description   | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND14      | ''                 | FND14ET            | neha.ravjiani@smartstream-stp.com | FND14GRP | ''       | ''         | ''                | ''        | FUND14ET           | Fund14ET Address | Fund14ET Test | ''                | ''           | FND14USDC2  | FND14USDC1    |
    And  I navigate to page of account group "FUND14ET"
    And I verify account group have "Fund" "FND14ET" "neha.ravjiani@smartstream-stp.com" "FND14GRP" "''" "''" "Full" "FUND14ET" "Fund14ET Address" "Fund14ET Test" "''" "''" "FND14USDM;FND14USDC2;FND14HKDP1;FND14HKDC1;FND14HKDP2;FND14HKDC2;FND14GBPP1;FND14GBPC1;FND14GBPC2;FND14GBPC3;FND14AEDP1;FND14AEDC1;FND14AEDC2;FND14JPYP1;FND14JPYC1;FND14CADP1;FND14CADC1;FND14AUDP1;FND14AUDC1;FND14AUDC2"
    And I view timeline of account group "FUND14ET"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn    | newDetails                        | oldDetails                       | actionCount |
      | Edit     | FND14USR | Code          | FND14ET                           | FND14                            | ''          |
      | Edit     | FND14USR | Email Address | neha.ravjiani@smartstream-stp.com | QaAutomation@smartstream-stp.com | ''          |
      | Edit     | FND14USR | Fund Name     | FUND14ET                          | FUND14                           | ''          |
      | Edit     | FND14USR | Address       | Fund14ET Address                  | Fund14 Address                   | ''          |
      | Edit     | FND14USR | Description   | Fund14ET Test                     | description1                     | 5           |
  #  Currently a bug is raised for this
  #  |Edit |FND14USR|Group| FND14GRP|Default Group |

  @smoke
  Scenario: Fund created via UI and all fields updated for the  second time
    And I navigate to account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email                               | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address            | Description     | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND14ET    | ''                 | FND14ET_1          | neha_1.ravjiani@smartstream-stp.com | Default Group | ''       | ''         | ''                | ''        | FUND14ET_1         | Fund14ET_1 Address | Fund14ET_1 Test | ''                | ''           | ''          | ''            |
    And I view timeline of account group "FUND14ET_1"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn    | newDetails                          | oldDetails                        | actionCount |
      | Edit     | FND14USR | Code          | FND14ET_1                           | FND14ET                           | ''          |
      | Edit     | FND14USR | Email Address | neha_1.ravjiani@smartstream-stp.com | neha.ravjiani@smartstream-stp.com | ''          |
      | Edit     | FND14USR | Fund Name     | FUND14ET_1                          | FUND14ET                          | ''          |
      | Edit     | FND14USR | Address       | Fund14ET_1 Address                  | Fund14ET Address                  | ''          |
      | Edit     | FND14USR | Description   | Fund14ET_1 Test                     | Fund14ET Test                     | 5           |

  @smoke
  Scenario: Fund created via UI and modify one field
    And I navigate to account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email                             | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND14ET_1  | ''                 | ''                 | neha.ravjiani@smartstream-stp.com | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | ''          | ''                | ''           | ''          | ''            |
    And I view timeline of account group "FUND14ET_1"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn    | newDetails                        | oldDetails                          | actionCount |
      | Edit     | FND14USR | Email Address | neha.ravjiani@smartstream-stp.com | neha_1.ravjiani@smartstream-stp.com | 1           |

  @smoke
  Scenario: Fund created and then Edited via UI and then later updated via Feed
    And I login as "fund18user" user
    And I go to the account group page
    #This currently fails STRAT-894
    # And I load fund
    #     | fileName |
    #     | AEO_1    |
    And I approve account group "FUND14ET_1"
    And I load fund
      | fileName |
      | AEO_1    |
    And  I navigate to page of account group "FUND14_FEED"
    And I verify account group have "Fund" "FND14ET_1" "neha.ravjiani@smartstream-stp.com" "Default Group" "''" "''" "Full" "FUND14_FEED" "Fund14_Feed_Address" "FUND14_Feed Description" "''" "''" "FND14USDM;FND14USDC2;FND14HKDP1;FND14HKDC1;FND14HKDP2;FND14HKDC2;FND14GBPP1;FND14GBPC1;FND14GBPC2;FND14GBPC3;FND14AEDP1;FND14AEDC1;FND14AEDC2;FND14JPYP1;FND14JPYC1;FND14CADP1;FND14CADC1;FND14AUDP1;FND14AUDC1;FND14AUDC2;FND14USDC1"
    And I view timeline of account group "FUND14_FEED"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn  | newDetails              | oldDetails         | actionCount |
      | Edit     | CM2      | Fund Name   | FUND14_FEED             | FUND14ET_1         | ''          |
      | Edit     | CM2      | Address     | Fund14_Feed_Address     | Fund14ET_1 Address | ''          |
      | Edit     | CM2      | Description | FUND14_Feed Description | Fund14ET_1 Test    | 3           |

  @smoke
  Scenario: Edit the Fund via UI
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address              | Description              | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND14_FEED | ''                 | FND14APR_1         | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | Fund14ET_APR Address | Fund14ET_APR Description | ''                | ''           | ''          | ''            |
    And I view timeline of account group "FUND14_FEED"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn  | newDetails               | oldDetails              | actionCount |
      | Edit     | FND18USR | Code        | FND14APR_1               | FND14ET_1               | ''          |
      | Edit     | FND18USR | Address     | Fund14ET_APR Address     | Fund14_Feed_Address     | ''          |
      | Edit     | FND18USR | Description | Fund14ET_APR Description | FUND14_Feed Description | 3           |

  @smoke
  Scenario: Without Approving, Edit the Fund via Feed
    And I load fund
      | fileName |
      | AEO_11   |
    And I view timeline of account group "FUND14_FEED_CHANGE"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn  | newDetails               | oldDetails                     | actionCount |
      | Edit     | CM2      | Address     | Fund14ET_APR Address     | Fund14_Feed_Address Change     | ''          |
      | Edit     | CM2      | Description | Fund14ET_APR Description | FUND14_Feed Description Change | 2           |

  @smoke
  Scenario: Validate if the edit action is ordered by date/time descending for all the Edits made above
    And I view timeline of account group "FUND14_FEED_CHANGE"
    And I verify timeline details of account group with sequence
      | sequenceNo | actionIs | actionBy | actionedOn    | newDetails                          | oldDetails                          | actionCount |
      | 1          | Edit     | CM2      | Address       | Fund14ET_APR Address                | Fund14_Feed_Address Change          | ''          |
      | 1          | Edit     | CM2      | Description   | Fund14ET_APR Description            | FUND14_Feed Description Change      | 2           |
      | 2          | Edit     | CM2      | Fund Name     | FUND14_FEED_CHANGE                  | FUND14_FEED                         | ''          |
      | 2          | Edit     | CM2      | Address       | Fund14_Feed_Address Change          | Fund14ET_APR Address                | ''          |
      | 2          | Edit     | CM2      | Description   | FUND14_Feed Description Change      | Fund14ET_APR Description            | 3           |
      | 3          | Edit     | FND18USR | Code          | FND14APR_1                          | FND14ET_1                           | ''          |
      | 3          | Edit     | FND18USR | Address       | Fund14ET_APR Address                | Fund14_Feed_Address                 | ''          |
      | 3          | Edit     | FND18USR | Description   | Fund14ET_APR Description            | FUND14_Feed Description             | 3           |
      | 4          | Edit     | CM2      | Fund Name     | FUND14_FEED                         | FUND14ET_1                          | ''          |
      | 4          | Edit     | CM2      | Address       | Fund14_Feed_Address                 | Fund14ET_1 Address                  | ''          |
      | 4          | Edit     | CM2      | Description   | FUND14_Feed Description             | Fund14ET_1 Test                     | 3           |
      | 5          | Edit     | FND14USR | Email Address | neha.ravjiani@smartstream-stp.com   | neha_1.ravjiani@smartstream-stp.com | 1           |
      | 6          | Edit     | FND14USR | Code          | FND14ET_1                           | FND14ET                             | ''          |
      | 6          | Edit     | FND14USR | Email Address | neha_1.ravjiani@smartstream-stp.com | neha.ravjiani@smartstream-stp.com   | ''          |
      | 6          | Edit     | FND14USR | Fund Name     | FUND14ET_1                          | FUND14ET                            | ''          |
      | 6          | Edit     | FND14USR | Address       | Fund14ET_1 Address                  | Fund14ET Address                    | ''          |
      | 6          | Edit     | FND14USR | Description   | Fund14ET_1 Test                     | Fund14ET Test                       | 5           |
      | 7          | Edit     | FND14USR | Code          | FND14ET                             | FND14                               | ''          |
      | 7          | Edit     | FND14USR | Email Address | neha.ravjiani@smartstream-stp.com   | QaAutomation@smartstream-stp.com    | ''          |
      | 7          | Edit     | FND14USR | Fund Name     | FUND14ET                            | FUND14                              | ''          |
      | 7          | Edit     | FND14USR | Address       | Fund14ET Address                    | Fund14 Address                      | ''          |
      | 7          | Edit     | FND14USR | Description   | Fund14ET Test                       | description1                        | 5           |


  @smoke
  Scenario: Fund created via Feed without the non mandatory fields and then Edited via UI to add the non mandatory fields
    And I login as "fund18user" user
    And I load fund
      | fileName |
      | AEO_2    |
    And I go to the account group page
    And  I navigate to page of account group "FUND18_FEED"
    And I verify account group have "Fund" "FND18" "QaAutomation@smartstream-stp.com" "Default Group" "''" "''" "Full" "FUND18_FEED" "''" "''" "''" "''" "FND18USDM;FND18USDC2;FND18HKDP1;FND18HKDC1;FND18HKDP2;FND18HKDC2;FND18GBPP1;FND18GBPC1;FND18GBPC2;FND18GBPC3;FND18AEDP1;FND18AEDC1;FND18AEDC2;FND18JPYP1;FND18JPYC1;FND18CADP1;FND18CADC1;FND18AUDP1;FND18AUDC1;FND18AUDC2;FND18USDC1"
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address       | Description       | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND18_FEED | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | FND18_Address | FND18_Description | ''                | ''           | ''          | ''            |
    And I view timeline of account group "FUND18_FEED"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn  | newDetails        | oldDetails | actionCount |
      | Edit     | FND18USR | Address     | FND18_Address     |            | ''          |
      | Edit     | FND18USR | Description | FND18_Description |            | 2           |


  @smoke
  Scenario: Fund created via Feed without the non mandatory fields and then Edited via UI to add the non mandatory fields and approve the fund
    And I load fund
      | fileName |
      | AEO_3    |
    And I navigate to account group page
    And  I navigate to page of account group "FUND19_FEED"
    And I verify account group have "Fund" "FND19" "QaAutomation@smartstream-stp.com" "Default Group" "''" "''" "Full" "FUND19_FEED" "''" "''" "''" "''" "FND19USDM;FND19USDC2;FND19HKDP1;FND19HKDC1;FND19HKDP2;FND19HKDC2;FND19GBPP1;FND19GBPC1;FND19GBPC2;FND19GBPC3;FND19AEDP1;FND19AEDC1;FND19AEDC2;FND19JPYP1;FND19JPYC1;FND19CADP1;FND19CADC1;FND19AUDP1;FND19AUDC1;FND19AUDC2;FND19USDC1"
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address       | Description       | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND19_FEED | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | FND19_Address | FND19_Description | ''                | ''           | ''          | ''            |
    And I view timeline of account group "FUND19_FEED"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn  | newDetails        | oldDetails | actionCount |
      | Edit     | FND18USR | Address     | FND19_Address     |            | ''          |
      | Edit     | FND18USR | Description | FND19_Description |            | 2           |
    And I login as "fund19user" user
    And I go to the account group page
    And I approve account group "FUND19_FEED"
    And I view timeline of account group "FUND19_FEED"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn  | newDetails        | oldDetails | actionCount |
      | Edit     | FND18USR | Address     | FND19_Address     | ''         | ''          |
      | Edit     | FND18USR | Description | FND19_Description | ''         | 2           |


  @smoke
  Scenario: Fund created via Feed without the non mandatory fields and then Edited via UI to add the non mandatory fields and then updated via Feed and keeps the non mandatory field blank
    And I load fund
      | fileName |
      | AEO_4    |
    And I navigate to account group page
    And I view timeline of account group "FUND19_FEEDCHANGE"
    And I verify account group have "Fund" "FND19" "QaAutomation@smartstream-stp.com" "Default Group" "''" "''" "Full" "FUND19_FEEDCHANGE" "Fund19_FeedChange Address" "''" "''" "''" "FND19USDM;FND19USDC2;FND19HKDP1;FND19HKDC1;FND19HKDP2;FND19HKDC2;FND19GBPP1;FND19GBPC1;FND19GBPC2;FND19GBPC3;FND19AEDP1;FND19AEDC1;FND19AEDC2;FND19JPYP1;FND19JPYC1;FND19CADP1;FND19CADC1;FND19AUDP1;FND19AUDC1;FND19AUDC2;FND19USDC1"
    And I verify timeline details of account group
      | actionIs | actionBy | actionedOn  | newDetails                | oldDetails        | actionCount |
      | Edit     | CM2      | Address     | Fund19_FeedChange Address | FND19_Address     | 1           |
      | Edit     | CM2      | Description |                           | FND19_Description |             |
      | Edit     | CM2      | Fund Name   | FUND19_FEEDCHANGE         | FUND19_FEED       |             |