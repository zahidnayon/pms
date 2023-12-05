import 'package:flutter/material.dart';
import '../api_services/login_api.dart';
import '../components/button_style.dart';
import '../components/logo_style.dart';
import '../components/text_field.dart';
import 'unid_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  final LoginApi _loginApi = LoginApi();

  Future<void> signUserIn() async {
    final userName = userNameController.text;
    final password = passwordController.text;

    final result = await _loginApi.loginUser(userName, password);

    if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UnidScreen(),
          ),
        );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoStyle(logopath: "assets/images/Logo.png"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hello! Welcome back",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: userNameController,
                  hintText: "User ID",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),
                          Text(
                            "Remember Me",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the reset password screen when tapped
                        },
                        child: Text(
                          "Reset Password",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MyButton(
                  onTap: signUserIn,
                  buttonText: "Login",
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.grey[700]),
                            children: const [
                              TextSpan(
                                text: "By signing in, I agree to the ",
                              ),
                              TextSpan(
                                text: "Our Privacy Statement",
                                style: TextStyle(color: Colors.blue),
                              ),
                              TextSpan(
                                text: " and ",
                              ),
                              TextSpan(
                                text: "Terms of Service.",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
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
}
