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
#cash flow loading specific functions (without js)
@Import("BDD\features-meta\loadingCashFlows.meta")
#functions related to load account
@Import("BDD\features-meta\fund.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
@Import("BDD\features-meta\accountGroups.meta")

Feature: Amend Cancel
  Test case for loading of amend and cancel cashflows

  Scenario: Verify loading of cashflow and export
    Given moduleName is "amendCancel"
    And verifyLater is "true"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "sde1" user
    And I load fund
      | fileName   |
      | fundamdcan |
    And I go to the account group page
    And I open group to edit
      | GroupToEdit   | Account Group Type | Account Group Code | Email | Group     | Currency | IDEL Limit | Pool Balance Type | Pool Type | Account Group Name | Address | Description        | Bank Legal Entity | FX Rate Type | addAccounts | removeAccount |
      | HSBCFUNDNAME1 | ''                 | ''                 | ''    | NEWAMDGRP | ''       | ''         | ''                | ''        | ''                 | ''      | HSBCFUNDNAME1 Test | ''                | ''           | ''          | ''            |

  Scenario:TC-1 When higher sequence CAN is loaded on lower sequence AMD then existing AMD gets cancelled ,reducing amount to zero and current calc key is enriched as 0 and NULL for AMD and CAN respectively
    And I login as "newusr" user
    And I load cashflow
      | fileName | accountNo | referenceNo | ammount      | calKey | overallStatus | startingDate |
      | TRAN-aa  | HSBC4     | Snr-01      | -219383.2921 | 12001  | 1003          | 01/03/2018   |
      | TRAN-ab  | HSBC4     | Snr-02      | -987976.1514 | 12000  | 1003          | 01/03/2018   |
      | TRAN-ac  | HSBC4     | Snr-03      | 9175955.271  | 12000  | 1003          | 01/03/2018   |
      | TRAN-ad  | HSBC4     | Snr-04      | -790550409.3 | 12001  | 1003          | 01/03/2018   |
      | TRAN-ae  | HSBC4     | Snr-04      | -383255741.4 | 12001  | 1003          | 01/03/2018   |
      | TRAN-af  | HSBC4     | Snr-05      | 65558.42695  | 12001  | 1003          | 01/03/2018   |
      | TRAN-ag  | HSBC4     | Snr-05      | -1808339.867 | 12001  | 1003          | 01/03/2018   |
      | TRAN-ah  | HSBC4     | Snr-05      | -592181.3242 | NULL   | 1021          | 01/03/2018   |
      | TRAN-ai  | HSBC4     | Snr-06      | 143610.2392  | 12000  | 1003          | 01/03/2018   |
      | TRAN-aj  | HSBC4     | Snr-06      | 9419016.186  | 12000  | 1003          | 01/03/2018   |
      | TRAN-ak  | HSBC4     | Snr-06      | -5072871478  | NULL   | 1021          | 01/03/2018   |
      | TRAN-al  | HSBC4     | Snr-07      | -23584.77656 | 12000  | 1003          | 01/03/2018   |
      | TRAN-am  | HSBC4     | Snr-07      | 36874179.92  | NULL   | 1021          | 01/03/2018   |
      | TRAN-an  | HSBC4     | Snr-08      | 144681059    | 12001  | 1003          | 01/03/2018   |
      | TRAN-ao  | HSBC4     | Snr-08      | 898417.2249  | 12000  | 1003          | 01/03/2018   |
      | TRAN-ap  | HSBC4     | Snr-09      | 591201244.5  | 12000  | 1003          | 01/03/2018   |
      | TRAN-aq  | HSBC4     | Snr-09      | -2284180495  | NULL   | 1021          | 01/03/2018   |
      | TRAN-ar  | HSBC4     | Snr-10      | 736967.5848  | 12001  | 1003          | 01/03/2018   |
      | TRAN-as  | HSBC4     | Snr-10      | -2468558710  | NULL   | 1021          | 01/03/2018   |
      | TRAN-at  | HSBC4     | Snr-11      | -130587792.6 | 12001  | 1003          | 01/03/2018   |
      | TRAN-au  | HSBC4     | Snr-11      | 5386328.278  | 12000  | 1003          | 01/03/2018   |
      | TRAN-av  | HSBC4     | Snr-11      | 826271537    | NULL   | 1021          | 01/03/2018   |
      | TRAN-aw  | HSBC4     | Snr-12      | -3264.71325  | 12001  | 1003          | 01/03/2018   |
      | TRAN-ax  | HSBC4     | Snr-12      | 872025827.2  | 12001  | 1003          | 01/03/2018   |
      | TRAN-ay  | HSBC4     | Snr-12      | 6226.98913   | 12000  | 1003          | 01/03/2018   |
      | TRAN-az  | HSBC4     | Snr-12      | -5377196.517 | NULL   | 1021          | 01/03/2018   |
      | TRAN-ba  | HSBC4     | Snr-13      | 525375172.4  | 12001  | 1003          | 01/03/2018   |
      | TRAN-bb  | HSBC4     | Snr-13      | -91857.88811 | 12000  | 1003          | 01/03/2018   |
      | TRAN-bc  | HSBC4     | Snr-14      | 6603175909   | 12001  | 1003          | 01/03/2018   |
      | TRAN-bd  | HSBC4     | Snr-14      | -2604244014  | NULL   | 1019          | 01/03/2018   |
      | TRAN-be  | HSBC4     | Snr-15      | 983424490.7  | 12000  | 1003          | 01/03/2018   |
      | TRAN-bf  | HSBC4     | Snr-15      | -6655336.49  | NULL   | 1019          | 01/03/2018   |
      | TRAN-bg  | HSBC4     | Snr-16      | -628694750.2 | 12000  | 1003          | 01/03/2018   |
      | TRAN-bh  | HSBC4     | Snr-16      | 61288.61211  | NULL   | 1019          | 01/03/2018   |
      | TRAN-bi  | HSBC4     | Snr-17      | -670907693.2 | 12000  | 1003          | 01/03/2018   |
      | TRAN-bj  | HSBC4     | Snr-17      | -4792769.436 | 12000  | 1003          | 01/03/2018   |
      | TRAN-bk  | HSBC4     | Snr-18      | 5385542997   | 12000  | 1003          | 01/03/2018   |
      | TRAN-bl  | HSBC4     | Snr-18      | 77741.589    | 12000  | 1003          | 01/03/2018   |
      | TRAN-bm  | HSBC4     | Snr-19      | 77541.589    | 12000  | 1003          | 01/03/2018   |
      | TRAN-bn  | HSBC4     | Snr-19      | 77731.589    | NULL   | 1019          | 01/03/2018   |
      | TRAN-bo  | HSBC4     | Snrr-20     | -2193832921  | 12001  | 1003          | 01/03/2018   |
      | TRAN-bp  | HSBC4     | Snrr-20     | -2193832921  | NULL   | 1019          | 01/03/2018   |
      | TRAN-bq  | HSBC4     | Snrr-21     | -7905504093  | NULL   | 1020          | 01/03/2018   |
      | TRAN-br  | HSBC4     | Snrr-21     | -7905504093  | NULL   | 1019          | 01/03/2018   |
      | TRAN-bs  | HSBC4     | Snrr-21     | -7905504093  | 12001  | 1003          | 01/03/2018   |
      | TRAN-bt  | HSBC4     | Snrr-22     | 6555842695   | 12001  | 1003          | 01/03/2018   |
      | TRAN-bu  | HSBC4     | Snrr-22     | 6555842695   | 12001  | 1003          | 01/03/2018   |
      | TRAN-bv  | HSBC4     | Snrr-22     | 6555842695   | NULL   | 1019          | 01/03/2018   |
      | TRAN-bw  | HSBC4     | Snrr-23     | 1436102392   | 12001  | 1003          | 01/03/2018   |
      | TRAN-bx  | HSBC4     | Snrr-23     | 1436102392   | NULL   | 1019          | 01/03/2018   |
      | TRAN-by  | HSBC4     | Snrr-23     | 1436102392   | 12001  | 1003          | 01/03/2018   |
      | TRAN-bz  | HSBC4     | Snrr-24     | -1023923     | NULL   | 1020          | 01/03/2018   |
      | TRAN-ca  | HSBC4     | Snrr-24     | -1023923     | NULL   | 1019          | 01/03/2018   |
      | TRAN-cb  | HSBC4     | Snrr-25     | 454545       | 12002  | 1003          | 01/03/2018   |
      | TRAN-cc  | HSBC4     | Snrr-25     | 454546       | 12002  | 1003          | 01/03/2018   |
      | TRAN-cd  | HSBC4     | Snrr-26     | 6453425      | 12002  | 1003          | 01/03/2018   |
      | TRAN-ce  | HSBC4     | Snrr-26     | 6453425      | NULL   | 1021          | 01/03/2018   |
      | TRAN-cf  | HSBC4     | Snrr-27     | 783645       | 12002  | 1003          | 01/03/2018   |
      | TRAN-cg  | HSBC4     | Snrr-28     | 837465       | 12002  | 1003          | 01/03/2018   |
      | TRAN-ch  | HSBC4     | Snrr-28     | 837466       | 12002  | 1003          | 01/03/2018   |
      | TRAN-ci  | HSBC4     | Snrr-28     | 837466       | NULL   | 1021          | 01/03/2018   |
      | TRAN-cj  | HSBC5     | Snr-29      | 717181.2921  | 12001  | 1003          | 01/03/2018   |
      | TRAN-ck  | HSBC5     | Snr-30      | 717181.2921  | 12000  | 1003          | 01/03/2018   |
      | TRAN-cl  | HSBC5     | Snr-31      | -33131.009   | 12002  | 1003          | 01/03/2018   |
      | TRAN-cm  | HSBC5     | Snr-32      | 3232.3232    | 12001  | 1003          | 01/03/2018   |
      | TRAN-cn  | HSBC5     | Snr-33      | 3333.3       | 12001  | 1003          | 01/03/2018   |
      | TRAN-co  | HSBC5     | Snr-34      | 3434.3       | 12000  | 1003          | 01/03/2018   |
      | TRAN-cp  | HSBC5     | Snr-34      | -3434.3      | 12000  | 1003          | 01/03/2018   |
      | TRAN-cq  | HSBC5     | Snr-35      | -3535.353535 | 12001  | 1003          | 01/03/2018   |
      | TRAN-cr  | HSBC5     | Snr-35      | -3838.3383   | 12000  | 1003          | 01/03/2018   |
      | TRAN-cs  | HSBC5     | Snr-36      | -3636.3363   | NULL   | 1020          | 01/03/2018   |
      | TRAN-dd  | HSBC5     | Snr-41      | 852852       | NULL   | 1020          | 01/03/2018   |

  Scenario: Verify cash ladder
    And I navigate to home page
    And I refresh the current page
    And I wait for page to load
    And I go to the ladder page
    And I set ladder daterange from "05/03/2018" to "15/03/2018"
    And balanceType is "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Projected Balance - STANDARD:Confirmed inc Opening - CUMULATIVE"
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "${balanceType}"
    And I apply filter and verify result
      | testcaseNo | setPerspective                 | filter         | setDate    |
      | TC101      | Fund/Currency/Account/Category | Account:*HSBC* | 05/03/2018 |

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                          | ofperspective                | filter         |
      | TC102      | 05/03/2018 Opening Statement Balance - STANDARD | HSBCFUNDCODE1:AUD:HSBC4:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I refresh the current page
    And I wait for page to load
    And I open transaction details of "05/03/2018 Opening Statement Balance - STANDARD" and "HSBCFUNDCODE1:AUD:HSBC4:Cash"
    And I verify all transaction from UI transaction grid for testcase "TC103"

  Scenario: Verify transaction history balances
    And I verify transaction history of transactions
      | testcaseNo | TransactionReference |
      | TC104      | Snrr-25              |
      | TC105      | Snrr-26              |
      | TC106      | Snrr-27              |
      | TC107      | Snrr-28              |

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                                | ofperspective                | filter         |
      | TC108      | 05/03/2018 Confirmed (Matched) cash events - STANDARD | HSBCFUNDCODE1:AUD:HSBC4:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC109"

  Scenario: Verify transaction history balances
    And I verify transaction history of transactions
      | testcaseNo | TransactionReference |
      | TC110      | Snr-02               |
      | TC111      | Snr-03               |
      | TC112      | Snr-06               |
      | TC113      | Snr-07               |
      | TC114      | Snr-08               |
      | TC115      | Snr-09               |
      | TC116      | Snr-11               |
      | TC117      | Snr-12               |
      | TC118      | Snr-13               |
      | TC119      | Snr-15               |
      | TC120      | Snr-16               |
      | TC121      | Snr-17               |
      | TC122      | Snr-18               |
      | TC123      | Snr-19               |

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                  | ofperspective                | filter         |
      | TC124      | 05/03/2018 Projected Balance - STANDARD | HSBCFUNDCODE1:AUD:HSBC4:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC125"

  Scenario:Known Issue CMS-10394 for TC132. Verify transaction history balances
    And I verify transaction history of transactions
      | testcaseNo | TransactionReference |
      | TC126      | Snr-01               |
      | TC127      | Snr-04               |
      | TC128      | Snr-05               |
      | TC129      | Snr-10               |
      | TC130      | Snr-14               |
      | TC131      | Snrr-20              |
      | TC132      | Snrr-21              |
      | TC133      | Snrr-22              |
      | TC134      | Snrr-23              |

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                        | ofperspective                | filter         |
      | TC135      | 05/03/2018 Confirmed inc Opening - CUMULATIVE | HSBCFUNDCODE1:AUD:HSBC4:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC136"

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                                | ofperspective                | filter         |
      | TC137      | 05/03/2018 Confirmed (Matched) cash events - STANDARD | HSBCFUNDCODE1:JPY:HSBC5:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC138"

  Scenario: Verify transaction history balances
    And I verify transaction history of transactions
      | testcaseNo | TransactionReference |
      | TC139      | Snr-35               |


  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                        | ofperspective                | filter         |
      | TC140      | 05/03/2018 Confirmed inc Opening - CUMULATIVE | HSBCFUNDCODE1:JPY:HSBC5:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC141"

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                                | ofperspective                | filter         |
      | TC142      | 06/03/2018 Confirmed (Matched) cash events - STANDARD | HSBCFUNDCODE1:JPY:HSBC5:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC143"

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                  | ofperspective                | filter         |
      | TC144      | 06/03/2018 Projected Balance - STANDARD | HSBCFUNDCODE1:JPY:HSBC5:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC145"

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                        | ofperspective                | filter         |
      | TC146      | 06/03/2018 Confirmed inc Opening - CUMULATIVE | HSBCFUNDCODE1:JPY:HSBC5:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC147"

  Scenario: Performs EOD for specific region
    And I perform EOD for "NEWAMDREG" region with CBD "2018-03-05" and last EOD execution "2018-03-04"

  Scenario: Verify cash ladder after EOD
    And I load cashflow
      | fileName | accountNo | referenceNo | ammount     | calKey | overallStatus | startingDate |
      | TRAN-ct  | HSBC5     | Snr-29      | 717182.2921 | 12000  | 1003          | 01/03/2018   |
      | TRAN-cu  | HSBC5     | Snr-30      | 717182.2921 | 12000  | 1003          | 01/03/2018   |
      | TRAN-cv  | HSBC5     | Snr-31      | -33131.229  | 12002  | 1003          | 01/03/2018   |
      | TRAN-cw  | HSBC5     | Snr-32      | 3232.3232   | NULL   | 1021          | 01/03/2018   |
      | TRAN-cx  | HSBC5     | Snr-33      | 3333.3      | 12000  | 1003          | 01/03/2018   |
      | TRAN-cy  | HSBC5     | Snr-33      | 3333.3      | NULL   | 1021          | 01/03/2018   |
      | TRAN-cz  | HSBC5     | Snr-34      | 3434.3      | NULL   | 1021          | 01/03/2018   |
      | TRAN-da  | HSBC5     | Snr-34      | 90909       | 12000  | 1003          | 01/03/2018   |
      | TRAN-db  | HSBC5     | Snr-35      | -3838.3383  | NULL   | 1021          | 01/03/2018   |
      | TRAN-dc  | HSBC5     | Snr-36      | -3636.3363  | NULL   | 1019          | 01/03/2018   |
      | TRAN-de  | HSBC5     | Snr-41      | 852852      | 12001  | 1003          | 01/03/2018   |
      | TRAN-df  | HSBC5     | Snr-43      | 878787.88   | 12001  | 1003          | 01/03/2018   |
      | TRAN-dg  | HSBC5     | Snr-43      | 878787.88   | NULL   | 1021          | 01/03/2018   |
      | TRAN-dh  | HSBC5     | Snr-43      | 878787.88   | NULL   | 1019          | 01/03/2018   |
      | TRAN-di  | HSBC5     | Snr-44      | 1000        | 12001  | 1003          | 01/03/2018   |
      | TRAN-dj  | HSBC5     | Snr-44      | 1001        | 12000  | 1003          | 01/03/2018   |

  Scenario: Verify cash ladder
    And I login as "newusr" user
    And I go to the ladder page
    And I set ladder daterange from "06/03/2018" to "16/03/2018"
    And balanceType is "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Projected Balance - STANDARD:Confirmed inc Opening - CUMULATIVE"
    And I select perspective "Fund/Currency/Account/Category"
    And I select balanceType "${balanceType}"
    And I apply filter and verify result
      | testcaseNo | setPerspective                 | filter         | setDate    |
      | TC148      | Fund/Currency/Account/Category | Account:*HSBC* | 06/03/2018 |

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                          | ofperspective                | filter         |
      | TC149      | 06/03/2018 Opening Statement Balance - STANDARD | HSBCFUNDCODE1:JPY:HSBC5:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC150"

  Scenario: Verify transaction history balances
    And I verify transaction history of transactions
      | testcaseNo | TransactionReference |
      | TC151      | Snr-31               |

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                                | ofperspective                | filter         |
      | TC152      | 06/03/2018 Confirmed (Matched) cash events - STANDARD | HSBCFUNDCODE1:JPY:HSBC5:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC153"

  Scenario: Verify transaction history balances
    And I verify transaction history of transactions
      | testcaseNo | TransactionReference |
      | TC154      | Snr-29               |
      | TC155      | Snr-30               |
      | TC156      | Snr-33               |
      | TC157      | Snr-34               |
      | TC158      | Snr-44               |

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                  | ofperspective                | filter         |
      | TC159      | 06/03/2018 Projected Balance - STANDARD | HSBCFUNDCODE1:JPY:HSBC5:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC160"

  Scenario:Known Issue CMS-10394 for TC162 Verify transaction history balances
    And I verify transaction history of transactions
      | testcaseNo | TransactionReference |
      | TC161      | Snr-32               |
      | TC162      | Snr-41               |
      | TC163      | Snr-43               |

  Scenario: Verify transaction ladder
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                        | ofperspective                | filter         |
      | TC164      | 06/03/2018 Confirmed inc Opening - CUMULATIVE | HSBCFUNDCODE1:JPY:HSBC5:Cash | Account:*HSBC* |

  Scenario: Verify all transaction ladder balances
    And I verify all transaction from transaction grid for testcase "TC165"

  Scenario: Verify cash ladder for date behind cbd
    And I set ladder daterange from "23/02/2018" to "05/03/2018"
    And I select perspective "Fund/Currency/Account/Category"
    And I apply filter and verify result
      | testcaseNo | setPerspective                 | filter         | setDate    |
      | TC166      | Fund/Currency/Account/Category | Account:*HSBC* | 23/02/2018 |
