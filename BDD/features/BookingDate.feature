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
#Strategy specific functions
@Import("BDD\features-meta\strategy.meta")
#Roles specific functions
@Import("BDD\features-meta\roles.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\ladder.meta")
#NEW Cash ladder specific functions
@Import("BDD\features-meta\filter.meta")
#NEW Transaction ladder specific functions
@Import("BDD\features-meta\transactionGrid.meta")
#Alert new specific functions
@Import("BDD\features-meta\alert.meta")
#NEW Favorite specific functions
@Import("BDD\features-meta\favorite.meta")
#Group Management specific functions
@Import("BDD\features-meta\groupManagement.meta")

Feature: Booking Date
  Testcase for BookingDate

  Scenario:Add inserts for booking date
    Given moduleName is "bookingDate"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "altBKD" user
    And I update CBD for "Default" region to "20-AUG-18"
    And I login as "altBKD" user
    And I go to the alert page
    And I verify there are no alerts available

  Scenario: 	Load the cashflows in below
    And I load account "CMS11345_CreateAccountForBookingDate"
    And I load fund "CMS11345_CreateFundForBookingDate"
    And I execute sql file "CMS11345_UpdateTheFundGroup"
    And I load cashflow
      | fileName                                      | accountNo         | referenceNo               | ammount | calKey | overallStatus | startingDate |
      | CMS11345_Scenario3_1                          | CHECKBOOKDATE1    | CHECKBOOK11345_SCN3_2     | -100    | 12001  | 1003          | 20/08/2018   |
      | CMS11345_Scenario3_2                          | CHECKBOOKDATE1    | CHECKBOOK11345_SCN3_1     | -10000  | 12000  | 1003          | 20/08/2018   |
      | CMS11345_O_Scenario3                          | CHECKBOOKDATE1    | CHECKBOOK11345_SCNOPN_3   | 5000    | 12002  | 1003          | 20/08/2018   |
      | CMS11346_Scenario1_1                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN1_1     | -10000  | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario1_2                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN1_2     | -10000  | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario2_1                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN2_1     | -10000  | 12001  | 1003          | 20/08/2018   |
      | CMS11346_Scenario2_2                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN2_2     | -10000  | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario3_1                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN3_1     | 5000    | 12001  | 1003          | 21/08/2018   |
      | CMS11346_Scenario3_2                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN3_2     | 5000    | 12000  | 1003          | 21/08/2018   |
      | CMS11346_Scenario4_1                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN4_1     | -2000   | 12001  | 1006          | 20/08/2018   |
      | CMS11346_Scenario4_2                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN4_2     | -2000   | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario5_1                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN5_1     | 4000    | 12001  | 1003          | 20/08/2018   |
      | CMS11346_Scenario5_2                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN5_2     | 4000    | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario6_1                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN6_1     | 9000    | 12001  | 1003          | 21/08/2018   |
      | CMS11346_Scenario6_2                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN6_2     | 9000    | 12000  | 1003          | 21/08/2018   |
      | CMS11346_Scenario7_1                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN7_1     | 10000   | 12001  | 1003          | 21/08/2018   |
      | CMS11346_Scenario7_2                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN7_2     | 10000   | 12000  | 1003          | 21/08/2018   |
      | CMS11346_Scenario8_1                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN8_1     | 10000   | 12001  | 1006          | 20/08/2018   |
      | CMS11346_Scenario8_2                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN8_2     | 10000   | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario9_1                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN9_1     | 10000   | 12001  | 1003          | 20/08/2018   |
      | CMS11346_Scenario9_2                          | CHECKBOOKDATE1    | CHECKBOOK11346_SCN9_2     | 10000   | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario11_1                         | CHECKBOOKDATEUN11 | CHECKBOOK11346_SCN11_11_1 | 10000   | 99     | 1002          | 20/08/2018   |
      | CMS11346_Scenario11_1_CMS11346_OPN_Scenario11 | CHECKBOOKDATEUN11 | CHECKBOOK11346_SCNOPN8    | -3000   | 99     | 1002          | 20/08/2018   |
      | CMS11346_Scenario11_2                         | CHECKBOOKDATEUN11 | CHECKBOOK11346_SCN11_11_2 | 10000   | 99     | 1002          | 20/08/2018   |
      | CMS11346_Scenario11_12_1                      | CHECKBOOKDATEUN11 | CHECKBOOK11346_SCN11_12_1 | 10000   | 99     | 1002          | 20/08/2018   |
      | CMS11346_Scenario11_12_2                      | CHECKBOOKDATEUN11 | CHECKBOOK11346_SCN11_12_2 | 10000   | 99     | 1002          | 20/08/2018   |
      | CMS11346_Scenario11_13_1                      | CHECKBOOKDATEUN11 | CHECKBOOK11346_SCN11_13_1 | 10000   | 99     | 1002          | 21/08/2018   |
      | CMS11346_Scenario11_13_2                      | CHECKBOOKDATEUN11 | CHECKBOOK11346_SCN11_13_2 | 10000   | 99     | 1002          | 21/08/2018   |

  # //check CMS11346_Scenario11_Check
  Scenario: To check exception for unknown fund
    And I get "Select trans_ref_no,name From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'CHECKBOOKDATEUN11' order by trans_ref_no" query export "TC001"

  Scenario:Add inserts for booking date
    And I load account "CMS11346_Scenario11_CreateAccount"
    And I execute sql file "CMS11346_Scenario11_CreateAccountUpdate"
    And I load fund "CMS11346_Scenario11_CreateFND"

  # //check CMS11346_Scenario11_SCheck
  Scenario: To check exception for unknown fund
    And I get "Select DISTINCT  Amount,TRANS_REF_NO,account_id,OVERALL_STATUS,CURRENT_CALC_KEY From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'CHECKBOOKDATEUN11' order by trans_ref_no" query export "TC002"

  Scenario:Add inserts for booking date
    And I load account "CMS11346_Scenario14_CreateAccount"
    And I execute sql file "CMS11346_Scenario14_CreateAccountupdate"

  Scenario: 	Load the cashflows in below
    And I load cashflow
      | fileName                                          | accountNo          | referenceNo               | ammount | calKey | overallStatus | startingDate |
      | CMS11346_Scenario14_S1                            | CHECKBOOKDATESCN14 | CHECKBOOK11346_SCN14_14_1 | 10000   | 99     | 1002          | 20/08/2018   |
      | CMS11346_Scenario14_S2                            | CHECKBOOKDATESCN14 | CHECKBOOK11346_SCN14_14_2 | 10000   | 99     | 1002          | 20/08/2018   |
      | CMS11346_Scenario14_S3_CMS11346_OPN_Scenario14_S1 | CHECKBOOKDATESCN14 | CHECKBOOK11346_SCNOPN9    | 8000    | 99     | 1002          | 20/08/2018   |

  # //check CMS11346_Scenario14_SCheck
  Scenario: To check exception for unknown fund
    And I get "Select trans_ref_no,name From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'CHECKBOOKDATESCN14' and C.VALUE_DATE='19-AUG-18' order by trans_ref_no" query export "TC003"

  Scenario:Add inserts for booking date
    And I load fund "CMS11346_Scenario14_SCreateFND"
    And I execute sql file "CMS11346_Scenario14_SUpdateFundGroup"
    And I load account "CMS11346_Scenario15_CreateAccount"
    And I execute sql file "CMS11346_Scenario15_CreateAccountupdate"
    And I load fund "CMS11346_Scenario15_CreateFND"

  Scenario: To check CHECKBOOKDATESCN14
    And I get "select Amount,TRANS_REF_NO,account_id,OVERALL_STATUS,CURRENT_CALC_KEY from cms_bdr_transaction where account_id='CHECKBOOKDATESCN14'" query export "TC004"

  Scenario: 	Load the cashflows in below
    And I load cashflow
      | fileName                                          | accountNo          | referenceNo             | ammount | calKey | overallStatus | startingDate |
      | CMS11346_Scenario15_S1                            | CHECKBOOKDATESCN15 | CHECKBOOK11346_SCN15_1  | 10000   | 99     | 1002          | 20/08/2018   |
      | CMS11346_Scenario15_S1_CMS11346_OPN_Scenario10_S1 | CHECKBOOKDATESCN15 | CHECKBOOK11346_SCNOPN10 | 9000    | 99     | 1002          | 20/08/2018   |
      | CMS11346_Scenario15_S2                            | CHECKBOOKDATESCN15 | CHECKBOOK11346_SCN15_2  | 10000   | 99     | 1002          | 20/08/2018   |

  Scenario: Update fund
    And I execute sql file "CMS11346_Scenario15_SUpdateFundGroup"

  Scenario: 	Load the cashflows in below
    And I load cashflow
      | fileName                                                      | accountNo          | referenceNo             | ammount | calKey | overallStatus | startingDate |
      | CMS11346_Scenario16_CreateCashFlow                            | CHECKBOOKDATESCN15 | CHECKBOOK11346_SCN16    | 10000   | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario16_CreateCashflow_CMS11346_OPN_Scenario11_S1 | CHECKBOOKDATESCN15 | CHECKBOOK11346_SCNOPN11 | 9000    | NULL   | 1024          | 20/08/2018   |

  Scenario: Load fund
    And I load fund "CMS11346_Scenario16_SCreateFND"

  Scenario: To check CHECKBOOKDATESCN14
    And I get "select Amount,TRANS_REF_NO,account_id,OVERALL_STATUS,CURRENT_CALC_KEY from cms_bdr_transaction where account_id='CHECKBOOKDATESCN15' AND CURRENT_CALC_KEY IS NOT NULL" query export "TC005"

  Scenario: 	Load the cashflows in below
    And I load cashflow
      | fileName                              | accountNo      | referenceNo               | ammount    | calKey | overallStatus | startingDate |
      | CMS11346_Scenario17_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN17_1    | -40000     | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario17_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN17_1    | -40000     | 12001  | 1003          | 20/08/2018   |
      | CMS11346_Scenario17_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN17_1    | -40000     | 0      | 1004          | 20/08/2018   |
      | CMS11346_Scenario17_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN17_2    | -40000     | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario17_CreateCashFlow_5  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN17_2    | -40000     | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario18_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN18_1    | 10000      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario18_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN18_1    | 10000      | 12001  | 1003          | 21/08/2018   |
      | CMS11346_Scenario18_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN18_2    | -14000     | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario18_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN18_2    | -14000     | 12000  | 1003          | 21/08/2018   |
      | CMS11346_Scenario19_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN19_1    | -12000     | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario19_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN19_1    | -12000     | 12001  | 1006          | 20/08/2018   |
      | CMS11346_Scenario19_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN19_1    | -13000     | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario19_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN19_1    | -17000     | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario22_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN22_22_1 | 55555      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario22_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN22_22_1 | 55555      | 12001  | 1003          | 21/08/2018   |
      | CMS11346_Scenario22_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN22_22_2 | 55555      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario22_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN22_22_2 | 55555      | 12000  | 1003          | 21/08/2018   |
      | CMS11346_Scenario23_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN23_1    | 55555      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario23_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN23_1    | 55555      | 12001  | 1006          | 20/08/2018   |
      | CMS11346_Scenario23_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN23_2    | 55555      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario23_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN23_2    | 55555      | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario24_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN24      | 55555      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario24_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN24      | 66666      | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario24_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN24      | 66666      | 0      | 1004          | 20/08/2018   |
      | CMS11346_Scenario24_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN24      | 66666      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario24_CreateCashFlow_5  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN24      | 88888      | 12000  | 1003          | 30/08/2018   |
      | CMS11346_Scenario26_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN26      | 55555      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario26_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN26      | 55556      | NULL   | 1024          | 19/08/2018   |
      | CMS11346_Scenario26_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN26      | 55555      | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario27_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN27_1    | 10000      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario27_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN27_1    | 10000      | NULL   | 1020          | 20/08/2018   |
      | CMS11346_Scenario27_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN27_2    | 10000      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario27_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN27_2    | 10000      | NULL   | 1020          | 20/08/2018   |
      | CMS11346_Scenario28_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN28      | 10000      | 12001  | 1003          | 20/08/2018   |
      | CMS11346_Scenario28_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN28      | 10000      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario28_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN28      | 11111      | 12001  | 1003          | 20/08/2018   |
      | CMS11346_Scenario28_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN28_2    | 10000      | 12001  | 1003          | 20/08/2018   |
      | CMS11346_Scenario28_CreateCashFlow_5  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN28_2    | 10000      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario28_CreateCashFlow_6  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN28_2    | 11111      | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario29_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN29      | -10000     | NULL   | 1020          | 20/08/2018   |
      | CMS11346_Scenario29_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN29      | -10000     | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario29_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN29      | -10000     | 12001  | 1006          | 20/08/2018   |
      | CMS11346_Scenario29_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN29_2    | -10000     | NULL   | 1020          | 20/08/2018   |
      | CMS11346_Scenario29_CreateCashFlow_5  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN29_2    | -10000     | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario29_CreateCashFlow_6  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN29_2    | -10000     | 12000  | 1003          | 20/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow    | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | 10000      | 12001  | 1003          | 21/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow_2  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | 10000      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow_3  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | 10000      | 12000  | 1003          | 25/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow_4  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | 10000      | NULL   | 1019          | 20/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow_5  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | 10000      | NULL   | 1019          | 20/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow_6  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | 10001      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow_7  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | 10004      | NULL   | 1019          | 20/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow_8  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | 10000      | 0      | 1019          | 20/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow_9  | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | 10002      | NULL   | 1024          | 19/08/2018   |
      | CMS11346_Scenario30_CreateCashFlow_10 | CHECKBOOKDATE1 | CHECKBOOK11346_SCN30      | -999990000 | 12000  | 1003          | 01/09/2018   |
      | CMS11346_OPN_Scenario1                | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN1    | 5000       | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario2                | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN2    | 5000       | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario3                | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN3    | -4000      | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario4                | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN4    | -7000      | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario5                | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN5    | -2000      | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario6                | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN6    | -2000      | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario17               | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN17   | -15000     | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario17_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN17   | -15000     | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario18               | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN19   | -14000     | NULL   | 1024          | 17/08/2018   |
      | CMS11346_OPN_Scenario18_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN18   | -14000     | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario19               | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN19   | -99000     | NULL   | 1024          | 17/08/2018   |
      | CMS11346_OPN_Scenario19_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN19   | -14000     | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario19_3             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN19   | -15000     | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario19_4             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN19   | -19000     | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario22               | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN22   | 5000       | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario22_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN22   | 5000       | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario23               | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN23   | 5000       | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario23_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN23   | -7000      | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario24               | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN24   | 5000       | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario24_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN24   | -7000      | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario24_3             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN24   | -7000      | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario24_4             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN24   | -7000      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario24_5             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN24   | -7001      | NULL   | 1024          | 19/08/2018   |
      | CMS11346_OPN_Scenario24_6             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN24   | -18000     | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario26               | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN26   | 5000       | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario26_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN26   | -7000      | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario26_3             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN26   | -66000     | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario27_1             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN27_1 | 5000       | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario27_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN27_1 | 5000       | NULL   | 1020          | 20/08/2018   |
      | CMS11346_OPN_Scenario28_1             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN28_1 | 5000       | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario28_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN28_1 | 5000       | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario28_3             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN28_1 | 77000      | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario29_1             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN29   | 5000       | NULL   | 1020          | 20/08/2018   |
      | CMS11346_OPN_Scenario29_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN29   | 5000       | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario29_3             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN29   | 76000      | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario30_1             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50000     | 12002  | 1003          | 21/08/2018   |
      | CMS11346_OPN_Scenario30_2             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50000     | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario30_3             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50000     | 12002  | 1003          | 25/08/2018   |
      | CMS11346_OPN_Scenario30_4             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50000     | NULL   | 1019          | 20/08/2018   |
      | CMS11346_OPN_Scenario30_5             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50000     | NULL   | 1019          | 20/08/2018   |
      | CMS11346_OPN_Scenario30_6             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50001     | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario30_7             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50000000  | NULL   | 1019          | 20/08/2018   |
      | CMS11346_OPN_Scenario30_8             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50000000  | 12002  | 1003          | 20/08/2018   |
      | CMS11346_OPN_Scenario30_9             | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50000000  | NULL   | 1024          | 20/08/2018   |
      | CMS11346_OPN_Scenario30_10            | CHECKBOOKDATE1 | CHECKBOOK11346_SCNOPN30   | -50000000  | 12002  | 1003          | 20/08/2018   |


  Scenario:I verify ladder exports
    And I login as "altBKD" user
    And I go to the ladder page
    And I select balanceType "Opening Statement Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Projected Balance - STANDARD"
    And I verify balances csv for "TC006"

  Scenario:I verify Transction exports
    And I verify transaction grid exports
      | testCaseNo | transactionDate                                       | transactionDetailsOf                                          |
      | TC007      | 20/08/2018 Confirmed (Matched) cash events - STANDARD | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Cash                     |
      | TC008      | 20/08/2018 Confirmed (Matched) cash events - STANDARD | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Trade                    |
      | TC009      | 20/08/2018 Confirmed (Matched) cash events - STANDARD | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATEUN11:Cash                  |
      | TC010      | 20/08/2018 Confirmed (Matched) cash events - STANDARD | CHECKBOOKDATEFND15:AED:CHECKBOOKDATESCN15:Cash                |
      | TC011      | 20/08/2018 Confirmed (Matched) cash events - STANDARD | CHECKBOOKDATEFNDSCN14:AED:CHECKBOOKDATESCN14:Cash             |
      | TC012      | 20/08/2018 Opening Statement Balance - STANDARD       | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Default Category         |
      | TC013      | 20/08/2018 Opening Statement Balance - STANDARD       | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATEUN11:Default Category      |
      | TC014      | 20/08/2018 Opening Statement Balance - STANDARD       | CHECKBOOKDATEFND15:AED:CHECKBOOKDATESCN15:Default Category    |
      | TC015      | 20/08/2018 Opening Statement Balance - STANDARD       | CHECKBOOKDATEFNDSCN14:AED:CHECKBOOKDATESCN14:Default Category |
      | TC016      | 20/08/2018 Projected Balance - STANDARD               | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Cash                     |
      | TC017      | 20/08/2018 Projected Balance - STANDARD               | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Trade                    |
      | TC018      | 20/08/2018 Projected Balance - STANDARD               | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATEUN11:Cash                  |
      | TC019      | 20/08/2018 Projected Balance - STANDARD               | CHECKBOOKDATEFND15:AED:CHECKBOOKDATESCN15:Cash                |
      | TC020      | 20/08/2018 Projected Balance - STANDARD               | CHECKBOOKDATEFNDSCN14:AED:CHECKBOOKDATESCN14:Cash             |
      | TC021      | 21/08/2018 Confirmed (Matched) cash events - STANDARD | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Cash                     |
      | TC022      | 21/08/2018 Confirmed (Matched) cash events - STANDARD | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Trade                    |
      | TC023      | 21/08/2018 Confirmed (Matched) cash events - STANDARD | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATEUN11:Cash                  |
      | TC024      | 21/08/2018 Projected Balance - STANDARD               | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Cash                     |
      | TC025      | 21/08/2018 Projected Balance - STANDARD               | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Trade                    |
      | TC026      | 21/08/2018 Projected Balance - STANDARD               | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATEUN11:Cash                  |

  Scenario:I verify Transction history exports
    And I extract transaction history
      | testCaseNo | transactionDate                                       | transactionDetailsOf                                  | transactionReference    |
      | TC027      | 20/08/2018 Projected Balance - STANDARD               | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Cash             | CHECKBOOK11346_SCN28    |
      | TC028      | 20/08/2018 Confirmed (Matched) cash events - STANDARD | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Cash             | CHECKBOOK11346_SCN30    |
      | TC029      | 20/08/2018 Opening Statement Balance - STANDARD       | CHECKBOOKDATEFND1:JPY:CHECKBOOKDATE1:Default Category | CHECKBOOK11346_SCNOPN30 |
