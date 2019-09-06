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

Feature: STRAT-127
    Test case
    As a cash manager I am validating
    1.Validate if default action is removed from the default Strategy and fund update is received, the fund should not be updated with the default action
    2.Associated some different strategy(other than the default one) to the above fund and then load Fund update. Validate that the fund is still associated to only the strategy you changed it to and not the default strategy

    Scenario:Pre-req
        Given moduleName is "strat127"
        And I reset my gwen.web.chrome.prefs setting
        And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"

    Scenario:Remove default strategy in account group
        Given I login as "fund6user" user
        And I go to the account group page
        And I navigate to page of account group "FUND50"
        And I verify account group have "Fund" "FND50" "QaAutomation@smartstream-stp.com" "Default Group" "''" "''" "Full" "FUND50" "Fund50 Address" "''" "''" "''" "FND50USDM;FND50USDC1;FND50USDC2;FND50HKDP1;FND50HKDC1;FND50HKDP2;FND50HKDC2;FND50GBPP1;FND50GBPC1;FND50GBPC2;FND50GBPC3;FND50AEDP1;FND50AEDC1;FND50AEDC2;FND50JPYP1;FND50JPYC1;FND50CADP1;FND50CADC1;FND50AUDP1;FND50AUDC1;FND50AUDC2"
        And I verify Execution Days for "Default strategy for 'FND50'" strategy is "4 Days"
        And I verify Type is having value "Overdraft Check" for "Default Action" action of "Default strategy for 'FND50'" strategy
        And I verify Execution Window is having value "4 Days" for "Default Action" action of "Default strategy for 'FND50'" strategy
        And I navigate to home page
        And I go to the account group page
        And I open group "FUND50" to edit
        And I remove action "Default Action" for "Default strategy for 'FND50'" strategy
        And I save changes to account group "FUND50"
        And I verify Execution Days for "Default strategy for 'FND50'" strategy is "0 Days"
        And I verify "Default Action" action of "Default strategy for 'FND50'" strategy is not present

    Scenario: Update fund by autofeed and verify default action not got generated
        And I load fund
            | fileName |
            | Fund50   |
        And I login as "fund6user" user
        And I go to the account group page
        And I navigate to page of account group "FUND50"
        And I verify account group have "Fund" "FND50" "QaAutomation@smartstream-stp.com" "Default Group" "''" "''" "Full" "FUND50" "Fund50 new Address" "''" "''" "''" "FND50USDM;FND50USDC1;FND50USDC2;FND50HKDP1;FND50HKDC1;FND50HKDP2;FND50HKDC2;FND50GBPP1;FND50GBPC1;FND50GBPC2;FND50GBPC3;FND50AEDP1;FND50AEDC1;FND50AEDC2;FND50JPYP1;FND50JPYC1;FND50CADP1;FND50CADC1;FND50AUDP1;FND50AUDC1;FND50AUDC2"
        And I verify "Default Action" action of "Default strategy for 'FND50'" strategy is not present

    Scenario:Associated some different strategy(other than the default one) to the above fund and then load Fund update. Validate that the fund is still associated to only the strategy you changed it to and not the default strategy
        And I navigate to home page
        And I go to the account group page
        And I open group "FUND49" to edit
        And I remove action "Default Action" for "Default strategy for 'FND49'" strategy
        And I create "SI EXEC FOR PREFUNNDINGWITHHOLIDAY" action of type "Sweep" having execution window "5 Days" for "Default strategy for 'FND49'" strategy
            | Suggestion          | SuggestionValue |
            | Primary Currency    | USD             |
            | AED Primary Account | FND49AEDP1      |
            | AUD Primary Account | FND49AUDP1      |
            | CAD Primary Account | FND49CADP1      |
            | GBP Primary Account | FND49GBPP1      |
            | HKD Primary Account | FND49HKDP1      |
            | JPY Primary Account | FND49JPYP1      |
            | USD Primary Account | FND49USDM       |
        And I "include" all "PROPOSED" sweep pairs for "SI EXEC FOR PREFUNNDINGWITHHOLIDAY" action of "Default strategy for 'FND49'" strategy
        And I verify "Default Action" action of "Default strategy for 'FND49'" strategy is not present

    Scenario: Update fund by autofeed and verify default action not got generated
        And I load fund
            | fileName |
            | Fund49   |
        And I login as "fund6user" user
        And I go to the account group page
        And I navigate to page of account group "FUND49"
        And I verify account group have "Fund" "FND49" "QaAutomation@smartstream-stp.com" "Default Group" "''" "''" "Full" "FUND49" "Fund49 new Address" "''" "''" "''" "FND49USDM;FND49USDC1;FND49USDC2;FND49HKDP1;FND49HKDC1;FND49HKDP2;FND49HKDC2;FND49GBPP1;FND49GBPC1;FND49GBPC2;FND49GBPC3;FND49AEDP1;FND49AEDC1;FND49AEDC2;FND49JPYP1;FND49JPYC1;FND49CADP1;FND49CADC1;FND49AUDP1;FND49AUDC1;FND49AUDC2"
        And I verify "Default Action" action of "Default strategy for 'FND49'" strategy is not present

    Scenario:STRAT-443 Verify error message if suggestion are not covered
        And I navigate to home page
        And I go to the account group page
        And I open group "FUND50" to edit
        And I verify error message on trying to save action "SI EXEC FOR PREFUNNDINGWITHHOLIDAY" of type "Sweep" having execution window "5 Days" for "Default strategy for 'FND50'" strategy without suggestions
