@ladder @Smoke @regression
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Date selection specific functions (without js)
@Import("BDD\features-meta\dateSelection-appr2.meta")
@Import("BDD\features-meta\dateSelection-appr1.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")


Feature: Ladder User Groups
    Test case for grouping
    As a cash manager
    I want to verify cash ladder


    Scenario:To test when user is associated with the one or multiple group and has default group is not associated with it ,then data associated with all thoes  groups will be displayed in cash ladder
        Given moduleName is "ladderUserGroups"
        And I reset my gwen.web.chrome.prefs setting
        And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
        And I login as "functional" user
        And I go to the ladder page
        And I verify start date is equal to "September 23, 2017"

    Scenario:To test whether removal of Groups/Balance types is not affecting sorting  on balances grid on Fund/Currency/Account perspective
        And I select perspective "Fund/Currency/Account/Category"
        And I deselect group "HPF Group"
        And I remove two balanceType
        And I verify balances csv for "TC001"

    Scenario:To test whether addition of Groups/Balance types is not affecting sorting  on balances grid on Fund/Currency/Account perspective
        And I select group as "HPF Group"
        And I select balanceType as "Forecasted Balance - CUMULATIVE"
        And I wait for page to load
        And I verify balances csv for "TC002"

    Scenario: Verify ladder for hpf user
        And I login as "hpfgroup" user
        And I go to the ladder page
        And I verify selected groups are "HPF Group"
        And I select perspective "Fund/Currency/Account/Category"
        And I verify balances csv for "TC003"

    Scenario: Verify ladder for hdf user
        And I login as "hdfgroup" user
        And I go to the ladder page
        And I verify selected groups are "HDF Group"
        And I select perspective "Fund/Currency/Account/Category"
        And I verify balances csv for "TC004"
