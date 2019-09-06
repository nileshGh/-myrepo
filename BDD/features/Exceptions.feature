#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")
#Fund specific functions
@Import("BDD\features-meta\fund.meta")
#Date selection specific functions (without js)
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

Feature: Exceptions
  To Check the expention cashflows


  Scenario: TC0 Prereq for exception loading fund, account and cashflow
    Given moduleName is "exceptions"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I login as "functional" user
    And I update CBD for "Default" region to "12-JUN-18"
    And I login as "functional" user
    And I load account
      | fileName  |
      | EXCPACC-1 |
      | EXCPACC-2 |
      | EXCPACC-3 |
      | EXCPACC-4 |
      | EXCPACC-5 |
    And I load fund
      | fileName   |
      | EXCPFUND-1 |
    And I load cashflow
      | fileName | accountNo | referenceNo | ammount | calKey | overallStatus | startingDate |
      | EXCP-01  | EXPACC7   | TRANS571    | 100043  | 99     | 1002          | 01/03/2018   |
      | EXCP-02  | EXPACC3   | TRANS572    | 100043  | 99     | 1002          | 01/03/2018   |
      | EXCP-04  | EXPACC3   | TRANS574    | 100043  | 99     | 1002          | 01/03/2018   |
      | EXCP-05  | EXPACC1   | TRANS575    | 100043  | 99     | 1002          | 01/03/2018   |
      | EXCP-06  | EXPACC1   | TRANS576    | 100043  | 99     | 1002          | 01/03/2018   |

  Scenario: TC0 To check cashflows in exceptions are on ladder grid
    And I login as "functional" user
    And I go to the ladder page
    And I select balanceType "Cashflows with open exceptions - STANDARD"
    And I set ladder daterange from "12/06/2018" to "22/06/2018"
    And I apply ladder filter "Fund:!CASHLADDERCASES!;Currency:!CAD!;Account:!HGFCADAC2!"
    And I apply ladder filter "Fund:!CASHLADDERCASES!;Currency:!CAD!;Account:!HGFCADAC2!"
    And I wait for page to load
    And I verify balances csv for "TC001"

  Scenario:TC0 Verify transaction ladder
    And I remove ladder filter for "Fund:!CASHLADDERCASES!;Currency:!CAD!"
    And I verify balances from transaction ladder for transaction details of
      | testcaseNo | ofdate                                               | ofperspective                              | filter                                        |
      | TC002      | 12/06/2018 Cashflows with open exceptions - STANDARD | EXPFUND1:AUD:Unknown Account-Default:Cash  | Fund:=EXPFUND1;Category:=Cash                 |
      | TC003      | 12/06/2018 Cashflows with open exceptions - STANDARD | Unknown Fund:AUD:EXPACC3:Default Category  | Fund:=Unknown Fund;Category:=Default Category |
      | TC004      | 12/06/2018 Cashflows with open exceptions - STANDARD | Unknown Fund:Unknown Currency:EXPACC1:Cash | Fund:=Unknown Fund;Category:=Cash             |

  Scenario: TC1 To check exception for unknown account and for fund account mismtach
    And I get "Select A.Exception_Id, A.Exception_Type_Id, D.Name, C.Transaction_Int_Id, C.Trans_Ref_No, C.Value_Date, C.Effective_Date, C.Overall_Status, A.Active_Status From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'EXPACC7' and C.VALUE_DATE='12-JUN-18' order by TRANS_REF_NO desc" query export "TC101"
    And I load account
      | fileName |
      | EXCPACC1 |
    And I get "Select A.Exception_Id, A.Exception_Type_Id, D.Name, C.Transaction_Int_Id, C.Trans_Ref_No, C.Value_Date, C.Effective_Date, C.Overall_Status, A.Active_Status From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'EXPACC7' and C.VALUE_DATE='12-JUN-18' order by TRANS_REF_NO desc" query export "TC102"
    And I load fund
      | fileName  |
      | EXCPFUND1 |
    And I get "select Amount,account_id,ACTIVE_STATUS,CURRENT_CALC_KEY,OVERALL_STATUS ,value_date,effective_date,TXN_sequence_id,trade_type from cms_bdr_transaction where TRANS_REF_NO='TRANS571'" query export "TC103"

  Scenario: TC2 To check exception for unknown fund
    And I get "Select A.Exception_Id, A.Exception_Type_Id, D.Name, C.Transaction_Int_Id, C.Trans_Ref_No, C.Value_Date, C.Effective_Date, C.Overall_Status, A.Active_Status From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id=D.Exception_Type_Id and C.ACCOUNT_ID = 'EXPACC3' and C.VALUE_DATE='12-JUN-18'order by TRANS_REF_NO,name desc" query export "TC201"
    And I load fund
      | fileName  |
      | EXCPFUND2 |
    And I get "select Amount,account_id,ACTIVE_STATUS,CURRENT_CALC_KEY,OVERALL_STATUS ,value_date,effective_date,TXN_sequence_id,trade_type from cms_bdr_transaction where TRANS_REF_NO='TRANS572'" query export "TC202"

  Scenario: TC4 To check exception for unknown category
    And I get "Select A.Exception_Id, A.Exception_Type_Id, D.Name, C.Transaction_Int_Id, C.Trans_Ref_No, C.Value_Date, C.Effective_Date, C.Overall_Status, A.Active_Status From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'EXPACC3' and C.VALUE_DATE='12-JUN-18' order by TRANS_REF_NO desc, exception_id" query export "TC401"

  Scenario: TC5 To check exception for unknown currency
    And I get "Select A.Exception_Id, A.Exception_Type_Id, D.Name, C.Transaction_Int_Id, C.Trans_Ref_No, C.Value_Date, C.Effective_Date, C.Overall_Status, A.Active_Status From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'EXPACC1' and C.VALUE_DATE='12-JUN-18' order by TRANS_REF_NO,name desc" query export "TC501"

  Scenario: TC6 To check exception for Account Currency mismatch
    And I get "Select A.Exception_Id, A.Exception_Type_Id, D.Name, C.Transaction_Int_Id, C.Trans_Ref_No, C.Value_Date, C.Effective_Date, C.Overall_Status, A.Active_Status From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'EXPACC1' and C.VALUE_DATE='12-JUN-18' order by Name ,Trans_Ref_No" query export "TC601"

  Scenario: TC0 To check cashflows in exceptions are on ladder grid
    And I login as "functional" user
    And I go to the ladder page
    And I select balanceType "Cashflows with open exceptions - STANDARD"
    And I set ladder daterange from "12/06/2018" to "22/06/2018"
    And I apply ladder filter "Fund:!CASHLADDERCASES!;Currency:!CAD!;Account:!HGFCADAC2!"
    And I apply ladder filter "Fund:!CASHLADDERCASES!;Currency:!CAD!;Account:!HGFCADAC2!"
    ##WA##Temp Revision: As discussed 30/11 STRAT-271/274
    ##WA##And I refresh the current page
    And I wait for page to load
    And I verify balances csv for "TC010"

  Scenario:TC13 To test exception for inactive account is getting generated
    And I remove ladder filter for "Fund:!CASHLADDERCASES!;Currency:!CAD!;Account:!HGFCADAC2!"
    And I load account
      | fileName                    |
      | ExceptionCase13_AccountFeed |
    And I load fund
      | fileName                 |
      | ExceptionCase13_FundFeed |
    And I execute query "update cms_ref_account_param set ACTIVE_STATUS=4 where name ='ExceptionAcc12'" to update " " rows
    And I execute query "update CMS_REF_AGG set ACTIVE_STATUS=2 where name ='ExceptionAcc12'" to update " " rows
    And I load cashflow
      | fileName                 | accountNo      | referenceNo       | ammount | calKey | overallStatus | startingDate |
      | ExceptionCase13_CashFlow | ExceptionAcc12 | ExceptionCase12_4 | -200000 | 99     | 1002          | 15/06/2018   |
    And I get "Select trans_ref_no,name From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'ExceptionAcc12' and C.VALUE_DATE='15-JUN-18'" query export "TC013_1"
    And I login as "functional" user
    And I go to the ladder page
    And I select balanceType "Cashflows with open exceptions - STANDARD"
    And I set ladder daterange from "15/06/2018" to "25/06/2018"
    And I apply ladder filter "Account:=ExceptionAcc12"
    And I open transaction details of "15/06/2018 Cashflows with open exceptions - STANDARD" and "EXCEPTIONACC12FND:AED:ExceptionAcc12:Cash"
    And I extract transaction csv for "TC013_2"

  Scenario:TC12 To test when CAN is loaded on resolved exception transaction (1002-->1003) then balances for cashflows with open exceptions are not getting updated
    And I load account
      | fileName                    |
      | ExceptionCase12_AccountFeed |
    And I load cashflow
      | fileName                 | accountNo      | referenceNo       | ammount | calKey | overallStatus | startingDate |
      | ExceptionCase12_CashFlow | ExceptionAcc12 | ExceptionCase12_4 | -200000 | NULL   | 1021          | 15/06/2018   |
    And I select balanceType "Projected Balance - STANDARD:Confirmed (Matched) cash events - STANDARD:Confirmed inc Opening - STANDARD:Cashflows with open exceptions - STANDARD"
    And I apply ladder filter "Account:=ExceptionAcc12"
    And I verify balances csv for "TC012_1"
    And I open transaction details of "15/06/2018 Confirmed (Matched) cash events - STANDARD" and "EXCEPTIONACC12FND:AED:ExceptionAcc12:Cash"
    And I verify all transaction from transaction grid for testcase "TC012_2"

  Scenario:TC14 To check transaction history grid for unknown account exception raised in first case
    And I open transaction history details for transaction with "Amount" "-200,000.000"
    And I sort ascending on transaction history ladder for "Sequence Number"
    And I extract transaction history csv for "TC012_3"

  Scenario:Laddder-TC51 To test whether cashflows are not getting balanced when it is loaded using aggregate alias which is in pending authorisation state
    And I load account
      | fileName         |
      | CashLadder_Acc51 |
      | CashLadder_Acc52 |
    And I load fund
      | fileName           |
      | CashLadder_FNDFeed |
    And I execute query "insert into CMS_REF_AGG_ALIAS ( ALIAS_ID , ALIAS_TYPE_ID , AGG_ID , ALIAS , ACTIVE_STATUS , SOFT_LOCK_KEY , VERSION_ID ) values( '15147900',  '2',(select AGG_ID from CMS_REF_AGG where name like 'CashLadderCase51'),  'EXTACCAS51',  '2',  '0',  '1')" to update "1" rows
    And I execute query "insert into CMS_REF_ALIAS_PARAM ( AGG_ID , ALIAS_ID , ALIAS , ACTIVE_STATUS , VERSION_ID , ALIAS_TYPE_ID , ACTIONED_BY , AUTHORIZED_BY , ACTIONED_DATE , AUTHORIZED_DATE ) values( (select AGG_ID from CMS_REF_AGG where name like 'CashLadderCase51'),  '15147900',  'EXTACCAS51',  '4',  '1',  '2',  'AUTO1',  'AUTO2',  '16-OCT-15',  '16-OCT-15')" to update "1" rows
    And I load cashflow
      | fileName          | accountNo  | referenceNo         | ammount | calKey | overallStatus | startingDate |
      | CashLadder_Tran51 | EXTACCAS51 | CashLadderCases1234 | -200    | 99     | 1002          | 01/03/2018   |
    And I get "Select trans_ref_no,name From Exm_Bdr_Exception A, Exm_Bdr_Exception_Link B, Cms_Bdr_Transaction C, Exm_Ref_Exception_Type d Where A.Exception_Id = B.Exception_Id And B.Linked_Entity_Key = C.Transaction_Int_Id and A.Exception_Type_Id = D.Exception_Type_Id and C.ACCOUNT_ID = 'EXTACCAS51' and C.VALUE_DATE='15-JUN-18'" query export "TC051"

  Scenario:Ladder-TC52 To test whether cashflows are getting balanced when aggregate alias used is deleted but not approved
    And I load account
      | fileName         |
      | CashLadder_Acc52 |
    And I execute query "insert into CMS_REF_AGG_ALIAS ( ALIAS_ID , ALIAS_TYPE_ID , AGG_ID , ALIAS , ACTIVE_STATUS , SOFT_LOCK_KEY , VERSION_ID ) values( '15147902',  '2',(select AGG_ID from CMS_REF_AGG where name like 'CashLadderCase52'),  'EXTACCAS52',  '1',  '0',  '1')" to update "1" rows
    And I execute query "insert into CMS_REF_ALIAS_PARAM ( AGG_ID , ALIAS_ID , ALIAS , ACTIVE_STATUS , VERSION_ID , ALIAS_TYPE_ID , ACTIONED_BY , AUTHORIZED_BY , ACTIONED_DATE , AUTHORIZED_DATE ) values( (select AGG_ID from CMS_REF_AGG where name like 'CashLadderCase52'),  '15147902',  'EXTACCAS52',  '1',  '1',  '2',  'AUTO1',  'AUTO2',  '16-OCT-15',  '16-OCT-15')" to update "1" rows
    And I execute query "insert into CMS_REF_ALIAS_PARAM ( AGG_ID , ALIAS_ID , ALIAS , ACTIVE_STATUS , VERSION_ID , ALIAS_TYPE_ID , ACTIONED_BY , AUTHORIZED_BY , ACTIONED_DATE , AUTHORIZED_DATE ) values( (select AGG_ID from CMS_REF_AGG where name like 'CashLadderCase52'),  '15147902',  'EXTACCAS52',  '5', '2',  '2',  'AUTO2',  '',  '16-OCT-15',  '')" to update "1" rows
    And I load cashflow
      | fileName          | accountNo  | referenceNo          | ammount | calKey | overallStatus | startingDate |
      | CashLadder_Tran52 | EXTACCAS52 | CashLadderCases12345 | -200    | 12000  | 1003          | 01/03/2018   |
    And I login as "functional" user
    And I go to the ladder page
    And I set ladder daterange from "15/06/2018" to "25/06/2018"
    And I apply ladder filter "Fund:=CashLadderCases"
    And I apply ladder filter "Fund:=CashLadderCases"
    And I verify balances csv for "TC052"
