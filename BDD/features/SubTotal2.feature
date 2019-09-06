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

Feature: SubTotal2
    Test case for subTotal
    As a cash manager
    I want to verify subTotal

 Scenario:Verify navigate to cash ladder and select balance type and perspective
    Given moduleName is "subTotal2"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "functional2" user
    And I go to the ladder page
    And I verify start date is equal to "September 23, 2017"
    And I set ladder daterange from "23/09/2017" to "25/09/2017"
    And I select balanceType "Opening Statement Balance - STANDARD:Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Forecasted Balance - STANDARD:Confirmed inc Opening - STANDARD:Cashflows with open exceptions - STANDARD:Opening Statement Balance - CUMULATIVE:Projected Balance - CUMULATIVE:Confirmed (Matched) cash events - CUMULATIVE:Forecasted Balance - CUMULATIVE:Confirmed inc Opening - CUMULATIVE:Cashflows with open exceptions - CUMULATIVE"

Scenario:To check whether Currency wise   subtotal is displayed by default on  Fund/Currency/Account perspective
  And I select grouping
  And I select perspective "Fund/Currency/Account"
  And I verify ladder result for "TC001"

Scenario: To check the transaction details of group
  And I start a new browser
  And I login as "functional2" user
  And I go to the ladder page
  And I select perspective "Fund/Currency/Account"
  And I select balanceType "Opening Statement Balance - STANDARD"
  And I select grouping
  And I open transaction details of "23/09/2017 Opening Statement Balance - STANDARD" and "AUD(2)"
  And I verify transaction ladder result for "TC003"
