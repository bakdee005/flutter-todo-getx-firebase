import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controller/auth_controller.dart';

class SignupView extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final auth = Get.find<AuthController>();

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  /// Header text 
                  const Center(
                    child: Text('SignUp',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  /// Email Text form field 
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Email is required'
                        : value.contains("@")
                            ? null
                            : 'Please enter a valid email',
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  /// Password textform field
                  TextFormField(
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Password is required'
                        : null,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  const SizedBox(height: 20),

                  /// Signup button
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        auth.signup(email.text, password.text);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  /// Login screen navigation button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      const SizedBox(width: 8),
                      InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.login);
                          },
                          child: const Text("LogIn",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                    ],
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
