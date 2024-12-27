*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url_pantip}    https://pantip.com/login?redirect=aHR0cHM6Ly9wYW50aXAuY29tLw==
${title_pantip}    เข้าสู่ระบบ - Pantip
${error_message_email}    อีเมลหรือนามแฝงที่คุณป้อน ไม่ตรงกับบัญชีใดๆ สมัครใช้งานบัญชี
${error_message_password}    รหัสผ่านไม่ถูกต้อง ลองอีกครั้งหรือคลิก “ลืมรหัสผ่าน“ เพื่อรีเซ็ตรหัส
${input_user}    //*[@id="member_email"]
${input_pass}    //*[@id="member_password"]
${btn_login}    //*[@id="__next"]/div/div/div/div[9]/div[1]/form/button
${txt_emailfail1}    //*[@id="__next"]/div/div/div/div[9]/div[1]/form/section/label[1]/div[2]
${txt_passfail}    //*[@id="__next"]/div/div/div/div[9]/div[1]/form/section/label[2]/div
${user_avatar}    //*[@id="__next"]/div/div/div/div[1]/div/ul[2]/a[6]/li
${username_fail}    itchaya1913@gmail.com            
${password_fail}    12345678           
${username_success}    itchaya1912@gmail.com            
${password_success}    Fk47031516   
${btnuser_avatar}    //*[@id="__next"]/div/div/div/div[1]/div/ul[2]/a[6]/li
${user_pantip}    //*[@id="ptContainerMain"]/div[7]/div/ul[1]/li[1]/a/span[2]
${manu_จัดการข้อมูลส่วนตัว}    //*[@id="ptListDropdownMenu"]/div/div[2]
${ยืนยัน_email}    //*[@id="main-body-content"]/div[4]/div[2]/div[1]/div[3]/div/p[1]
${message_ยืนยัน_email}    ${username_success} เปลี่ยนอีเมล


*** Keywords ***

Verify Pantip page
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
    Wait Until Element Is Visible    ${btn_login}    30s
    Click Button   ${btn_login}


Verify Login account Success
    [Arguments]     ${xpath}
    Wait Until Element Is Visible    ${xpath}    30s
    Element Should Be Visible   ${xpath}
    Click Element    ${btnuser_avatar}
    Click Element    ${manu_จัดการข้อมูลส่วนตัว}
    Element Text Should Be    ${ยืนยัน_email}    ${message_ยืนยัน_email}

    

Verify Login Fail by email fail
    [Arguments]     ${xpath}
    Wait Until Element Is Visible    ${xpath}    30s
    # Sleep    30s
    Element Should Be Visible   ${xpath}
    Element Text Should Be    ${xpath}    ${error_message_email}

Verify Login Fail by password fail
    [Arguments]     ${xpath}
    Wait Until Element Is Visible    ${xpath}
    # Sleep    30s
    Element Should Be Visible   ${xpath}
    Element Text Should Be    ${xpath}    ${error_message_password}    
    

Open Website
    [Arguments]    ${website}    ${browser}
    Open Browser    ${website}    ${browser}    options=add_experimental_option("detach", True)
    Maximize Browser Window


*** Test Cases ***
Login Pantip - Verify account Success
    [tags]    Pass
    Open Website    ${url_pantip}    chrome    
    Verify Pantip page    ${title_pantip}
    Input Username and Password    ${input_user}     ${input_pass}       ${username_success}      ${password_success}
    Click Button Login        
    Verify Login account Success    ${user_pantip}
    Sleep    60s

Login Pantip - click botton
    [tags]    Pass
    Open Website    ${url_pantip}    chrome    
    Verify Pantip page    ${title_pantip}
    Input Username and Password    ${input_user}     ${input_pass}       ${username_success}      ${password_success}
    Click Button Login      
    Sleep    60s
Login Pantip - username_fail1
    [tags]    Pass
    Open Website    ${url_pantip}    chrome    
    Verify Pantip page    ${title_pantip}
    Input Username and Password    ${input_user}     ${input_pass}       ${username_fail}     ${password_success}
    Click Button Login      
    Verify Login Fail by email fail    ${txt_emailfail1}

Login Pantip - password_fail1
# test check xpath ${txt_emailfail1}
    [tags]    fail
    Open Website    ${url_pantip}    chrome    
    Verify Pantip page    ${title_pantip}
    Input Username and Password    ${input_user}     ${input_pass}       ${username_success}     ${password_fail}
    Click Button Login      
    Verify Login Fail by email fail    ${txt_emailfail1}

Login Pantip - password_fail2
    [tags]    Pass
    Open Website    ${url_pantip}    chrome    
    Verify Pantip page    ${title_pantip}
    Input Username and Password    ${input_user}     ${input_pass}       ${username_success}     ${password_fail}
    Click Button Login      
    Verify Login Fail by password fail    ${txt_passfail}

Login Pantip - username_fail2
# test check xpath ${txt_emailfail1}
    [tags]    fail
    Open Website    ${url_pantip}    chrome    
    Verify Pantip page    ${title_pantip}
    Input Username and Password    ${input_user}     ${input_pass}       ${username_fail}     ${password_success}
    Click Button Login      
    Verify Login Fail by password fail    ${txt_passfail}3

