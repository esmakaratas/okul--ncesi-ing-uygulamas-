import 'package:flutter/material.dart';
import 'package:flutter_application_4/categoryScreen.dart';
import 'database_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper();
  bool showLoginFields = true;
  String backgroundImage = 'assets/images/loginscreen.png';
  String selectedScreen = 'login'; // 'login' veya 'register' olabilir

  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                screenWidth * 0.1, screenHeight * 0.51, screenWidth * 0.1, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showLoginFields = true;
                          selectedScreen = 'login';
                          backgroundImage = 'assets/images/loginscreen.png';
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Text(
                          'Giriş Yap',
                          style: TextStyle(
                            color: selectedScreen == 'login'
                                ? Colors.white
                                : Colors.black,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showLoginFields = true;
                          selectedScreen = 'register';
                          backgroundImage = 'assets/images/registerscreen.png';
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Text(
                          'Kayıt Ol',
                          style: TextStyle(
                            color: selectedScreen == 'register'
                                ? Colors.white
                                : Colors.black,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Visibility(
                  visible: showLoginFields,
                  child: Column(
                    children: [
                      if (selectedScreen == 'register') ...[
                        Container(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.06,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'İsim',
                              filled: true,
                              fillColor: Color(0xFFe4e4e2).withOpacity(0.6),
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.06,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Mail',
                              filled: true,
                              fillColor: Color(0xFFe4e4e2).withOpacity(0.6),
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                      ],
                      Container(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.06,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Kullanıcı Adı',
                            filled: true,
                            fillColor: Color(0xFFe4e4e2).withOpacity(0.6),
                            prefixIcon:
                                Icon(Icons.account_circle, color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Container(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.06,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Şifre',
                            filled: true,
                            fillColor: Color(0xFFe4e4e2).withOpacity(0.6),
                            prefixIcon: Icon(Icons.lock, color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.07,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedScreen == 'login') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF58a4d4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            selectedScreen == 'login'
                                ? 'Giriş Yap'
                                : 'Kayıt Ol',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.045,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(double screenWidth) {
    return Column(
      key: ValueKey('login'),
      children: [
        _buildTextField(usernameController, 'Kullanıcı Adı',
            Icons.account_circle, screenWidth),
        SizedBox(height: screenWidth * 0.03),
        _buildTextField(passwordController, 'Şifre', Icons.lock, screenWidth,
            obscureText: true),
        SizedBox(height: screenWidth * 0.04),
        _buildSubmitButton('Giriş Yap', _login, screenWidth),
      ],
    );
  }

  Widget _buildRegisterForm(double screenWidth) {
    return Column(
      key: ValueKey('register'),
      children: [
        _buildTextField(nameController, 'Ad', Icons.person, screenWidth),
        SizedBox(height: screenWidth * 0.02),
        _buildTextField(emailController, 'Email', Icons.email, screenWidth),
        SizedBox(height: screenWidth * 0.02),
        _buildTextField(usernameController, 'Kullanıcı Adı',
            Icons.account_circle, screenWidth),
        SizedBox(height: screenWidth * 0.02),
        _buildTextField(passwordController, 'Şifre', Icons.lock, screenWidth,
            obscureText: true),
        SizedBox(height: screenWidth * 0.03),
        _buildSubmitButton('Kayıt Ol', _register, screenWidth),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      IconData icon, double screenWidth,
      {bool obscureText = false}) {
    return Container(
      width: screenWidth * 0.6,
      height: screenWidth * 0.13,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, size: screenWidth * 0.06),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
          ),
          obscureText: obscureText,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
      String text, VoidCallback onPressed, double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 214, 214, 214),
          foregroundColor: Color.fromARGB(255, 20, 52, 148),
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          shadowColor: Colors.black,
          elevation: 4,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
      ),
    );
  }

  void _login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    var user = await dbHelper.getUser(username, password);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarılı!')),
      );
      Navigator.pushNamed(
        context,
        '/category',
        arguments: {
          'name': user['name'],
          'selectedAvatarIndex': user['avatarIndex'] ?? 0,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Giriş başarısız! Kullanıcı adı veya şifre yanlış.'),
        ),
      );
    }
  }

  void _register() async {
    String name = nameController.text;
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    try {
      int id = await dbHelper.insertUser({
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'avatarIndex': 0,
      });

      if (id > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt başarılı!')),
        );
        Navigator.pushNamed(
          context,
          '/category',
          arguments: {
            'name': name,
            'selectedAvatarIndex': 0,
          },
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt başarısız: $e')),
      );
    }
  }
}
