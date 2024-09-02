import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/Pages/home.dart';
import 'package:task/Pages/registration.dart';
import 'package:task/widgets/CustomTextField.dart';
import 'package:task/widgets/customButton.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; 



Future<void> loginUser() async {
    setState(() {
      _isLoading = true;
    });

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
              Text("Logging in..."),
            ],
          ),
        ),
      );
    },
  );


    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();

      if (credential.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Successful")),
        ); 
        
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home()),);
        
        
      }

     

      
       else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid Email or Password!")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error logging in: ${e.toString()}")),
      );
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
                height: size.height * 0.4,
              ),
              customTextField(
                  icon: Icons.email,
                  hintText: "Email",
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
              customButton(hintText: "Login", onClick: loginUser), 
              SizedBox(height: size.height*0.02,), 
              Text("Don't have an account?"), 
              SizedBox(height: size.height*0.02,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registration())); 
                },
                child: Text("Resister"),
              )
         
            ],
          ),
        ),
      ),
    );
  }
}
