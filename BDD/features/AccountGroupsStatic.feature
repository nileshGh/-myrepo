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

Feature: Account Groups Static
  Test case for account group static
  As a cash manager,I want to verify create/edit/delete operations on funds
  @smoke
  Scenario: Verify create fund
    Given moduleName is "accountGroupsStatic"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "sde1" user
    And I go to the account group page
    And I load account
      | fileName      |
      | account1      |
      | account2      |
      | account3      |
      | account4      |
      | account5      |
      | account6      |
      | account7      |
      | account8      |
      | account9      |
      | account10     |
      | account11     |
      | account13     |
      | CODEHGFEURAC2 |
      | CODEHGFEURAC3 |
    ##WA##Temp Revision: TC003 and TC004 STRAT-301 is marked as won't fix 11-01
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email             | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description  | Bank Legal Entity | FX Rate Type | accounts                   |
      | TC001      | Fund               | AUTOCODE910005     | test0005@hss.com  | Default Group | ''       | ''         | ''                | ''        | AUTOFUND305        | addresss0005 | description1 | ''                | ''           | CODEHGFCHFAC2              |
      | TC002      | Fund               | AUtOCodE910006     | test0006@hss.com  | Default Group | ''       | ''         | ''                | ''        | AUTOFUND306        | addresss0006 | description1 | ''                | ''           | CODEHDFCHFAC2              |
      # |TC003     |Fund              |AUTOCODE910007|test0007@hss.com|Default Group|''|''|''               |''|AUTOFUND307|addresss0007|description1|''|''|''|
      # |TC004     |Fund              |AUTOCODE90008 |test0008@hss.com|Default Group|''|''|''               |''|AUTOFUND308|addresss0008|description1|''|''|''|
      | TC005      | Fund               | AUTOCODE900009     | test0009@hss.com  | HDF Group     | ''       | ''         | ''                | ''        | AUTOFUND309        | addresss0009 | description1 | ''                | ''           | AUTOACC1                   |
      | TC006      | Fund               | AUTOCODE900013     | test00010@hss.com | HDF Group     | ''       | ''         | ''                | ''        | AUTOFUND311        | addresss0010 | description1 | ''                | ''           | AUTOACC2;AUTOACC3;AUTOACC4 |

  Scenario: Verify can not use already used account to create new fund
    And I navigate to account group page
    And I am on account group page
    And I verify can not use already used account "AUTOACC1" to create new fund in account group

  Scenario:STRAT-658,TC25,26,27 To test whether first version of thefund is created when fund is created for first time
    And I navigate to account group page
    And I apply account group filter "Name:AUTOFUND309"
    And I navigate to page of account group "AUTOFUND309"
    And I check order of "ACCOUNTS INCLUDED" is "Ascending" for "AUTOFUND309" FUND
    And I verify account group history dashboard csv for "TC007"

  Scenario: TC5 To check whether duplicate Fund code is accepted or not
    And I navigate to account group page
    And I verify can not edit account group "AUTOFUND311" with already existing code "AUTOCODE900009"
    And I verify can not create account group with duplicate code
      | Account Group Type | Account Group Code | Email            | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description  | Bank Legal Entity | FX Rate Type | accounts  |
      | Fund               | AUTOCODE900009     | test0009@hss.com | HDF Group | ''       | ''         | ''                | ''        | AUTOFUND333        | addresss0333 | description1 | ''                | ''           | AUTOACC01 |

  Scenario:TC21,22,23 Verify filter action on fund page
    And I navigate to account group page
    And I enter accounts group filter "Code:=AUTOCODE900013"
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address     | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description | Bank Legal Entity | FX Rate Type | Accounts                     |
      | FUND               | AUTOCODE900013     | test00010@hss.com | HDF Group | ''       | ''         | ''                | ''        | AUTOFUND311        | addresss0010 | ''          | ''                | ''           | AUTOACC2, AUTOACC3, AUTOACC4 |

  Scenario: Edit fund accounts details of existing fund
    And I remove accounts group filter "Code:=AUTOCODE900013"
    And I open group to edit
      | GroupToEdit  | Account Group Type | Account Group Code | Email          | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address     | Description     | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | AUTOFUND311  | ''                 | ''                 | ''             | ''    | ''       | ''         | ''                | ''        | AUTOFUND3012       | ''          | ''              | ''                | ''           | ''          | ''            |
      | AUTOFUND3012 | ''                 | ''                 | ''             | ''    | ''       | ''         | ''                | ''        | ''                 | ''          | ''              | ''                | ''           | ''          | ''            |
      | AUTOFUND3012 | ''                 | ''                 | test11@hss.com | ''    | ''       | ''         | ''                | ''        | ''                 | ''          | ''              | ''                | ''           | ''          | ''            |
      | AUTOFUND3012 | ''                 | ''                 | ''             | ''    | ''       | ''         | ''                | ''        | ''                 | ''          | new description | ''                | ''           | ''          | ''            |
      | AUTOFUND3012 | ''                 | ''                 | ''             | ''    | ''       | ''         | ''                | ''        | ''                 | new address | ''              | ''                | ''           | ''          | ''            |
      | AUTOFUND3012 | ''                 | ''                 | ''             | ''    | ''       | ''         | ''                | ''        | ''                 | ''          | ''              | ''                | ''           | AUTOACC5    | ''            |
      | AUTOFUND3012 | ''                 | ''                 | ''             | ''    | ''       | ''         | ''                | ''        | ''                 | ''          | ''              | ''                | ''           | ''          | AUTOACC5      |
      | AUTOFUND3012 | ''                 | AUTOCODE9234       | ''             | ''    | ''       | ''         | ''                | ''        | ''                 | ''          | ''              | ''                | ''           | ''          | ''            |
      | AUTOFUND3012 | ''                 | AUTOCODE9567       | test13@hss.com | ''    | ''       | ''         | ''                | ''        | AUTOFUND3013       | ''          | ''              | ''                | ''           | ''          | ''            |

  Scenario: TC28 To test whether new  version of the fund is created when fund is edited
    And I navigate to page of account group "AUTOFUND3013"
    And I check order of "ACCOUNTS INCLUDED" is "Ascending" for "AUTOFUND3013" FUND
    And I verify account group history dashboard csv for "TC008"

  Scenario:Known Issue CMS-11235. To test when sorting is applied on two columns it sorts the data accordingly and updates the priority on Actioned Datetime  Fund Version History Page with filter
    And I navigate to account group page
    And I navigate to page of account group "AUTOFUND3013"
    And I sort ascending "Code"
    And I verify account group history dashboard csv for "TC003"

  Scenario:Known Issue CMS-11235. To test when sorting is applied on two columns it sorts the data accordingly and updates the priority on Actioned Datetime  Fund Version History Page with filter
    And I remove sort on "Code"
    And I verify account group history dashboard csv for "TC004"

  Scenario: TC29 To test whether first version of the fund is created when fund doesn’t exist and  feed is received for that fund
    And I navigate to account group page
    And I load fund
      | fileName |
      | F5SC1    |
    And I navigate to page of account group "AUTOFUND52"
    And I check order of "ACCOUNTS INCLUDED" is "Ascending" for "AUTOFUND52" FUND
    And I verify account group history dashboard csv for "TC009"

  Scenario:To test when feed is received for an existing fund and fund is updated then default group information is not updated for that fund
    And I navigate to account group page
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description   | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | AUTOFUND52  | ''                 | ''                 | ''    | HPF Group | ''       | ''         | ''                | ''        | ''                 | ''      | description52 | ''                | ''           | ''          | ''            |

  Scenario:TC30 To test whether new version of fund is created when feed is received for existing fund
    And I navigate to account group page
    And I load fund
      | fileName |
      | F5SC2    |
    And I navigate to page of account group "AUTOFUND52"
    And I verify account group history dashboard csv for "TC010"

  Scenario:Known Issue CMS-11235. Export to csv with filtering and sorting
    And I navigate to account group page
    And I sort descending "Code"
    And I sort ascending "Code"
    And I enter accounts group filter "Name:*AUTO*"
    And I verify account group dashboard csv for "TC001"

  Scenario: verify create fund with duplicate fund name
    And I navigate to account group page
    And I create account group
      | testcaseNo | Account Group Type | Account Group Code | Email          | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address    | Description    | Bank Legal Entity | FX Rate Type | accounts  |
      | TC001      | Fund               | AUTOCODE900014     | test13@hss.com | Default Group | ''       | ''         | ''                | ''        | AUTOFUND3013       | address 13 | description 13 | ''                | ''           | AUTOACC06 |

  Scenario:Known Issue CMS-10017. TC13 When the feed is received for existing manually created  fund then existing fund will be updated as per feed received.When the feed is received for non existing fund then new fund is created with the information in the feed
    And I navigate to account group page
    And I load fund
      | fileName |
      | F1SC1    |
      | F2SC1    |
      | F6SC1    |
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address    | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description | Bank Legal Entity | FX Rate Type | Accounts |
      | FUND               | AUTOCODE910005     | test0005@hss.com | Default Group | ''       | ''         | ''                | ''        | AUTOFUND305        | Address12    | ''          | ''                | ''           | ''       |
      | FUND               | ''                 | ''               | Default Group | ''       | ''         | ''                | ''        | FUND6              | Address6     | ''          | ''                | ''           | ''       |
      | FUND               | AUTOCODE910006     | test0006@hss.com | ''            | ''       | ''         | ''                | ''        | AUTOFUND306        | addresss0006 | ''          | ''                | ''           | ''       |

  Scenario:Known Issue CMS-10017. TC17 To test whether email address mentioned in the existing fund is not getting updated when feed for that same fund is received .
    And I navigate to account group page
    And I load fund
      | fileName |
      | F6SC1    |
      | F6SC1_1  |
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address    | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description | Bank Legal Entity | FX Rate Type | Accounts      |
      | FUND               | AUTOCODE910006     | test0006@hss.com | Default Group | ''       | ''         | ''                | ''        | AUTOFUND306        | addresss0006 | ''          | ''                | ''           | CODEHGFEURAC2 |

  Scenario:STRAT 664 To test whether fund code, fund name and Account gets updated when loaded through feed
    And I navigate to account group page
    And I load fund
      | fileName |
      | F6SC1_2  |
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address    | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address      | Description | Bank Legal Entity | FX Rate Type | Accounts                     |
      | FUND               | AUTOCODE910006     | test0006@hss.com | Default Group | ''       | ''         | ''                | ''        | AUTOFUND306        | addresss0006 | ''          | ''                | ''           | CODEHGFEURAC2, CODEHGFEURAC3 |

  Scenario:To check whether description is added manually in fund received through feeds.
    And I navigate to account group page
    And I load fund
      | fileName |
      | F8SC1    |
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description   | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | AUTOFUND52  | ''                 | ''                 | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | description02 | ''                | ''           | ''          | ''            |

  Scenario: To check whether able to create fund with same fund name when fund code is unique
    And I navigate to account group page
    And I load fund
      | fileName |
      | F9SC1    |
      | F9SC2    |
    And I enter accounts group filter "Code:=AUTOKOTAKCODE6"
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address   | Description | Bank Legal Entity | FX Rate Type | Accounts      |
      | FUND               | AUTOKOTAKCODE6     | ''            | Default Group | ''       | ''         | ''                | ''        | AUTOKOTAKFUND6     | KOTAKADD6 | ''          | ''                | ''           | CODEHDFHKDAC2 |
    And I enter accounts group filter "Code:=AUTOKOTAKCODE7"
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address   | Description | Bank Legal Entity | FX Rate Type | Accounts      |
      | FUND               | AUTOKOTAKCODE7     | ''            | Default Group | ''       | ''         | ''                | ''        | AUTOKOTAKFUND6     | KOTAKADD6 | ''          | ''                | ''           | CODEHGFHKDAC2 |

  Scenario: Validate create fund form
    And I navigate to account group page
    Given I open create account group form
    And I verify "4" error and "0" warning messages in popup
      | MessageType | Message                         | ActionName | StrategyName |
      | error       | Account Group Type is required. | ''         | ''           |
      | error       | Code is required.               | ''         | ''           |
      | error       | Name is required.               | ''         | ''           |
      | error       | Group is required.              | ''         | ''           |
    And I select "Fund" from "Account Group Type" in account group form
    And I verify mandatory field
      | fieldName          |
      | Account Group Type |
      | Account Group Code |
      | Email              |
      | Group              |
      | Account Group Name |
      | Address            |
      | Description        |
    And I verify "7" error and "0" warning messages in popup
      | MessageType | Message                                         | ActionName | StrategyName |
      | error       | Code is required.                               | ''         | ''           |
      | error       | Name is required.                               | ''         | ''           |
      | error       | Email Address is required.                      | ''         | ''           |
      | error       | Address is required.                            | ''         | ''           |
      | error       | Group is required.                              | ''         | ''           |
      | error       | Description is required.                        | ''         | ''           |
      | error       | At least a single account needs to be selected. | ''         | ''           |
    And I verify currency in account group form
  ##NA##And I verify legal entity in account group form
  ##NA##    And I navigate to fund page
  ##NA##      And I verify create fund form
  ##NA##      And I verify length of input fields
  ##NA##           | element         | text    |message|
  ##NA##           | name | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuv    |Name entered is exceeding the character limit|
  ##NA##           | code | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcd    |Code entered is exceeding the character limit|
  ##NA##           | email | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrst@uv.com    |Email Address entered is exceeding the character limit|
  ##NA##           | description | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefg    |Desc entered is exceeding the character limit|
  ##NA##           | address | abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvlmnopqrstuv    |Name entered is exceeding the character limit|

  Scenario: To verify invalid email address
    And I navigate to account group page
    And I open create account group form
    And I select "Fund" from "Account Group Type" in account group form
    And I verify "invalid" message on account group form field
      | field | text                         | message                               |
      | email | #@%^%#$@#$@#.com             | ${invalid fund email address message} |
      | email | abcdefghijklmn               | ${invalid fund email address message} |
      | email | @domain.com                  | ${invalid fund email address message} |
      | email | Joe Smith <email@domain.com> | ${invalid fund email address message} |
      | email | email.domain.com             | ${invalid fund email address message} |
      | email | .email@domain.com            | ${invalid fund email address message} |
      | email | email.@domain.com            | ${invalid fund email address message} |
      | email | email..email@domain.com      | ${invalid fund email address message} |
      | email | email@domain.com (Joe Smith) | ${invalid fund email address message} |
      | email | email@domain                 | ${invalid fund email address message} |
      | email | email@111.222.333.44444      | ${invalid fund email address message} |
      | email | email@domain..com            | ${invalid fund email address message} |
      | email | email@domain@domain.com      | ${invalid fund email address message} |

  Scenario: To verify valid email address
    And I navigate to account group page
    And I open create account group form
    And I select "Fund" from "Account Group Type" in account group form
    And I verify "valid" message on account group form field
      | field | text                            | message |
      | email | email@domain.com                |         |
      | email | feairstname.lastname@domain.com |         |
      | email | email@subdomain.domain.com      |         |
      | email | firstname+lastname@domain.com   |         |
      ##NA##| email           | "email"@domain.com	            ||
      | email | 1234567890@domain.com           |         |
      | email | email@domain-one.com            |         |
      | email | ______@domain-one.com           |         |
      | email | email@domain.name               |         |
      | email | email@domain.co.jp              |         |
      | email | firstname-lastname@domain.com   |         |
      | email | email@[123.123.123.123]         |         |

  Scenario: To verify specific column is present on the accounts group dashboard
    And I navigate to account group page
    And I verify column on account group dashboard
      | column                        |
      | Account Group Type            |
      | Name                          |
      | Code                          |
      | Currency                      |
      | Group                         |
      | Status                        |
      | Pool Type                     |
      | Accounts                      |
      | IDEL Pool Limit               |
      | Legal Entity                  |
      | Email Address                 |
      | Pool Balance Rule             |
      | FX Type                       |
      | Description                   |
      | Address                       |
      | Last Modifier                 |
      | Modified Date Time            |
      | Balance Inclusive             |
      | Liquidity Balance Type        |
      | Future Liquidity Balance Type |

  Scenario: TC37-45 Verify accounts filtering in create fund form
    And I login as "sde1" user
    And I go to the account group page
    And I verify "AUTOACC02;AUTOACC03;AUTOACC04" accounts can be selected in account group form
    And I select accounts "AUTOACC02;AUTOACC03;AUTOACC04" by applying "AUTO" on account filter in account group form
    And I verify select all and remove all accounts in account group form
    And I apply filter "HSSACC#$" on accounts in account group form
    And I remove account filter in account group form
    And I verify select all and remove all accounts in account group form

  Scenario:Feeds-TC18 To check whether fund is getting updated on basis of fund code
    And I login as "sde1" user
    And I go to the account group page
    And I load fund
      | fileName      |
      | FUNDKOTAKCODE |
    And fundName is "KOTAKFUND1"
    And I open group to edit
      | GroupToEdit | Account Group Type | Account Group Code | Email | Group | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description    | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | KOTAKFUND1  | ''                 | KOTAKNEWCODE1      | ''    | ''    | ''       | ''         | ''                | ''        | ''                 | ''      | description 13 | ''                | ''           | ''          | ''            |
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description | Bank Legal Entity | FX Rate Type | Accounts |
      | FUND               | KOTAKNEWCODE1      | ''            | Default Group | ''       | ''         | ''                | ''        | KOTAKFUND1         | ''      | ''          | ''                | ''           | ''       |

  Scenario:Feeds-TC24 To test creation of fund through feed having Fundcode a mix of Caps and small letter
    And I navigate to account group page
    And I load account
      | fileName   |
      | Feeds_Acc1 |
      | Feeds_Acc2 |
      | Feeds_Acc3 |
    And I load fund
      | fileName         |
      | Feeds_FND_case24 |
    And I execute query "update CMS_REF_ACCOUNT_PARAM set Region_name='NEWAMDREG' where name in ('UpperLowerAcc1','UpperLowerAcc2','UpperLowerAcc3')" to update "3" rows
    And fundName is "JIRA HSS1 UPPERLOWERFND"
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name      | Address | Description | Bank Legal Entity | FX Rate Type | Accounts |
      | FUND               | UPPERLOWERFND24    | ''            | Default Group | ''       | ''         | ''                | ''        | JIRA HSS1 UPPERLOWERFND | ''      | ''          | ''                | ''           | ''       |

  Scenario:Feeds-TC25 To test creation of fund through feed having Fundcode all in small letter
    And I navigate to account group page
    And I load fund
      | fileName         |
      | Feeds_FND_case25 |
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name   | Address | Description | Bank Legal Entity | FX Rate Type | Accounts |
      | FUND               | ALLSMALL25         | ''            | Default Group | ''       | ''         | ''                | ''        | JIRA HSS1 ALLSMALL25 | ''      | ''          | ''                | ''           | ''       |

  Scenario:Feeds-TC26 Update the fund created in case 25 by adding another account to it and keeping the Fundcode all in small letter
    And I navigate to account group page
    And I load fund
      | fileName         |
      | Feeds_FND_case26 |
    And I verify account group details on dashboard
      | Account Group Type | Account Group Code | Email Address | Group         | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name   | Address | Description | Bank Legal Entity | FX Rate Type | Accounts |
      | FUND               | ALLSMALL25         | ''            | Default Group | ''       | ''         | ''                | ''        | JIRA HSS1 ALLSMALL25 | ''      | ''          | ''                | ''           | ''       |

  Scenario:Feeds-TC27/28 Update the fund created in case 25 by adding another account to it and keeping the Fundcode all in small letter
    And I load cashflow
      | fileName         | accountNo      | referenceNo         | ammount | calKey | overallStatus | startingDate |
      | Feeds_FND_case27 | UpperLowerAcc3 | UpperLowerCases1    | -200    | 12000  | 1003          | 01/03/2018   |
      | Feeds_FND_case28 | UpperLowerAcc1 | UPPERLOWERFNDcases2 | -100    | 12002  | 1003          | 01/03/2018   |

  Scenario:Feeds-TC27/28 Update the fund created in case 25 by adding another account to it and keeping the Fundcode all in small letter
    And I login as "functional" user
    And I go to the ladder page
    And I select perspective "Fund/Currency/Account/Category"
    And I verify cashflow on ladder
      | startingDate | endDate    | perspective                    | balanceType                        | ofdate                                        | ofperspective                                       | filter                 |
      | 15/06/2018   | 25/06/2018 | Fund/Currency/Account/Category | Confirmed inc Opening - CUMULATIVE | 15/06/2018 Confirmed inc Opening - CUMULATIVE | ALLSMALL25:AED:UpperLowerAcc3:Cash                  | Account:UpperLowerAcc3 |
      | 15/06/2018   | 25/06/2018 | Fund/Currency/Account/Category | Confirmed inc Opening - CUMULATIVE | 15/06/2018 Confirmed inc Opening - CUMULATIVE | UPPERLOWERFND24:AED:UpperLowerAcc1:Default Category | Account:UpperLowerAcc1 |

  Scenario:Feeds TC34-To test whether Cashflows gets loaded successfully after fund name and fund code change through
    And I load cashflow
      | fileName                | accountNo     | referenceNo            | ammount    | calKey | overallStatus | startingDate |
      | ACTUAL_CODEHGFEURAC2    | CODEHGFEURAC2 | CheckFundCaseAC2       | 4252       | 12000  | 1003          | 01/03/2018   |
      | OPEN_CODEHGFEURAC3      | CODEHGFEURAC3 | CheckFundCaseAC3       | 10215      | 12002  | 1003          | 01/03/2018   |
      | PROJECTED_CODEHGFEURAC3 | CODEHGFEURAC3 | CheckfundCODEHGFEURAC3 | 949346.146 | 12001  | 1003          | 01/03/2018   |

  Scenario:Feeds-34 To test whether Cashflows gets loaded successfully after fund name and fund code change through
    And I navigate to home page
    And I go to the ladder page
    And I set ladder daterange from "15/06/2018" to "16/06/2018"
    And I wait for page to load
    And I apply ladder filter "Fund:=AUTOCODE910006"
    And I verify balances csv for "TC011"