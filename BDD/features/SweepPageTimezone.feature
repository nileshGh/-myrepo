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

Feature: Sweep Page Timezone
  To test sweeps are displayed for specified date selected

  Scenario:  Pre-req
    Given moduleName is "sweepPageTimezone"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I update CBD for "FUND41REGION" region to "20-May-19"
    And I login as "fund41user" user
    And I go to the account group page

  Scenario: Load CashFlow
    And I load cashflow
      | fileName         | accountNo  | referenceNo             | ammount | calKey | overallStatus | startingDate |
      | FND41_strat191_1 | FND41AEDC1 | FND41AEDC1_201905201954 | -4000   | 12000  | 1003          | 20/05/2019   |
      | FND41_strat191_2 | FND41AEDC2 | FND41AEDC2_201905201954 | 400     | 12000  | 1003          | 21/05/2019   |

  Scenario: STRAT-191- Create structure and run strategy for FUND41
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group    | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description   | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | FUND41      | ''                 | ''                 | ''    | FND41GRP | ''       | ''         | ''                | ''        | ''                 | ''      | description41 | ''                | ''           | ''          | ''            |
    And I navigate to account group page

    And I open group "FUND41" to edit
    And I create "MYACT2" action of type "Sweep" having execution window "3 Days" for "Default strategy for 'FND41'" strategy
      | Suggestion          | SuggestionValue |
      | Primary Currency    | USD             |
      | AED Primary Account | FND41AEDP1      |
      | USD Primary Account | FND41USDM       |
    And I "include" all "PROPOSED" sweep pairs for "MYACT2" action of "Default strategy for 'FND41'" strategy
    And I save changes to account group "FUND41"

  Scenario: Execute strategy
    And I load strategy
      | fileName        |
      | Strategy_FUND41 |

  Scenario: Go on sweeps page
    And I navigate to home page
    And I go to the sweeps page

  Scenario Outline: STRAT-191 To check if the sweeps are displayed for the selected date
    And I execute sql file "<filename>"
    And I change timezone of the system to "<timezone>"
    And I set date "<select_date>" on sweep dashboard
    And I wait 3 seconds
    And I apply sweep filter "Fund Name:FUND41"
    And I verify sweeps csv for "<testcaseNo>"
    And I navigate to home page
    And I go to the sweeps page
    Examples:
      | testcaseNo | filename   | timezone              | select_date |
      | TC001      | STRAT191_1 | GMT Standard Time     | 20/05/2019  |
      | TC002      | STRAT191_2 | India Standard Time   | 21/05/2019  |
      | TC003      | STRAT191_3 | Pacific Standard Time | 19/05/2019  |
      | TC004      | STRAT191_4 | GMT Standard Time     | 01/01/2019  |
      | TC005      | STRAT191_5 | India Standard Time   | 02/01/2019  |
      | TC006      | STRAT191_6 | Pacific Standard Time | 01/01/2019  |


  Scenario:  Revert the timezone to India Standard Time
    And I change timezone of the system to "India Standard Time"


