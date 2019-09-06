@login  @Smoke @regression
#Common Imports
@Import("..\..\..\Utilities\bddMeta\common.meta")
#Object Repository maintains common objects
@Import("..\..\..\Utilities\bddMeta\commonObjectRepository.meta")
#Object Repository maintains all the objects
@Import("BDD\features-meta\ObjectRepository.meta")


Feature: Login
  Test case for login validation
  As a cash manager
  I want to validate login to application

  Scenario: Verify login with valid and invalid username and password
    Given moduleName is "login"
    And I reset my gwen.web.chrome.prefs setting
    And my gwen.web.chrome.prefs setting is "${default_gwen_chrome_prefs},download.default_directory=${baseDirectory}data\${moduleName}\download_dir"
    And I logged in as user
      | user          |
      | valid         |
      | invalid       |
      | incorrect     |
      | casesensative |
      | valid         |
      | incorrect     |
      | incorrect     |
      | incorrect     |
      | incorrect     |

  Scenario: Verify when user tryies to login with expired password
    Given I logged in as "valid" user with expired password

  Scenario: Verify login screen gets opened if user tries access any module without login
    And I try navigate to
      | module   |
      | ladder   |
      | fund     |
      | strategy |
