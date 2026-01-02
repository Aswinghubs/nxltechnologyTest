import 'package:flutter/material.dart';
import 'package:nxltechmachinetest/ControllerPage/authprovider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.05,
              vertical: h * 0.02,
            ),
            child: Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.04),
              ),
              child: Padding(
                padding: EdgeInsets.all(w * 0.06),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.person_add,
                        size: w * 0.15,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(height: h * 0.015),
                      Text(
                        "Create Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: w * 0.055,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: h * 0.03),

                      /// NAME
                      _buildField(
                        controller: nameController,
                        hint: "Name",
                        icon: Icons.person,
                        w: w,
                        validator: (v) =>
                            v!.isEmpty ? "Name required" : null,
                      ),
                      SizedBox(height: h * 0.02),

                      /// EMAIL
                      _buildField(
                        controller: emailController,
                        hint: "Email",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        w: w,
                        validator: (v) {
                          if (v == null || !v.contains('@')) {
                            return "Invalid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: h * 0.02),

                      _buildField(
                        controller: passController,
                        hint: "Password",
                        icon: Icons.lock_outline,
                        obscure: _obscurePassword,
                        w: w,
                        suffix: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.indigo,
                            size: w * 0.06,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (v) =>
                            v!.length < 6 ? "Min 6 characters" : null,
                      ),
                      SizedBox(height: h * 0.02),

                      _buildField(
                        controller: confirmController,
                        hint: "Confirm Password",
                        icon: Icons.lock_outline,
                        obscure: _obscureConfirm,
                        w: w,
                        suffix: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.indigo,
                            size: w * 0.06,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirm = !_obscureConfirm;
                            });
                          },
                        ),
                        validator: (v) {
                          if (v != passController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: h * 0.03),

                      if (auth.errorMessage != null)
                        Text(
                          auth.errorMessage!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: w * 0.035,
                          ),
                        ),
                      SizedBox(height: h * 0.02),

                      SizedBox(
                        height: h * 0.065,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(w * 0.035),
                            ),
                          ),
                        onPressed: auth.isLoading
    ? null
    : () async {
        if (_formKey.currentState!.validate()) {
          final success = await auth.register(
            emailController.text.trim(),
            passController.text.trim(),
          );

          if (success && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Registered successfully"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );

            // Optional: Navigate back to login after delay
            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) Navigator.pop(context);
            });
          }
        }
      },

                          child: auth.isLoading
                              ? SizedBox(
                                  height: w * 0.06,
                                  width: w * 0.06,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: w * 0.045,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: h * 0.015),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Back to Login",
                          style: TextStyle(
                            fontSize: w * 0.04,
                            color: Colors.white,
                          ),
                        ),
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

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required double w,
    bool obscure = false,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Colors.indigo,
        fontSize: w * 0.04,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.indigo,
          fontSize: w * 0.04,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          icon,
          color: Colors.indigo,
          size: w * 0.06,
        ),
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.035),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: w * 0.045,
          horizontal: w * 0.035,
        ),
      ),
      validator: validator,
    );
  }
}
