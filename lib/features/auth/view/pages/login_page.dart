import 'package:depi_five/core/const/image_paths.dart';
import 'package:depi_five/core/widgets/primary_btn.dart';
import 'package:depi_five/features/auth/view/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  ///Responsive Design
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height * .1, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "${rootImagePath}login_logo.png",
                height: 120,
                width: 120,
              ),
              SizedBox(height: height * .1),
              CustomTextfield(text: "Phone Number"),
              SizedBox(height: height * .03),
              CustomTextfield(text: "Password", isPassword: true),
              Row(
                mainAxisAlignment: .end,
                children: [Text("Forget Password?")],
              ),
              SizedBox(height: height * .03),
              PrimaryBtn.greenBtn("Login"),
              SizedBox(height: height * .03),
              Row(
                spacing: 14,
                children: [
                  socialBtn("Google", Colors.red, "google_sign_in.png"),
                  socialBtn("Apple", Colors.black, "apple_sign_in.png"),
                ],
              ),
              SizedBox(height: height * .08),

              Row(
                mainAxisAlignment: .center,
                children: [
                  Text("Don't Have an Account?"),
                  Text("  Sign Up", style: TextStyle(color: Colors.green)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialBtn(String text, Color color, String image) {
    return Container(
      height: 56,
      width: 174,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Image.asset("$rootImagePath$image", height: 30, width: 30),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
