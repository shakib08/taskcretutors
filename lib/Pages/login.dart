import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/Pages/registration.dart';
import 'package:task/widgets/CustomTextField.dart';
import 'package:task/widgets/customButton.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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
                  controller: TextEditingController(),
                  inputType: TextInputType.text),
              SizedBox(
                height: size.height * 0.02,
              ),
              customTextField(
                  icon: Icons.lock,
                  hintText: "Password",
                  controller: TextEditingController(),
                  inputType: TextInputType.visiblePassword),
              SizedBox(
                height: size.height * 0.02,
              ),
              customButton(hintText: "Login", onClick: (){}), 
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
