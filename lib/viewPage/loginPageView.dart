import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nxltechmachinetest/ControllerPage/authprovider.dart';
import 'package:nxltechmachinetest/viewPage/registrationPage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool viewPassword = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final size = MediaQuery.of(context).size;

    final cardWidth = size.width > 600 ? 420.0 : size.width * 0.9;
    final verticalSpace = size.height * 0.02;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/download.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.05,
            ),
            child: Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: cardWidth,
                padding: EdgeInsets.all(size.width * 0.06),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: size.width * 0.15,
                        color: Colors.red,
                      ),

                      SizedBox(height: verticalSpace),

                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 238, 236, 240),
                        ),
                      ),

                      SizedBox(height: verticalSpace * 1.5),

                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.indigo),
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.indigo),

                          prefixIcon: const Icon(Icons.email_outlined),
                          prefixIconColor: Colors.indigo,

                          filled: true,
                          fillColor: Colors.white,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email required";
                          }
                          if (!value.contains('@')) {
                            return "Invalid email";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: verticalSpace),

                      TextFormField(
                        controller: passController,
                        obscureText: viewPassword,
                        style: const TextStyle(color: Colors.indigo),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.indigo),

                          prefixIcon: const Icon(Icons.lock_outline),
                          prefixIconColor: Colors.indigo,

                          suffixIcon: IconButton(
                            icon: Icon(
                              viewPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.indigo,
                            ),
                            onPressed: () {
                              setState(() {
                                viewPassword = !viewPassword;
                              });
                            },
                          ),

                          filled: true,
                          fillColor: Colors.white,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: verticalSpace),

                      if (auth.errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: verticalSpace),
                          child: Text(
                            auth.errorMessage!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ),

                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.065,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                         onPressed: auth.isLoading
    ? null
    : () async {
        if (_formKey.currentState!.validate()) {
          final success = await auth.login(
            emailController.text.trim(),
            passController.text.trim(),
          );

          if (success && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Logged in successfully"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );

            // OPTIONAL: Navigate to home/dashboard
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (_) => const HomePage()),
            // );
          }
        }
      },

                          child: auth.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                )
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    color: Colors.indigo,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: verticalSpace),

                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      /// REGISTER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: size.width * 0.04),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
          ),
        ),
      ),
    );
  }
}
