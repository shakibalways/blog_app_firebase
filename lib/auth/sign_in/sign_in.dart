import 'package:blog_app_firebase/global_widget/round_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool showSpinner = false;

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String user = "";
  String email = "";
  String pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Register",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: userController,
                      decoration: InputDecoration(
                          // hintText: "User Name",
                          labelText: "User Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (String value) {
                        user = value;
                      },
                      validator: (value) {
                        return value!.isEmpty ? "Enter User Name" : null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          // hintText: "User Name",
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (String value) {
                        email = value;
                      },
                      validator: (value) {
                        return value!.isEmpty ? "Enter Your Email" : null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                          // hintText: "User Name",
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (value) {
                        pass = value;
                      },
                      validator: (value) {
                        return value!.isEmpty ? "Enter Your Password" : null;
                      },
                    ),
                  ],
                )),
            RoundButton(
                title: "Register",
                onPress: () async {
                  if (_formKey.currentState!.validate()) {}
                },
                color: Colors.deepPurple)
          ],
        ),
      ),
    );
  }
}
