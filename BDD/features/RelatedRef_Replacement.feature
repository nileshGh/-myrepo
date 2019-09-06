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

Feature: RelatedRef_Replacement
  Test case for RelatedRef_Replacement

  Scenario:Create group
    Given moduleName is "relatedRef_Replacement"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I load account
      | fileName |
      | PROJ-0aa |
      | PROJ-1aa |
      | PROJ-2aa |
      | PROJ-3aa |
      | PROJ-6aa |
      | PROJ-7aa |
      | PROJ-8aa |
      | PROJ-9aa |
    And I login as "fund13user" user
    And I go to the ladder page
    And I select perspective "Fund/Currency/Account/Category"
    And I verify balances csv for "TC001"


  Scenario Outline: Verify transaction ladder for selected balance from ladder
    Given I am on the ladder page
    And I select balanceType "<balanceType>"
    And I open transaction details of "<ofdate>" and "<ofperspective>"
    And I check showAllTransactions
    And I sort ascending "Amount,Trade Type"
    And I extract transaction csv for "<testcaseNo>"

    Examples:
      | testcaseNo | balanceType                                | ofdate                                                | ofperspective           |
      | TC002      | Confirmed (Matched) cash events - STANDARD | 29/10/2018 Confirmed (Matched) cash events - STANDARD | FND13:AED:FND13AEDC1:FX |
      | TC003      | Confirmed (Matched) cash events - STANDARD | 30/10/2018 Confirmed (Matched) cash events - STANDARD | FND13:AED:FND13AEDC1:FX |


  Scenario:Get transaction history
    And I open transaction history details for transaction with "Account" "FND13AEDC1"
    And I extract transaction history csv for "TC004"

  Scenario:Get transaction history
    And I open transaction details of "29/10/2018 Confirmed (Matched) cash events - STANDARD" and "FND13:AED:FND13AEDC1:FX"
    And I open transaction history details for transaction with "Transaction Reference" "ACTRELATEDREF1"
    And I sort ascending on transaction history ladder for "Amount,Trade Type"
    And I extract transaction history csv for "TC005"

  Scenario:Get DB export
    And I get "select trans_ref_no,related_reference,OVERALL_STATUS,CURRENT_CALC_KEY,TXN_SEQUENCE_ID from cms_bdr_transaction where account_id like 'FND13%' ORDER BY RELATED_REFERENCE,TXN_SEQUENCE_ID DESC" query export "TC006"
