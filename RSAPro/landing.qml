import QtQuick.Window 2.2
import QtQuick 2.3
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.0
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.15

 
ApplicationWindow{
    visible:true    
    id:root    
    color:"#292929"
    x:0
    y:0  
    Component.onCompleted: {
        root.showMaximized()
		//root.showFullScreen()
    }  
    Row{
        id: row1
        Image{                
            id: image1
            width:126
            height:64                
            source: "images/Privacy Machine_.png"
            opacity: 1     
            y:50  
            x: Window.width/30
        }                                 
        Image{                
            id: image2            
            width:48
            height:48                
            source: "images/btn_close.png"           
            y: 50 
            x:Window.width/15*14
            signal clicked
            //Mouse area to react on click events
            MouseArea {
                anchors.fill: image2
                onClicked: { 
                    root.close()
                    rsa.exit_pro()                                        
                }
            }
        }
    } 
    Image{
            id: image3
            width:260
            height:300                
            source: "images/img_landing.png"
            opacity: 1     
            anchors.top:row1.bottom
            anchors.topMargin:50
            x: Window.width/2-image3.width/2
    }     
    Image{
            id: image4
            width:420
            height:60                
            source: "images/Privacy Machine.png"
            opacity: 1     
            anchors.top:image3.bottom
            anchors.topMargin:40
            x: Window.width/2-image4.width/2
    }     
    Rectangle{
        id: rect1
        width: 200
        height:30    
        color:"transparent"    
        anchors.top:image4.bottom
        anchors.topMargin: 30
        x: Window.width/2-rect1.width/2
        CheckBox{
            id:"checkbox1"
            text:'<font color="white" size="5">I Accept <u>Terms & conditions</u></font>'
        }        
    }       
    Rectangle{
        id: rect2
        width: 200
        height:30        
        anchors.top:rect1.bottom
        anchors.topMargin: 5
        color:"transparent"
        x: Window.width/2-rect2.width/2        
        CheckBox{
            id:"checkbox2"
            text:'<font color="white" size="5">I Accept <u>Privacy policy</u></font>'            
        }
    } 
    Button{
        id:"button1"
        width:293
        height:74      
        palette {
            button: "#FFD60A"
        }  
        text:'<font color="black" size="6">View tutoarial video</font>'
        anchors.top:rect2.bottom
        anchors.topMargin: 20
        x: Window.width/2-button1.width/2        
        onClicked: {            
            var component = Qt.createComponent("main.qml")
            var window    = component.createObject(root)            
            root.visible=false
            window.show()                        
            window.showMaximized()
			//window.showFullScreen()
        }
    }      
}
