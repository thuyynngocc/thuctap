import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/trangChu.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đăng Nhập Hệ Thống',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 18, 78, 128),
                  ),
                ),
                SizedBox(height: 30.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tài khoản',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 18, 78, 128),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: const Color.fromARGB(255, 18, 78, 128)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: const Color.fromARGB(255, 18, 78, 128)),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                PasswordField(), // Sử dụng widget PasswordField thay cho TextFormField
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          backgroundColor: Colors.red,
                        ),
                        icon: Icon(Icons.help, color: Colors.white),
                        label: Text(
                          'Hỗ trợ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => TrangChu()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          primary: const Color.fromARGB(255, 18, 78, 128)
                        ),
                        icon: Icon(Icons.login, color: Colors.white),
                        label: Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Mật khẩu',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 18, 78, 128),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: const Color.fromARGB(255, 18, 78, 128)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: const Color.fromARGB(255, 18, 78, 128)),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: const Color.fromARGB(255, 18, 78, 128),
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
