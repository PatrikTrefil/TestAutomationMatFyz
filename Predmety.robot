*** Settings ***
Library  Browser
Suite Setup    New Browser    browser=${browser}    headless=${headless}
Test Setup    New Context    viewport={'width': 1920, 'height': 1080}
Test Teardown    Close Context
Suite Teardown    Close Browser

*** Variables ***

${browser}  chromium
${headless}  false

*** Test Cases ***

Search subject and check credits
  SIS is open
  Go from homepage to Subject page

  Get Title  should be  Předměty
  ${loc_SUBJECT_NAME}  Set Variable  id=nazev
  ${loc_ANOTACE}  Set Variable  id=srch_pam_a
  ${value_LETNI_SEMESTR}  Set Variable  2
  ${loc_SEMESTER_LISTBOX}  Set Variable  id=sem
  ${loc_RADIOBUTTON_VYUCUJICI}  Set Variable  id=utyp_2
  ${loc_VYUCUJICI_TEXTBOX}  Set Variable  id=ujmeno

  Fill Text  ${loc_SUBJECT_NAME}  Úvod do softwarového
  Check Checkbox  ${loc_ANOTACE}
  Select Options By  ${loc_SEMESTER_LISTBOX}  value  ${value_LETNI_SEMESTR}
  Fill Text  ${loc_VYUCUJICI_TEXTBOX}  Nečaský
  Check Checkbox  ${loc_RADIOBUTTON_VYUCUJICI}
  Click  text=Hledej
  Get Element  xpath=//a[contains(text(), "NSWI041")]
  Click  xpath=//a[contains(text(), "NSWI041")]
  Get Text  css=#content > div.form_div > div.form_div_title  should be  Úvod do softwarového inženýrství - NSWI041
  Get Text  xpath=//th[contains(text(), "E-Kredity:")]/../td  should be  5

*** Keywords ***
SIS is open
    New Page       https://is.cuni.cz/studium/index.php

Go from homepage to Subject page
    Click  id=hint_predmety
