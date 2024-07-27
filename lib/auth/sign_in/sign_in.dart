import 'package:blog_app_firebase/global_widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
                          password = value;
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
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        showSpinner=true;
                      });
                      try{

                        final user =
                        await _auth.createUserWithEmailAndPassword(
                          email: email.toString().trim(),
                          password: password.toString().trim(),
                        );
                        if(user != null){
                          print("Success");
                          toastMessages("User Successfully Created");
                          setState(() {
                            showSpinner=false;
                          });

                        }
                      }catch(e){
                        print(e.toString());
                        toastMessages(e.toString());
                        setState(() {
                          showSpinner=false;
                        });
                      }
                    }
                  },
                  color: Colors.deepPurple)
            ],
          ),
        ),
      ),
    );
  }
  void toastMessages(messages){
    Fluttertoast.showToast(
        msg: messages,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
