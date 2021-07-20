import QtQuick.Window 2.2
import QtQuick 2.3
import QtQuick.Layouts 1.8
import QtQuick.Dialogs 1.3
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import RSALibrary 1.0
import QtWebEngine 1.7

ApplicationWindow{
    id:mainwin
    color:"#292929"
    visible:true  
    RSAClass{
        id:rsa        
    }  
    Dialog {
        id:dialog_warning
        visible:false
        parent: ApplicationWindow.overlay

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        focus: true
        modal: true        
        property alias text: messageText.text
        contentItem: Rectangle {
        color: "#292929"                 
        }
        Label {
            id: messageText
            text:myItem.warningtxt
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize:12
            anchors.fill: parent
            color:"white"            
        }        
    }  
    FileDialog {
        visible:false
        id: keyfiledialog                    
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: [ "Key files (*.pem)", "All files (*)" ]        
        onAccepted: {
            print("You chose: " + keyfiledialog.fileUrls)
            myItem.warningtxt="Selected KeyFile URL : "+keyfiledialog.fileUrls
            dialog_warning.visible=true                                 
        }                                                        
    }
    FileDialog {
        visible:false
        id: pubkeyfiledialog                    
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: [ "Key files (*.pem)", "All files (*)" ]        
        onAccepted: {
            print("You chose: " + pubkeyfiledialog.fileUrl)
            myItem.warningtxt=rsa.loadpubkey(pubkeyfiledialog.fileUrl)
            dialog_warning.visible=true                                 
        }                                                        
    } 
    FileDialog {
        visible:false
        id: privkeyfiledialog                    
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: [ "Key files (*.pem)", "All files (*)" ]        
        onAccepted: {
            print("You chose: " + privkeyfiledialog.fileUrl)
            myItem.warningtxt=rsa.loadprivkey(privkeyfiledialog.fileUrl)
            dialog_warning.visible=true                                 
        }                                                        
    }  
    FileDialog {
        visible:false
        id: folderdialog                    
        title: "Please choose a folder"
        folder: shortcuts.home
        selectFolder:true        
        onAccepted: {
            print("You chose: " + folderdialog.folder)       
            myItem.keyfolder=folderdialog.folder
            myItem.warningtxt="Selected Folder URL : "+folderdialog.folder
            dialog_warning.visible=true                                 
        }                                                        
    }
    
    Item {
        id: myItem
        property bool isClicked1: true
        property bool isClicked2: false
        property bool isClicked3: false
        property bool isClicked4: false 
        property bool isSending:false
        property int lenText:0
        property int index:0
        property string warningtxt:""
        property url keyfolder:""
        property string keyfilename:""
        function title_index(index){
            switch(index){
                case 0:
                    return "images/tab_bro.png"
                case 1:
                    return "images/tab_oper.png"
                case 2:
                    return "images/tab_set.png"
                case 3:
                    return "images/tab_key.png"
            }
        }
    }
    Row{
        Rectangle{
            id:rect_left
            color:"#3a3a3c"
            width: 302
            height: Window.height
            Image{
                id:image_mark
                source:"images/Privacy Machine_.png"
                x:rect_left.width/8
                y:50
            }
            Column{
                anchors.top:image_mark.bottom
                anchors.topMargin:100
                spacing:20
                Rectangle{                    
                    id:tab_browser
                    width:302
                    height:57                                                  
                    color:myItem.isClicked1?"#292929":"transparent"                                                  
                    Row{
                        spacing:20
                        Image{
                            visible:myItem.isClicked1?true:false
                            id:"tab_browser_bar"
                            source:"images/bar.png"
                        }
                        Image{
                            id:"tab_browser_icon"
                            source:myItem.isClicked1?"images/ico_browser_de.png":"images/ico_browser.png"
                            anchors.top:tab_browser_bar.top
                            anchors.topMargin:20
                        }
                        Image{
                            id:"tab_browser_text"
                            source:myItem.isClicked1?"images/font_browser_de.png":"images/font_browser.png"
                            anchors.top:tab_browser_bar.top
                            anchors.topMargin:24
                        }                        
                    }                                        
                    MouseArea {
                            anchors.fill: tab_browser
                            onClicked: {                                                             
                                myItem.isClicked1=true
                                myItem.isClicked2=false
                                myItem.isClicked3=false
                                myItem.isClicked4=false   
                                myItem.index=0                           
                             }
                    }                   
                }                
                Rectangle{
                    id:tab_oper
                    width:302
                    height:57        
                    color:myItem.isClicked2?"#292929":"transparent"
                    Row{
                        spacing:20
                        Image{
                            id:"tab_oper_bar"
                            source:"images/bar.png"
                            visible:myItem.isClicked2?true:false
                        }
                        Image{
                            id:"tab_oper_icon"
                            source:myItem.isClicked2?"images/ico_oper_de.png":"images/ico_oper.png"
                            anchors.top:tab_oper_bar.top
                            anchors.topMargin:20
                        }
                        Image{
                            id:"tab_oper_text"
                            source:myItem.isClicked2?"images/font_oper_de.png":"images/font_oper.png"
                            anchors.top:tab_oper_bar.top
                            anchors.topMargin:20
                        }
                    }
                    MouseArea {
                            anchors.fill: tab_oper
                            onClicked: {              
                                myItem.isClicked1=false                                               
                                myItem.isClicked2=true
                                myItem.isClicked3=false
                                myItem.isClicked4=false
                                myItem.index=1
                             }
                    }  
                }
                Rectangle{
                    id:tab_settings
                    width:302
                    height:57                    
                    color:myItem.isClicked3?"#292929":"transparent"
                    Row{
                        spacing:20
                        Image{
                            id:"tab_settings_bar"
                            source:"images/bar.png"
                            visible:myItem.isClicked3?true:false
                        }
                        Image{
                            id:"tab_settings_icon"
                            source:myItem.isClicked3?"images/ico_set_de.png":"images/ico_set.png"
                            anchors.top:tab_settings_bar.top
                            anchors.topMargin:20
                        }
                        Image{
                            id:"tab_settings_text"
                            source:myItem.isClicked3?"images/font_set_de.png":"images/font_set.png"
                            anchors.top:tab_settings_bar.top
                            anchors.topMargin:20
                        }
                    }
                    MouseArea {
                            anchors.fill: tab_settings
                            onClicked: {         
                                myItem.isClicked1=false
                                myItem.isClicked2=false
                                myItem.isClicked3=true
                                myItem.isClicked4=false
                                myItem.index=2
                             }
                    }  
                } 
                Rectangle{
                    id:tab_key
                    width:302
                    height:57
                    color:myItem.isClicked4?"#292929":"transparent"
                    Row{
                        spacing:20
                        Image{
                            id:"tab_key_bar"
                            source:"images/bar.png"
                            visible:myItem.isClicked4?true:false
                        }
                        Image{
                            id:"tab_key_icon"
                            source:myItem.isClicked4?"images/ico_key_de.png":"images/ico_key.png"
                            anchors.top:tab_key_bar.top
                            anchors.topMargin:20
                        }
                        Image{
                            id:"tab_key_text"
                            source:myItem.isClicked4?"images/font_key_de.png":"images/font_key.png"
                            anchors.top:tab_key_bar.top
                            anchors.topMargin:20
                        }
                    }
                    MouseArea {
                            anchors.fill: tab_key
                            onClicked: {               
                                myItem.isClicked1=false
                                myItem.isClicked2=false
                                myItem.isClicked3=false
                                myItem.isClicked4=true
                                myItem.index=3
                             }
                    }  
                }               
            }
        }
        Rectangle{
            id:rect_right
            color:"transparent"
            width:Window.width-rect_left.width
            height:Window.height  
            Column{
                anchors.top:rect_right.top
                anchors.topMargin:50
                x:50                
                Rectangle{
                    id:"right_top"                                            
                    Image{
                        id:tab_bro_title
                        source:myItem.title_index(myItem.index)
                    }
                    Image{ 
                        x:920
                        id:tab_bro_close
                        source:"images/btn_close.png" 
                        //Mouse area to react on click events
                        MouseArea {
                            anchors.fill: tab_bro_close
                            onClicked: { 
                                root.close()
                                rsa.exit_pro()                                
                            }
                        }                           
                    }                    
                }
                Rectangle{    
                    id:tab_bro_board  
                    visible:myItem.isClicked1?true:false                                  
                    width:Window.width-rect_left.width-100
                    height:600
                    color:"#8e8e93"
                    anchors.top:right_top.bottom
                    anchors.topMargin:70
                    radius:10
                    TextField {
                        id:"input_url"
                        width: 650
                        anchors.left:tab_bro_board.left
                        anchors.leftMargin:100
                        anchors.top:tab_bro_board.top
                        anchors.topMargin:30
                        Layout.fillWidth: true
                        color:"white"
                        focus:true
                        font.pointSize:24
                        placeholderText: qsTr("http://                                                    ")
                        background: Rectangle {
                                color: "#636366"
                                radius:10
                        }
                        onAccepted: {                            
                            web_page.url=input_url.text
                            scroll_web.visible=true
                            web_page.visible=true
                        }
                        selectByMouse: true
                    }

                    Image{
                        id:"btn_browse"
                        height:input_url.height
                        anchors.left:input_url.right
                        anchors.leftMargin:10
                        anchors.top:tab_bro_board.top
                        anchors.topMargin:30
                        source:"images/btn_browse"
                        //Mouse area to react on click events
                        MouseArea {
                            anchors.fill: btn_browse
                            onClicked: {                                 
                                 web_page.url=input_url.text
                                 scroll_web.visible=true      
                                 web_page.visible=true                           
                            }
                        }
                    }
                    Label{
                        id:progressBar_title
                        text:"Loading..."
                        anchors.horizontalCenter:progressBar.horizontalCenter                        
                        anchors.top:progressBar.top                        
                        anchors.topMargin:-50
                        font.pointSize:20
                        visible:false
                    }
                    ProgressBar {
                            id: progressBar
                            anchors.centerIn:parent
                            value: web_page.loadProgress/100
                            visible:false
                            height:10
                            indeterminate: (web_page.loadProgress>0)?false:true                                                
                    } 
                    ScrollView{
                        id:scroll_web
                        visible:false
                        anchors.left:parent.left
                        anchors.leftMargin:20
                        anchors.top:input_url.bottom
                        anchors.topMargin:10
                        ScrollBar.horizontal.interactive: true
                        ScrollBar.vertical.interactive: true
                        width:925
                        height:500  
                        background: Rectangle {
   			                color: "transparent"                                        
                        }
                        WebEngineView {
                            id:web_page                                                       
                            url: ""        
                            visible:false                    
                            anchors.fill:parent       
                            opacity: 0.1                  
                            onLoadingChanged:{
                                if(loadRequest.status === WebEngineLoadRequest.LoadFailedStatus){                                         
                                    var html = loadRequest.errorString;
                                    html=""    
                                    html="<center>"+html+"</center>"                                
                                    html=html+"<br><br><br><br><br><br><center><font color='blue' size='20px'>URL is wrong or website is closed!</font></center>"
                                    loadHtml(html);
                                    progressBar.visible=false
                                    progressBar_title.visible=false
                                }
                                else if(loadRequest.status===WebEngineLoadRequest.LoadStartedStatus){  
                                    web_page.opacity=0.1                                  
                                    progressBar.visible=true
                                     progressBar_title.visible=true
                                }
                                else if(loadRequest.status===WebEngineLoadRequest.LoadSucceededStatus){                                    
                                    web_page.opacity=1
                                    progressBar.visible=false
                                    progressBar_title.visible=false
                                }
                            }
                        }
                    }                    
                }
                Rectangle{
                    id:tab_oper_board  
                    visible:myItem.isClicked2?true:false                                  
                    width:Window.width-rect_left.width-100
                    height:600
                    color:"transparent"
                    anchors.top:right_top.bottom
                    anchors.topMargin:100
                    radius:50
                    ButtonGroup {
                        buttons: btn_row.children
                    }
                    Row {
                        id: btn_row
                        Button {
                            text: "<font color='white'>Receiving</font>"     
                            width:169
                            height:39
                            font.pointSize:16                            
                            background:Rectangle{
                                color:!myItem.isSending?"#3a3a3c":"#636366"
                                radius:5                                
                            }                       
                            onClicked: {            
                                myItem.isSending=false
                                contentText.text=""
                            }                                                   
                        }
                        Button {
                            text:"<font color='white'>Sending</font>"     
                            width:169
                            height:39
                            font.pointSize:16                            
                            background:Rectangle{
                                color:myItem.isSending?"#3a3a3c":"#636366"
                                radius:5
                            }
                            onClicked: {            
                                myItem.isSending=true
                                contentText.text=""
                            }
                        }                        
                    }
                    Rectangle{
                        id:input_content
                        anchors.top:btn_row.bottom
                        anchors.topMargin:40
                        width:Window.width-rect_left.width-100
                        height:500
                        color:"#3a3a3c"
                        radius:30
                        Row{
                            id:"title_top"
                            anchors.top:input_content.top
                            anchors.topMargin:30
                            anchors.left:input_content.left
                            anchors.leftMargin:50
                            spacing:550                            
                            Label{
                                text:"Write your message..."
                                color:"white"
                                font.pointSize:16
                            }
                            Label{
                                text:myItem.lenText+"/3000"
                                color:"white"
                                font.pointSize:16
                            }
                        }
                        ScrollView {
                            id: scView
                            anchors.centerIn: parent
                            width: input_content.width-80; height: 250 // The initial height is one line
                            background: Rectangle {                                
                                border.color: "gray"
                                radius: 5
                            }

                            TextArea {
                                id: contentText
                                color:"white"
                                background: Rectangle {                                    
                                    border.color: contentText.enabled ? "#21be2b" : "transparent"
                                    color:"#3a3a3c"
                                }
                                onTextChanged: if (length > 3000) remove(3000, length);                                
                                property int preContentHeight: 0
                                wrapMode: TextArea.Wrap; selectByMouse: true;    
                                font.pointSize:14                          
                                onContentHeightChanged: {
                                    myItem.lenText=contentText.length
                                    //The height of each line is 14, and it will scroll automatically when the input is greater than 3 lines
                                    if(contentHeight > 14 && contentHeight < 200) {
                                        if(contentHeight != preContentHeight) {
                                            preContentHeight = contentHeight;
                                            scView.height += 14;
                                        }
                                    }
                                }
                            }
                        }
                        Image{
                            id:mid_line
                            anchors.top:scView.bottom
                            anchors.topMargin:20
                            source:"images/mid_line.png"
                        }
                        Row{
                            anchors.top:mid_line.bottom
                            anchors.topMargin:10
                            anchors.left:mid_line.left
                            anchors.leftMargin:180
                            spacing: 20
                            Button{
                                id:load_pub_key
                                text:"Load Public Key"
                                enabled:myItem.isSending?true:false
                                width:140
                                height:40
                                font.pointSize:12                                    
                                palette {
                                    button: "#292929"
                                    buttonText:"#ffd60a"
                                }  
                                onClicked:{
                                    pubkeyfiledialog.visible=true
                                }                              
                            }
                            Button{
                                id:load_priv_key
                                text:"Load Private Key"
                                width:140
                                height:40
                                enabled:myItem.isSending?false:true
                                font.pointSize:12
                                palette {
                                    button: "#292929"
                                    buttonText:"#ffd60a"
                                } 
                                onClicked:{
                                    privkeyfiledialog.visible=true
                                }
                            }
                            Button{
                                id:encrypt_copy
                                text:qsTr("Encrypt && Copy")
                                width:140
                                height:40
                                font.pointSize:12
                                enabled:myItem.isSending?true:false
                                palette {
                                    button: "#292929"
                                    buttonText:"#ffd60a"
                                }
                                onClicked:{
                                    if(contentText.length==0){
                                        myItem.warningtxt="Please input text!"
                                        dialog_warning.visible=true
                                    }
                                    else{
                                        if(rsa.encrypt(contentText.text))
                                        {
                                            myItem.warningtxt="Copied to Clipboard!"
                                            dialog_warning.visible=true
                                        }
                                        else{
                                            myItem.warningtxt="Failed!"
                                            dialog_warning.visible=true
                                        }
                                    }
                                }                                
                            }
                            Button{
                                id:decrypt_copy
                                text:qsTr("Decrypt && Copy")
                                width:140
                                height:40
                                font.pointSize:12
                                enabled:myItem.isSending?false:true
                                palette {
                                    button: "#292929"
                                    buttonText:"#ffd60a"
                                }
                                onClicked:{
                                    if(contentText.length==0){
                                        myItem.warningtxt="Please input text!"
                                        dialog_warning.visible=true
                                    }
                                    else{
                                        if(rsa.decrypt(contentText.text)){
                                            myItem.warningtxt="Copied to Clipboard!"
                                            dialog_warning.visible=true
                                        }
                                        else{
                                            myItem.warningtxt="Failed!"
                                            dialog_warning.visible=true
                                        }                                        
                                    }
                                }
                            }
                        }
                    }
                }
                Rectangle{
                    id:tab_set_board  
                    visible:myItem.isClicked3?true:false                                  
                    width:Window.width-rect_left.width-100
                    height:500
                    color:"#3a3a3c"
                    anchors.top:right_top.bottom
                    anchors.topMargin:100
                    radius:50                    
                    Row{
                        id:tab_set_board_row1
                        anchors.top:tab_set_board.top
                        anchors.topMargin:50
                        anchors.left:tab_set_board.left
                        anchors.leftMargin:50                        
                        spacing:100
                        Rectangle{   
                            id:tab_set_board_account
                            Label{
                                anchors.left:parent.left
                                anchors.leftMargin:50                                
                                id:tab_set_board_account_label
                                text:"Account"
                                font.pointSize:20
                                color:"white"
                            }
                            Button{
                                id:tab_set_board_account_btn1
                                anchors.top:tab_set_board_account_label.bottom
                                anchors.topMargin:20
                                anchors.left:tab_set_board_account_label.left                                
                                text:"Upgrade to Pro"
                                width:220
                                height:80                                
                                palette.buttonText:"black"
                                font.pointSize:16   
                                background:Rectangle{
                                    radius:5
                                    color:"#ffd60a"
                                    border.color:"#a48ce1"
                                    border.width: tab_set_board_account_btn1.activeFocus ? 3 : 1                                    
                                }                               
                            }
                            Button{
                                id:tab_set_board_account_btn2
                                anchors.top:tab_set_board_account_label.bottom
                                anchors.topMargin:20
                                anchors.left:tab_set_board_account_btn1.right
                                anchors.leftMargin:20
                                text:"Place License File"
                                width:220
                                height:80
                                palette.buttonText:"white"
                                font.pointSize:16
                                background:Rectangle{
                                    radius:5
                                    color:"#636366"
                                    border.color:"white"
                                    border.width: tab_set_board_account_btn2.activeFocus ? 3 : 1                                    
                                }  
                            }                         
                            width:400
                            height:150
                            color:"transparent"
                        }  
                        Rectangle{ 
                            id:tab_set_board_folder
                            width:400 
                            height:150                           
                            color:"transparent"
                            Label{
                                anchors.left:parent.left
                                anchors.leftMargin:50                                
                                id:tab_set_board_folder_label
                                text:"Key Folder"
                                font.pointSize:20
                                color:"white"
                            }                            
                            Button{
                                id:tab_set_board_folder_btn1
                                anchors.top:tab_set_board_folder_label.bottom
                                anchors.topMargin:20
                                anchors.left:tab_set_board_folder_label.left                                
                                text:"Browse"
                                width:220
                                height:80                                
                                palette.buttonText:"white"
                                font.pointSize:16  
                                background:Rectangle{
                                    radius:5
                                    color:"#636366"
                                    border.color:"white"
                                    border.width: tab_set_board_folder_btn1.activeFocus ? 3 : 1                                    
                                }
                                onClicked:{
                                    keyfiledialog.visible=true
                                }                                                          
                            }
                        }                      
                    } 
                    Image{
                        id:tab_set_board_line
                        source:"images/mid_line.png"
                        anchors.top:tab_set_board_row1.bottom
                        anchors.topMargin:50
                    }
                    Row{
                        id:tab_set_board_row2
                        anchors.top:tab_set_board_line.bottom
                        anchors.topMargin:50
                        anchors.left:tab_set_board.left
                        anchors.leftMargin:50                        
                        spacing:100
                        Rectangle{
                            width:400
                            height:150
                            color:"transparent"
                            id:tab_set_board_link
                            Label{
                                anchors.left:parent.left
                                anchors.leftMargin:50                                
                                id:tab_set_board_link_label
                                text:"Links"
                                font.pointSize:20
                                color:"white"
                            }
                            Button{
                                id:tab_set_board_link_btn1
                                anchors.top:tab_set_board_link_label.bottom
                                anchors.topMargin:20
                                anchors.left:tab_set_board_link_label.left                                
                                text:qsTr("Terms && conditions")
                                width:220
                                height:80                                
                                palette.buttonText:"white"
                                font.pointSize:16  
                                background:Rectangle{
                                    radius:5
                                    color:"#292929"
                                    border.color:"white"
                                    border.width: tab_set_board_link_btn1.activeFocus ? 3 : 1                                    
                                }                              
                            }
                            Button{
                                id:tab_set_board_link_btn2
                                anchors.top:tab_set_board_link_label.bottom
                                anchors.topMargin:20
                                anchors.left:tab_set_board_link_btn1.right
                                anchors.leftMargin:20
                                text:"Privacy Policy"
                                width:220
                                height:80
                                palette.buttonText:"white"
                                font.pointSize:16
                                background:Rectangle{
                                    radius:5
                                    color:"#292929"
                                    border.color:"white"
                                    border.width: tab_set_board_link_btn2.activeFocus ? 3 : 1                                    
                                } 
                            }
                        }
                        Rectangle{
                            width:400
                            height:150
                            color:"transparent"
                            id:tab_set_board_emergency                            
                            Label{
                                anchors.left:parent.left
                                anchors.leftMargin:50                                
                                id:tab_set_board_emergency_label
                                text:"Emergency"
                                font.pointSize:20
                                color:"white"
                            }
                            Button{
                                id:tab_set_board_emergency_btn1
                                anchors.top:tab_set_board_emergency_label.bottom
                                anchors.topMargin:20
                                anchors.left:tab_set_board_emergency_label.left                                
                                text:"Emergency Button"
                                width:220
                                height:80                                
                                palette.buttonText:"#ffd60a"
                                font.pointSize:16  
                                background:Rectangle{
                                    radius:5
                                    color:"#292929"
                                    border.color:"white"
                                    border.width: tab_set_board_emergency_btn1.activeFocus ? 3 : 1                                    
                                }                              
                            }
                        }
                    }                         
                }
                Rectangle{
                    id:tab_key_board  
                    visible:myItem.isClicked4?true:false                                  
                    width:Window.width-rect_left.width-100
                    height:500
                    color:"#3a3a3c"
                    anchors.top:right_top.bottom
                    anchors.topMargin:100
                    radius:50
                    Label{
                        id:tab_key_board_create_label
                        text:"Create Key"
                        anchors.top:parent.top
                        anchors.topMargin:50
                        anchors.left:parent.left
                        anchors.leftMargin:50
                        font.pointSize:24
                        color:"white"
                    } 
                    Row{
                        id:tab_key_board_create_row
                        anchors.top:tab_key_board_create_label.bottom
                        anchors.topMargin:30
                        anchors.left:tab_key_board_create_label.left
                        spacing:50
                        Button{
                            id:tab_key_board_create_key_btn
                            width:210
                            height:75
                            font.pointSize:14
                            text:"<font color='black'>Create a Key pair</font>"
                            palette.button:"#ffd60a"
                            background:Rectangle{
                                    radius:5
                                    color:"#ffd60a"
                                    border.color:"#a48ce1"
                                    border.width: tab_key_board_create_key_btn.activeFocus ? 3 : 1                                    
                            }
                            onClicked:{
                                if(input_keyname.length==0){
                                    myItem.warningtxt="Please input KeyName!"
                                    dialog_warning.visible=true
                                }
                                else if(myItem.keyfolder==""){
                                    myItem.warningtxt="Please select Folder!"
                                    dialog_warning.visible=true
                                }
                                else{
                                    myItem.keyfilename=myItem.keyfolder+"/"+input_keyname.text
                                    myItem.warningtxt=rsa.genkeypair(512,myItem.keyfilename,"123")
                                    dialog_warning.visible=true
                                }                                
                            }
                        }
                        Button{
                            id:tab_key_board_create_save_btn
                            width:270
                            height:75
                            font.pointSize:14
                            text:"<font color='white'>Select save folder</font>"
                            palette.button:"#636366"
                            background:Rectangle{
                                    radius:5
                                    color:"#636366"
                                    border.color:"white"
                                    border.width: tab_key_board_create_save_btn.activeFocus ? 3 : 1                                    
                            }
                            onClicked:{
                                folderdialog.visible=true                                
                            }
                        }                        
                        TextField{
                            id:"input_keyname"
                            width:200
                            height:75                            
                            placeholderText:"Key Name" 
                            placeholderTextColor:"white"                              
                            font.pointSize:14
                            color:"white"
                            background: Rectangle {                                                                    
                                color:"#292929"
                                radius:10
                            }
                        }
                    }
                    Image{
                        id:tab_key_board_line
                        source:"images/mid_line.png"
                        anchors.top:tab_key_board_create_row.bottom
                        anchors.topMargin:30                        
                    }
                    Column{
                        anchors.top:tab_key_board_line.bottom
                        anchors.topMargin:40
                        anchors.left:tab_key_board_create_row.left
                        spacing:30
                        Label{                            
                            text:"Options"
                            color:"white"
                            font.pointSize:24
                        }
                        RadioButton{
                            checked:true
                            text:"<font color='white'>Use 448 AES Asymnedie bit</font>"
                            font.pointSize:16                                                        
                        }
                        RadioButton{
                            text:"<font color='white'>Use 448 RSA bit</font>"
                            font.pointSize:16                                                    
                        }                                               
                    }
                }               
            }          
        }
    }
}