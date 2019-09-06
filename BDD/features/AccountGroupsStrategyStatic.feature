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


Feature: Account Groups Strategy Static
  Test cases
  As a cash manager
  I want to verify tlmviewDashboard

  Scenario: Pre-req
    Given moduleName is "accountGroupsStrategyStatic"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "sde1" user
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description   | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount                                                     |
      | FUND32      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | description32 | ''                | ''           | ''          | FND32AEDP1;FND32AEDC1;FND32AEDC2;FND32AUDC1;FND32JPYC1;FND32GBPC2 |

  Scenario:AGD1-OPTION TO ADD ONE/MULTIPLE ACTION
    And I navigate to account group page
    And I navigate to page of account group "FUND32"
    And I verify Execution Days for "Default strategy for 'FND32'" strategy is "4 Days"
    And I verify Type is having value "Overdraft Check" for "Default Action" action of "Default strategy for 'FND32'" strategy
    And I verify Execution Window is having value "4 Days" for "Default Action" action of "Default strategy for 'FND32'" strategy

  Scenario:AGD1,19,24,25,26-OPTION Then the user is presented with the option to add an execution window for the selected action Execution Window - Mandatory and Then user is presented with an option to select main currency for the fund from a unique list of currencies based on the accounts associated with the fund and the list if presented is sorted in asc order
    And I navigate to account group page
    And I open group "FUND32" to edit
    And I click on add action for "Default strategy for 'FND32'" strategy
    And I verify for "Type" action type field options are ",Sweep" for "ACTION X: ACTION NAME" action of "Default strategy for 'FND32'" strategy
    And I verify "2" error and "7" warning messages in popup
      | MessageType | Message                                                              | ActionName            | StrategyName                 |
      | error       | Execution window is required.                                        | ACTION X: ACTION NAME | Default strategy for 'FND32' |
      | error       | Please create a suggestion to define the structure for Sweep action. | ACTION X: ACTION NAME | Default strategy for 'FND32' |
    And I remove action "ACTION X: ACTION NAME" for "Default strategy for 'FND32'" strategy
    And I verify fields for "''" action of Type "Sweep" for "Default strategy for 'FND32'" strategy of "FUND32" account group
      | MandatoryFieldName |
      | Type               |
      | Execution Window   |
    And I verify save strategy button for "Default strategy for 'FND32'" strategy is not visible
    And I save changes to account group "FUND32"

  Scenario:Approve the fund before adding account back to fund
    And I login as "functional" user
    And I go to the account group page
    And I approve account group "FUND32"

  Scenario:AGD*-Given strategy associated with the fund has an SI action When SI action is edited 1.Primary currency altered 2.Primary accounts altered 3.Remove any primary accounts that were set and the user click on 'Create Suggestion' and saved Then that details of the strategy associated with the fund are updated and a new version is created for the fund and the grid is refreshed displaying the hierarchy as per the new configuration and the system audits the changes
    And I login as "sde1" user
    And I go to the account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description   | Bank Legal Entity | FX Rate Type | addAccounts                                                       | removeAccount |
      | FUND32      | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | description32 | ''                | ''           | FND32AEDP1;FND32AEDC1;FND32AEDC2;FND32AUDC1;FND32JPYC1;FND32GBPC2 | ''            |
    And I open group "FUND32" to edit
    And I verify fields for "''" action of Type "Sweep" for "Default strategy for 'FND32'" strategy of "FUND32" account group
      | MandatoryFieldName |
      | Type               |
      | Execution Window   |

  Scenario:AGD2-OPTION TO ADD EXECUTION WINDOW
    And I navigate to account group page
    And I open group "FUND32" to edit
    And I create "MYACT" action of type "Sweep" having execution window "4 Days" for "Default strategy for 'FND32'" strategy
      | Suggestion          | SuggestionValue |
      | Primary Currency    | USD             |
      | AED Primary Account | FND32AEDP1      |
      | AUD Primary Account | FND32AUDP1      |
      | CAD Primary Account | FND32CADP1      |
      | GBP Primary Account | FND32GBPP1      |
      | HKD Primary Account | FND32HKDP1      |
      | JPY Primary Account | FND32JPYP1      |
      | USD Primary Account | FND32USDM       |
    And I "include" all "PROPOSED" sweep pairs for "MYACT" action of "Default strategy for 'FND32'" strategy
    And I save changes to account group "FUND32"
    And I verify sweep pair dashboard csv extract for "MYACT" action of "Default strategy for 'FND32'" strategy as "TC001"

  Scenario:AGD3,4,5-Given an account relationship displayed in the grid from SI action is in Included/Pending state When the relationship is selected Then an option to exclude the account is available
    And I navigate to account group page
    And I open group "FUND32" to edit
    And I exclude sweep pair for "MYACT" action of "Default strategy for 'FND32'" strategy
      | parentAccount | childAccount |
      | FND32GBPP1    | FND32GBPC3   |
      | FND32AEDP1    | FND32AEDC1   |
      | FND32USDM     | FND32GBPP1   |

  Scenario:AGD6,7,8-Given an account relationship displayed in the grid from SI action is in Excluded/Pending state When the relationship is selected Then an option to include the account is available
    And I include sweep pair for "MYACT" action of "Default strategy for 'FND32'" strategy
      | parentAccount | childAccount |
      | FND32USDM     | FND32GBPP1   |
    And I save changes to account group "FUND32"
    And I verify sweep pair dashboard csv extract for "MYACT" action of "Default strategy for 'FND32'" strategy as "TC002"

  Scenario:AGD1,2,11,12-Given on an Account Group screen When fund with Overdraft check is edited User should be able change the execution window only and not the Action type
    And I navigate to account group page
    And I open group "FUND32" to edit
    And I check user can not add strategy
    And I check user can not add action for "Default strategy for 'FND32'" strategy
    And I verify user is only able to edit "Execution Window" field for "Overdraft Check" action type on "Default Action" action of "Default strategy for 'FND32'" strategy
    And I verify user is only able to edit "Execution Window" field for "Sweep" action type on "MYACT" action of "Default strategy for 'FND32'" strategy
    And I change Execution Window to "3 Days" for "Default Action" action of "Default strategy for 'FND32'" strategy
    And I change Execution Window to "3 Days" for "MYACT" action of "Default strategy for 'FND32'" strategy
    And I save changes to account group "FUND32"

  Scenario:AGD1,2,11,12-Given on an Account Group screen When fund with Sweep action is edited User should be able change the execution window , the sweep pairing Action type should not be editable
    And I verify Type is having value "Overdraft Check" for "Default Action" action of "Default strategy for 'FND32'" strategy
    And I verify Type is having value "Sweep" for "MYACT" action of "Default strategy for 'FND32'" strategy
    And I verify Execution Window is having value "3 Days" for "Default Action" action of "Default strategy for 'FND32'" strategy
    And I verify Execution Window is having value "3 Days" for "MYACT" action of "Default strategy for 'FND32'" strategy

  Scenario:AGD11,12-Given on an Account Group screen When fund with Sweep action is edited User should be able change the execution window , the sweep pairing Action type should not be editable
    And I navigate to account group page
    And I open group "FUND32" to edit
    And I edit "MYACT" action of type "Sweep" to execution window "3 Days" for "Default strategy for 'FND32'" strategy
      | Suggestion          | SuggestionValue |
      | Primary Currency    | AED             |
      | AED Primary Account | FND32AEDP1      |
      | AUD Primary Account | FND32AUDC1      |
      | CAD Primary Account | FND32CADC1      |
      | GBP Primary Account | FND32GBPC1      |
      | HKD Primary Account | FND32HKDC1      |
      | JPY Primary Account | FND32JPYC1      |
      | USD Primary Account | FND32USDC1      |
    And I save changes to account group "FUND32"
    And I verify sweep pair dashboard csv extract for "MYACT" action of "Default strategy for 'FND32'" strategy as "TC003"

  # ##NA##AS ADD MORE THAN ONE STRATEGY IS NOT ALLOWED
  # # Scenario:AGD2,13,31-OPTION TO ADD EXECUTION WINDOW and Given on an Account Group screen A fund does not exist When that fund is created and accounts for the fund have been selected And Strategy is added Action is selected as Sweep and Primary currency is selected for that fund Then an option to flag the parent accounts is available
  # #   And I navigate to account group page
  # #   And I open group "FUND32" to edit
  # #   And I add new strategy
  # #     |StrategyName|ExecutionDays|ActionName|ActionType             |ExecutionWindow|Suggestions |
  # #     |MYSTRAT     |''           |MYACT     |Overdraft Check        | 3 Days        | ''         |
  # #   And I navigate to account group page
  # #   And I open group "FUND32" to edit
  # #   And I create "MYACT2" action of type "Sweep" having execution window "3 Days" for "MYSTRAT" strategy
  # #      |Suggestion|SuggestionValue|
  # #      |Primary Currency|USD|
  # #      |AED Primary Account|FND32AEDP1|
  # #      |AUD Primary Account|FND32AUDP1|
  # #      |CAD Primary Account|FND32CADP1|
  # #      |GBP Primary Account|FND32GBPP1|
  # #      |HKD Primary Account|FND32HKDP1|
  # #      |JPY Primary Account|FND32JPYP1|
  # #      |USD Primary Account|FND32USDM|
  # #   And I navigate to account group page
  # #   And I open group "FUND32" to edit
  # #   And I check user can not add action for "MYSTRAT" strategy

  Scenario:AGD9,10-Given on an Account Group screen When a fund is edited Clear the Strategy Name Click anywhere on the screen Clear the default name visible for Strategy again click anywhere on the screen another default name visible for Strategy should be visible,Given on an Account Group screen When a fund is edited Clear the Action Name Click anywhere on the screen Clear the default name visible for Action again click anywhere on the screen another default name visible for Action should be visible
    And I navigate to account group page
    And I open group "FUND32" to edit
    And I rename strategy "Default strategy for 'FND32'" to name "''"
    And I hide "UNKNOWN STRATEGY NAME" strategy menu options
    And I rename action "MYACT" to name "''" for "UNKNOWN STRATEGY NAME" strategy
    And I hide "UNKNOWN ACTION NAME" action menu options for "UNKNOWN STRATEGY NAME" strategy

  Scenario:AGD9-Given on an Account Group screen When a fund is created Clear the Strategy Name Click anywhere on the screen Clear the default name visible for Strategy again click anywhere on the screen another default name visible for Strategy should be visible
    And I navigate to account group page
    And I open create account group form
    And I scroll to the bottom of strategiesHeader
    And I click addStrategyButton
    And I rename strategy "STRATEGY NAME" to name "''"
    And I hide "UNKNOWN STRATEGY NAME" strategy menu options

  Scenario:AGD10-Given on an Account Group screen When a fund is created Clear the Action Name Click anywhere on the screen Clear the default name visible for Action again click anywhere on the screen another default name visible for Action should be visible
    And I click on add action for "UNKNOWN STRATEGY NAME" strategy
    And I rename action "ACTION X: ACTION NAME" to name "''" for "UNKNOWN STRATEGY NAME" strategy
    And I hide "UNKNOWN ACTION NAME" action menu options for "UNKNOWN STRATEGY NAME" strategy
    And I verify for "Type" action type field options are ",Overdraft Check,Sweep" for "UNKNOWN ACTION NAME" action of "UNKNOWN STRATEGY NAME" strategy
    And I verify for "Execution Window" action type field options are "0 Days,1 Day,2 Days,3 Days,4 Days,5 Days,6 Days,7 Days,8 Days" for "UNKNOWN ACTION NAME" action of "UNKNOWN STRATEGY NAME" strategy

  Scenario:AGD32-Given a strategy has been added to a fund When the strategy is edited execution window altered Action added/removed and saved Then that details of the strategy associated with the fund are updated and a new version is created for the fund and system audits user and time that has updated the fund
    And I navigate to account group page
    And I navigate to page of account group "FUND32"
    And I verify account group history dashboard csv for "TC004"

  Scenario: STRAT-791 To verify progress bar
    And I navigate to account group page
    And I navigate to page of account group "FUND32"
    And I verify progress bar message for strategy "Default strategy for 'FND32'" with action "MYACT" for account group "FND32"
