from PyQt5.QtCore import QObject
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
from PyQt5.QtGui import QIcon
from PyQt5.QtCore import QObject, pyqtSlot
import PyQt5.QtQml as QtQml
import sys
import rsa
import pyperclip
import base64
 
class RSAClass(QObject):    
    @pyqtSlot(int,str,str,result=str)
    def genkeypair(self, size,name,url):
        try:
            (pubkey, privkey) = rsa.newkeys(size)
            keydata_priv=rsa.PrivateKey.save_pkcs1(privkey)
            keydata_pub=rsa.PublicKey.save_pkcs1(pubkey)
            name=name.replace("file:///","")
            with open(name+'_private.pem', mode='wb') as privatefile:
                privatefile.write(keydata_priv)
            with open(name+'_public.pem', mode='wb') as publicfile:
                publicfile.write(keydata_pub)
            return "Created success!"
        except:
            return "Created Failed!"+str(sys.exc_info()[0])+str(sys.exc_info()[1])
    @pyqtSlot(str,result=str)
    def loadprivkey(self,name):        
        try:
            name=name.replace("file:///","")
            print(name)
            with open(name, mode='rb') as privatefile:
                keydata = privatefile.read()
            self.privkey = rsa.PrivateKey.load_pkcs1(keydata)        
            return "Load Success!"
        except:
            return "Failed! Key File doesn't exist."
        
    @pyqtSlot(str,result=str)
    def loadpubkey(self,name):
        try:
            name=name.replace("file:///","")
            with open(name, mode='rb') as publicfile:
                keydata = publicfile.read()
            self.pubkey = rsa.PublicKey.load_pkcs1(keydata)
            return "Load Success!"
        except:
            return "Failed! Key File doesn't exist."

    @pyqtSlot(str,result=bool)
    def encrypt(self,plain) :
        try:    
            crypt=""                
            for i in range(0, len(plain),53):
                message=plain[i:i+53].encode('utf8')                
                crypt_tmp=rsa.encrypt(message, self.pubkey) 
                crypt64=base64.b64encode(crypt_tmp)
                crypt=crypt+crypt64.decode('utf8')
            pyperclip.copy(str(crypt))
            return True
        except:
            print(sys.exc_info()[0])
            print(sys.exc_info()[1])
            return False
    @pyqtSlot(str,result=bool)
    def decrypt(self,crypt): 
        try:              
            plain=""
            for i in range(0,len(crypt),88):
                message=crypt[i:i+88].encode('utf8')
                crypttext=base64.b64decode(message) 
                tmp=rsa.decrypt(crypttext,self.privkey)               
                plain_tmp=tmp.decode('utf8')
                plain=plain+plain_tmp            
            pyperclip.copy(plain)
            return True
        except:
            print(sys.exc_info()[0])
            print(sys.exc_info()[1])
            return False
    @pyqtSlot()
    def exit_pro(self):
        sys.exit()



        
QtQml.qmlRegisterType(RSAClass, "RSALibrary", 1, 0, "RSAClass")
def runQML():    
    app =QApplication(sys.argv)
    engine = QQmlApplicationEngine()    
    app.setWindowIcon(QIcon("icon.png"))
    engine.load('landing.qml')
    
 
    if not engine.rootObjects():
        return -1
 
    return app.exec_()
 
 
 
 
if __name__ == "__main__":
    sys.exit(runQML())