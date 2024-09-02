import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/Pages/login.dart';
import 'package:task/widgets/CustomTextField.dart';
import 'package:task/widgets/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> registerUser() async {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final phoneRegExp = RegExp(r'^01[3-9]\d{8}$');
    if (name.text.isEmpty ||
        location.text.isEmpty ||
        phone.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill up all the information")));
      return;
    }

    if (!emailRegExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid email address")));
      return;
    }

    if (!phoneRegExp.hasMatch(phone.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid phone number")));
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Registering..."),
              ],
            ),
          ),
        );
      },
    );

    try {

      var emailQuery = await FirebaseFirestore.instance.collection('users')
          .where('email', isEqualTo: email.text).get();
      if (emailQuery.docs.isNotEmpty) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("This email already exists")));
        return;
      }


      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'name': name.text,
        'location': location.text,
        'phone': phone.text,
        'email': email.text,
        'password': password.text,
        'timestamp': DateTime.now(),
      });

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User Registered Successfully")));

      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => login())));
    } catch (e) {
       Navigator.of(context).pop();
      print('Error registering user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error registering user: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.3,
              ),
              customTextField(
                  icon: Icons.person,
                  hintText: "Name",
                  controller: name,
                  inputType: TextInputType.text),
              SizedBox(
                height: size.height * 0.02,
              ),
              customTextField(
                  icon: Icons.location_city,
                  hintText: "Location",
                  controller: location,
                  inputType: TextInputType.text),
              SizedBox(
                height: size.height * 0.02,
              ),
              customTextField(
                  icon: Icons.phone,
                  hintText: "Contact Number",
                  controller: phone,
                  inputType: TextInputType.number),
              SizedBox(
                height: size.height * 0.02,
              ),
              customTextField(
                  icon: Icons.email,
                  hintText: "Email Address",
                  controller: email,
                  inputType: TextInputType.text),
              SizedBox(
                height: size.height * 0.02,
              ),
              customTextField(
                  icon: Icons.lock,
                  hintText: "Password",
                  controller: password,
                  inputType: TextInputType.visiblePassword),
              SizedBox(
                height: size.height * 0.02,
              ),
              customButton(hintText: "Register", onClick: registerUser),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text("Already have an account?"),
              SizedBox(
                height: size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
                child: Text("Sign in"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
