import 'package:crm_android/bloc/auth/auth.bloc.dart';
import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:crm_android/views/screens/auth/widgets/text_form_field.dart';
import 'package:crm_android/views/screens/home/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/main.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;
      context
          .read<AuthBloc>()
          .add(LoginButtonPressed(userId: username, password: password));
    }
  }

  String? _validateEmployeeId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Employee ID';
    }
    // Regex to check if the Employee ID starts with 'CNC' followed by 4 digits
    final RegExp regex = RegExp(r'^CNC\d{4}$');
    if (!regex.hasMatch(value)) {
      return 'Employee ID must start with "CNC" followed\nby 4 digits (e.g., CNC0000)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF233784), // Background color for the page
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    fit: BoxFit.cover,
                    'assets/logo/code_and_click.png', // Replace with your logo asset path
                    height: Screen.getHeight(context: context) * 0.175,
                    width: Screen.getWidth(context: context) * 0.8,
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Employee Access',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Log in to call center account',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.0),
                        TextInputField(
                          controller: _usernameController,
                          labelText: 'Employee ID',
                          prefixIcon: Icon(Icons.person),
                          validator: _validateEmployeeId,
                        ),
                        SizedBox(height: 16.0),
                        TextInputField(
                          controller: _passwordController,
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.0),
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) async {
                            if (state is AuthFailure) {
                              Fluttertoast.showToast(
                                msg: state.error,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                            } else if (state is AuthSuccess) {
                              // Save login status
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isLoggedIn', true);

                              Fluttertoast.showToast(
                                msg: 'Login Successful!',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              );

                              // Navigate to the Home Page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            }
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: state is AuthLoading
                                    ? Shimmer.fromColors(
                                        key: ValueKey('shimmer'),
                                        baseColor: Colors.blue[300]!,
                                        highlightColor: Colors.blue[100]!,
                                        child: SizedBox(
                                          width: double
                                              .infinity, // Set width to fill available space
                                          child: ElevatedButton(
                                            onPressed: null,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                            ),
                                            child: Text(
                                              'Signing...',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: double
                                            .infinity, // Set width to fill available space
                                        child: ElevatedButton(
                                          key: ValueKey('login'),
                                          onPressed: () =>
                                              _onLoginButtonPressed(context),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF3B82F6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                          ),
                                          child: Text(
                                            'Sign In',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Handle support contact action
                            },
                            child: Text(
                              'Need help? Contact support.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
