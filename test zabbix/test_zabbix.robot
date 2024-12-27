*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url_zabbix}    http://103.114.200.248/zabbix/
${title_zabbix}    zbxtest: Zabbix
${input_user}    //*[@id="name"]
${input_pass}    //*[@id="password"]
${btn_Signin}    //*[@id="enter"]
${username_success}    Admin
${password_success}    zabbix
${username_fail}    Admin1234
${password_fail}    zabbix1234
${dashboards_zabbix}    //*[@id="dashboard"]/a
${txt_usernamefail}    /html/body/div/main/div[2]/form/ul/li[1]/div
#${txt_usernamefail}    //*/div[2]/form/ul/li[1]/div ใช้ xpath นี้ (ต้องเขียนเอง)
${error_message_username}    Incorrect user name or password or account is temporarily blocked.
${error_message_password}    Incorrect user name or password or account is temporarily blocked.
${clear_user}    /html/body/div/main/div[2]/form



*** Keywords ***
Verify zabbix page
    [Arguments]                ${title}
    Title Should Be            ${title}

Input Username and Password
    [Arguments]      ${xpath_user}       ${xpath_pass}     ${username}       ${password}
    Wait Until Element Is Visible    ${xpath_user}    
    Wait Until Element Is Visible    ${xpath_pass}   
     Element Should Be Visible    xpath=${xpath_user}
     Element Should Be Visible    xpath=${xpath_pass}
     Input Text       xpath=${xpath_user}       ${username}
     Input Text       xpath=${xpath_pass}       ${password}

Click Button Login
    Wait Until Element Is Visible    ${btn_Signin}    30s
    Click Button   ${btn_Signin}

Verify Login account Success
    [Arguments]     ${xpath}
    Wait Until Element Is Visible    ${xpath}    30s
    Element Should Be Visible   ${xpath}

Verify Login Fail by username fail
    [Arguments]     ${xpath}
    Clear Element Text    ${xpath}    
    Wait Until Element Is Visible    ${xpath}    30s
    # Sleep    30s
    Element Should Be Visible    ${xpath}

Verify Login Fail by username fail2
    [Arguments]     ${xpath}
    Wait Until Element Is Visible    ${xpath}    30s
    Element Text Should Be    ${xpath}    ${error_message_username}    

Verify Login Fail by password fail
    [Arguments]     ${xpath}
    Clear Element Text    ${xpath}    
    Wait Until Element Is Visible    ${xpath}    30s
    # Sleep    30s
    Element Should Be Visible    ${xpath}
Verify Login Fail by password_fail2
    [Arguments]     ${xpath}
    Wait Until Element Is Visible    ${xpath}    30s
    Element Text Should Be    ${xpath}    ${error_message_password}     

Open Website
    [Arguments]    ${website}    ${browser}
    Open Browser    ${website}    ${browser}    options=add_experimental_option("detach", True)
    Maximize Browser Window

*** Test Cases ***
Sign in zabbix - Verify account Success
    [tags]    Pass
    Open Website    ${url_zabbix}    chrome    
    Verify zabbix page    ${title_zabbix}
    Input Username and Password    ${input_user}     ${input_pass}       ${username_success}      ${password_success}
    Click Button Login        
    Verify Login account Success    ${dashboards_zabbix}

Sign in zabbix - username_fail
    [tags]    Pass
    Open Website    ${url_zabbix}    chrome    
    Verify zabbix page    ${title_zabbix}
    Input Username and Password    ${input_user}     ${input_pass}       ${username_fail}     ${password_success}
    Click Button Login      
    Verify Login Fail by username fail    ${input_user}
    Verify Login Fail by username fail2    //*/div[2]/form/ul/li[1]/div

Sign in zabbix - password_fail
    [tags]    Pass
    Open Website    ${url_zabbix}    chrome    
    Verify zabbix page    ${title_zabbix}
    Input Username and Password    ${input_user}     ${input_pass}       ${username_success}     ${password_fail}
    Click Button Login      
    Verify Login Fail by password fail    ${input_pass}
    Verify Login Fail by password fail2    //*/div[2]/form/ul/li[1]/div

