import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import '../utils/local_storage.dart';
import 'package:flutter_application_1/utils/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home_page.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => 
      const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isSignUp = true;
  bool _obscureText = true;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response = await http.get(
        Uri.parse("https://6a43cfa66dba791499ab71bb.mockapi.io/users?email=$email&password=$password",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          // Storage
          await saveRole();
          // Local Notification
          if (!kIsWeb) {
            await NotificationService.plugin.show(
            id: 0,
            title: 'Login Success',
            body: 'You are now logged in.',
            notificationDetails: const NotificationDetails(
              android: AndroidNotificationDetails(
                'basic_channel',
                'Basic Notifications',
                channelDescription: 'Notifications for login events',
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Success"),
            ),
          );
          // pindah halaman
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          
        } else {
          // Login gagal
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Username atau Password salah"),
            ),
          );
        }
      }
    } catch (e) {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Latar belakang 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Logo Stack
              Center(
                child: Image.asset(
                  'lib/asset/logo_stack.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),

              // Toggle Tab (Sign Up / Sign In)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF17181A),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isSignUp = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _isSignUp ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: _isSignUp ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isSignUp = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !_isSignUp ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            'Sign In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: !_isSignUp ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Input Email
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  if (_emailErrorText != null && value.isNotEmpty) {
                    setState(() => _emailErrorText = null);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'lib/asset/icon_email.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                  filled: true,
                  fillColor: const Color(0xFF17181A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              if (_emailErrorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Text(
                    _emailErrorText!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Input Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      if (_passwordErrorText != null) {
                        setState(() => _passwordErrorText = null);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'lib/asset/icon_password.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                      suffixIcon: IconButton(
                        icon: Image.asset(
                          _obscureText ? 'lib/asset/icon_eye_slash.png' : 'lib/asset/icon_eye.png',
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () => setState(() => _obscureText = !_obscureText),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF17181A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  if (_passwordErrorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Text(
                        _passwordErrorText!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const Spacer(),

              // Tombol Submit Utama (Sign Up / Sign In)
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _emailErrorText = null;
                    _passwordErrorText = null;

                    if (_emailController.text.isEmpty) {
                      _emailErrorText = 'Email is required';
                    }

                    if (_passwordController.text.isEmpty) {
                      _passwordErrorText = 'Password is required';
                    } else if (_passwordController.text.length < 8) {
                      _passwordErrorText = 'Password must be at least 8 characters';
                    }
                  });

                  if (_emailErrorText == null && _passwordErrorText == null) {
                    // Proceed with sign up/sign in logic
                    await login();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  _isSignUp ? 'Sign Up' : 'Sign In',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}