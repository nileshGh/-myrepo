@transactionladder  @Smoke   @regression
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Date selection specific functions (without js)
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")

Feature: Transaction
  Test case for transaction
  As a cash manager
  I want to verify transaction grid

  Scenario: Verify transaction ladder for selected balance from ladder
    Given moduleName is "transaction"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "functional" user
    And I go to the ladder page
    And I select perspective "Fund/Currency/Account"

  Scenario Outline: Verify transaction ladder for selected balance from ladder
    Given I am on the ladder page
    And I set ladder daterange from "<startingDate>" to "<endingDate>"
    And I set perspective "<perspective>"
    And I select balanceType "<balanceType>"
    And I apply ladder filter "<filter>"
    And I open transaction details of "<ofdate>" and "<ofperspective>"
    And I remove ladder filter for "<filter>"
    And I extract transaction csv for "<testcaseNo>"

    @smoke
    Examples:
      | testcaseNo | startingDate | endingDate | perspective                    | balanceType                                  | ofdate                                                  | ofperspective                      | filter                                        |
      | TC001      | 23/09/2017   | 03/10/2017 | Fund/Currency/Account          | Opening Statement Balance - STANDARD         | 23/09/2017 Opening Statement Balance - STANDARD         | HDF:AUD:HDFAUDAC1                  | Account:=HDFAUDAC1                            |
      | TC002      | 24/09/2017   | 03/10/2017 | Fund/Currency/Account          | Projected Balance - STANDARD                 | 24/09/2017 Projected Balance - STANDARD                 | HGF:CHF:HGFCHFAC2                  | Account:=HGFCHFAC2                            |
      ##NA## --|TC003|25/09/2017|03/10/2017|Fund/Currency/Account|Confirmed (Matched) cash events - STANDARD|27/09/2017 Confirmed (Matched) cash events - STANDARD|HPF:CAD:HPFCADAC1|Account:=HPFCADAC1|
      | TC004      | 26/09/2017   | 03/10/2017 | Fund/Currency/Account          | Forecasted Balance - STANDARD                | 26/09/2017 Forecasted Balance - STANDARD                | HDF:EUR:HDFEURAC2                  | Account:=HDFEURAC2                            |
      | TC005      | 27/09/2017   | 03/10/2017 | Fund/Currency/Account          | Confirmed inc Opening - STANDARD             | 27/09/2017 Confirmed inc Opening - STANDARD             | HGF:JPY:HGFJPYAC1                  | Account:=HGFJPYAC1                            |
      | TC007      | 23/09/2017   | 03/10/2017 | Fund/Currency/Account          | Opening Statement Balance - CUMULATIVE       | 23/09/2017 Opening Statement Balance - CUMULATIVE       | HDF:HKD:HDFHKDAC1                  | Account:=HDFHKDAC1                            |
      | TC008      | 29/09/2017   | 03/10/2017 | Fund/Currency/Account          | Projected Balance - CUMULATIVE               | 29/09/2017 Projected Balance - CUMULATIVE               | HGF:SGD:HGFSGDAC2                  | Account:=HGFSGDAC2                            |
      | TC009      | 30/09/2017   | 03/10/2017 | Fund/Currency/Account          | Confirmed (Matched) cash events - CUMULATIVE | 30/09/2017 Confirmed (Matched) cash events - CUMULATIVE | HPF:USD:HPFUSDAC1                  | Account:=HPFUSDAC1                            |
      | TC010      | 01/10/2017   | 03/10/2017 | Fund/Currency/Account          | Forecasted Balance - CUMULATIVE              | 01/10/2017 Forecasted Balance - CUMULATIVE              | HDF:AUD:HDFAUDAC2                  | Account:=HDFAUDAC2                            |
      | TC011      | 02/10/2017   | 03/10/2017 | Fund/Currency/Account          | Confirmed inc Opening - CUMULATIVE           | 02/10/2017 Confirmed inc Opening - CUMULATIVE           | HGF:CHF:HGFCHFAC1                  | Account:=HGFCHFAC1                            |
      | TC013      | 23/09/2017   | 03/10/2017 | Fund/Currency/Account/Category | Opening Statement Balance - STANDARD         | 23/09/2017 Opening Statement Balance - STANDARD         | HDF:EUR:HDFEURAC1:Default Category | Account:=HDFEURAC1;Category:=Default Category |
      ##NA##--|TC014|03/10/2017|03/10/2017|Fund/Currency/Account/Category|Projected Balance - STANDARD|28/09/2017 Projected Balance - STANDARD|HGF:JPY:HGFJPYAC2:Trade|Account:HGFJPYAC2;Category:Trade|
      ##NA##--|TC015|02/10/2017|03/10/2017|Fund/Currency/Account/Category|Confirmed (Matched) cash events - STANDARD|24/09/2017 Confirmed (Matched) cash events - STANDARD|HPF:GBP:HPFGBPAC1:Cash|Account:=HPFGBPAC1;Category:=Cash|
      | TC019      | 23/09/2017   | 03/10/2017 | Fund/Currency/Account/Category | Opening Statement Balance - CUMULATIVE       | 23/09/2017 Opening Statement Balance - CUMULATIVE       | HDF:AUD:HDFAUDAC1:Default Category | Account:=HDFAUDAC1;Category:=Default Category |
      | TC020      | 28/09/2017   | 03/10/2017 | Fund/Currency/Account/Category | Projected Balance - CUMULATIVE               | 28/09/2017 Projected Balance - CUMULATIVE               | HGF:CHF:HGFCHFAC2:Trade            | Account:=HGFCHFAC2;Category:=Trade            |
      | TC021      | 27/09/2017   | 03/10/2017 | Fund/Currency/Account/Category | Confirmed (Matched) cash events - CUMULATIVE | 27/09/2017 Confirmed (Matched) cash events - CUMULATIVE | HPF:CAD:HPFCADAC1:Cash             | Account:=HPFCADAC1;Category:=Cash             |
      | TC022      | 26/09/2017   | 03/10/2017 | Fund/Currency/Account/Category | Forecasted Balance - CUMULATIVE              | 26/09/2017 Forecasted Balance - CUMULATIVE              | HDF:EUR:HDFEURAC2:FX               | Account:=HDFEURAC2;Category:=FX               |
      | TC023      | 25/09/2017   | 03/10/2017 | Fund/Currency/Account/Category | Confirmed inc Opening - CUMULATIVE           | 25/09/2017 Confirmed inc Opening - CUMULATIVE           | HGF:JPY:HGFJPYAC1:Trade            | Account:=HGFJPYAC1;Category:=Trade            |


  Scenario:To test when sorting is applied on two columns it sorts the data accordingly and updates the priority on transactions grid on Fund/Currency/Account/Category perspective
    And I remove sort on "Transaction Reference"
    And I sort ascending "Trade Type,Amount"
    And I extract transaction csv for "TC027"

  Scenario:Verify transaction history
    And I open transaction history details for transaction with "Transaction Reference" "BULK00002199"
    And I sort ascending on transaction history ladder for "Trade Type,Amount"
    And I set filter on transaction history grid for "Transaction Reference:=BULK00002199"
    And I extract transaction history csv for "TC025"

  Scenario:Remove sort on transaction history
    And I remove sort on transaction history ladder for "Transaction Reference,Amount"
