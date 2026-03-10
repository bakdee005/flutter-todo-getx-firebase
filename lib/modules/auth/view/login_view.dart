import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controller/auth_controller.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController controller = Get.put(AuthController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                  const SizedBox(height: 20),
                  /// Header text
                  const Center(
                    child: Text('Login',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Please login to continue',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Email textform field 
                  TextFormField(
                    controller: controller.emailController,
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

                  const SizedBox(height: 10),
                  /// Password textformfield 
                  Obx(() => TextFormField(
                        controller: controller.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.isPasswordHidden.value,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Password is required'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              controller.togglePassword();
                            },
                          ),
                        ),
                      )),

                  const SizedBox(height: 20),
                  
                  //// Login button
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.login(
                          controller.emailController.text,
                          controller.passwordController.text,
                        );
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
                            "LogIn",
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

                  /// Signup navigation button 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14)),
                      const SizedBox(width: 8),
                      InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.signup);
                          },
                          child: const Text("SignUp",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Center(
                      child: Text("Or",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))),

                  const SizedBox(height: 20),

                  /// google account signin button 
                  InkWell(
                    onTap: () async {
                      controller.googleLogin();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(width: 10,),
                          Icon(
                            Icons.mail,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Sign In with Google Account",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
