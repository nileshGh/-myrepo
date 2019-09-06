@ladder  @Smoke @regression
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Date selection specific functions (without js)
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#Alert new specific functions
@Import("BDD\features-meta\alert.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")


Feature: Filter
  Test case for filtering in cash ladder
  As a cash manager
  I want to verify filtering in cash ladder

  Scenario: TC1 Verify navigation to Cash ladder page and verify page with default perspective
    Given moduleName is "filter"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "functional2" user
    And I go to the ladder page
    And verifyLater is "true"
    And I set ladder daterange from "23/09/2017" to "03/10/2017"
    And balanceType is "Opening Statement Balance - STANDARD:Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Forecasted Balance - STANDARD:Confirmed inc Opening - STANDARD:Cashflows with open exceptions - STANDARD:Opening Statement Balance - CUMULATIVE:Projected Balance - CUMULATIVE:Confirmed (Matched) cash events - CUMULATIVE:Forecasted Balance - CUMULATIVE:Confirmed inc Opening - CUMULATIVE:Cashflows with open exceptions - CUMULATIVE"

  Scenario: Verify that ladder shows correct balances for given date range , perspective and balance types after filtering
    Given I am on the ladder page
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "${balanceType}"
    And I apply filter and verify result
      | testcaseNo | setPerspective                 | filter                                                                                              | setDate    |
      | TC001      | Fund/Currency/Account/Category | Fund:=HGF;Currency:!=CAD;Account:*/AC1;23/09/2017 Projected Balance - STANDARD:=-66644279.42        | 23/09/2017 |
      | TC002      | Fund/Currency/Account/Category | Fund:HD/*;Currency:*A*;Account:!AC2!;23/09/2017 Confirmed (Matched) cash events - STANDARD:=-687948 | 23/09/2017 |
      | TC003      | Fund/Currency/Account/Category | 25/09/2017 Projected Balance - STANDARD:<0                                                          | 25/09/2017 |
      | TC004      | Fund/Currency/Account/Category | 25/09/2017 Projected Balance - STANDARD:!=7705916985.72                                             | 25/09/2017 |
      | TC005      | Fund/Currency/Account/Category | 25/09/2017 Projected Balance - STANDARD:<=2785455740.29                                             | 25/09/2017 |
      | TC006      | Fund/Currency/Account/Category | 25/09/2017 Projected Balance - STANDARD:>0                                                          | 25/09/2017 |
      | TC007      | Fund/Currency/Account/Category | 25/09/2017 Projected Balance - STANDARD:>=2785455740.29                                             | 25/09/2017 |
      | TC008      | Fund/Currency/Account/Category | 25/09/2017 Projected Balance - STANDARD:-1000.13<>10000000000                                       | 25/09/2017 |
      | TC009      | Fund/Currency/Account/Category | Account:=HGFHKDAC2;03/10/2017 Confirmed inc Opening - CUMULATIVE:>0                                 | 03/10/2017 |
      | TC0010     | Fund/Currency/Account/Category | Category:=FX;23/09/2017 Projected Balance - CUMULATIVE:<0                                           | 23/09/2017 |
      | TC0011     | Fund/Currency/Account/Category | Category:=Cash;23/09/2017 Projected Balance - STANDARD:>0                                           | 23/09/2017 |
      | TC0012     | Fund/Currency/Account/Category | Category:=Default Category;23/09/2017 Opening Statement Balance - STANDARD:>0                       | 23/09/2017 |
      | TC0013     | Fund/Currency/Account/Category | Category:=Trade;27/09/2017 Confirmed (Matched) cash events - STANDARD:<0                            | 27/09/2017 |
      | TC0014     | Fund/Currency/Account/Category | 03/10/2017 Confirmed (Matched) cash events - CUMULATIVE:<0                                          | 03/10/2017 |
      | TC0015     | Fund/Currency/Account/Category | Currency:*A*;Fund:hdf;23/09/2017 Projected Balance - CUMULATIVE:<0                                  | 23/09/2017 |
      | TC0016     | Fund/Currency/Account/Category | Currency:=AUD;23/09/2017 Projected Balance - CUMULATIVE:<0                                          | 23/09/2017 |
      | TC0017     | Fund/Currency/Account/Category | Fund:=HDF;24/09/2017 Projected Balance - CUMULATIVE:<0                                              | 24/09/2017 |
      | TC0018     | Fund/Currency/Account/Category | Fund:=HGF;25/09/2017 Projected Balance - STANDARD:>0                                                | 25/09/2017 |
      | TC0019     | Fund/Currency/Account/Category | Fund:HP/*;23/09/2017 Opening Statement Balance - STANDARD:<0                                        | 28/09/2017 |
      | TC0020     | Fund/Currency/Account/Category | Fund:=HGF;Account:*/AC1;28/09/2017 Projected Balance - STANDARD:=199707                             | 28/09/2017 |
      | TC0021     | Fund/Currency/Account          | Fund:=HGF;28/09/2017 Confirmed inc Opening - CUMULATIVE:=1669493490                                 | 28/09/2017 |
      | TC0022     | Fund/Currency/Account          | Account:*/AC1                                                                                       | 23/09/2017 |
      | TC0023     | Fund/Currency/Account          | Account:*AUD*                                                                                       | 23/09/2017 |
      | TC0024     | Fund/Currency/Account          | Fund:!HDF!                                                                                          | 23/09/2017 |
      | TC0025     | Fund/Currency/Account          | Account:HDF/*                                                                                       | 23/09/2017 |

  Scenario: Verify that transaction ladder shows correct balances for selected balance after filtering
    Given I am on the ladder page
    And I apply ladder filter "Fund:=HDF;Account:=HDFAUDAC1"
    And I open transaction details of "23/09/2017 Projected Balance - STANDARD" and "HDF:AUD:HDFAUDAC1"
    And I apply filter on transaction and verify result
      | testcaseNo | filter                                                                |
      | TC0026     | Account:=HDFAUDAC1;Category:=Cash;Depository Name:=BANKAUD;Amount:<=0 |
      | TC0027     | Account:=HDFAUDAC1;Category:=Cash;Transaction Reference:=BULK00000649 |
    And I remove ladder filter for "Fund:=HDF;Account:=HDFAUDAC1"

  Scenario: Verify transaction ladder filters
    Given I am on the ladder page
    And I apply ladder filter "Fund:=HDF;Account:=HDFCHFAC2"
    And I open transaction details of "23/09/2017 Projected Balance - STANDARD" and "HDF:CHF:HDFCHFAC2"
    And I apply filter on transaction and verify result
      | testcaseNo | filter                                                                                          |
      | TC0028     | Account:=HDFCHFAC2;Category:=Trade;Depository Name:=BANKCHF;Amount:<=0                          |
      | TC0029     | Account:=HDFCHFAC2;Category:=Trade;Depository Name:=BANKCHF;Amount:>=0                          |
      | TC0030     | Account:=HDFCHFAC2;Category:=Trade;Depository Name:=BANKCHF;Transaction Reference:=BULK00000762 |
      | TC0031     | Account:=HDFCHFAC2;Category:=Trade;Depository Name:=BANKCHF;Transaction Reference:=BULK00000924 |
    And I remove ladder filter for "Fund:=HDF;Account:=HDFAUDAC1"
