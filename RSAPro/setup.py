from cx_Freeze import setup, Executable
build_options = {    
    "build_exe": "D:\\builds\\",
    "include_files": ["images/", "main.qml","landing.qml"],
}

setup(name = "SecureData" ,
      version = "1.0" ,
      description = "This Software is protected by law. Composer: Dmitrii" ,
      options={"build_exe": build_options},
      executables = [Executable(script = "main.py",base = "Win32GUI",targetName = 'SecureData.exe',icon = 'images/secure-email.ico')])