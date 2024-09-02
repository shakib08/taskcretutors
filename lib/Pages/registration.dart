import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/Pages/login.dart';
import 'package:task/widgets/CustomTextField.dart';
import 'package:task/widgets/customButton.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height*0.3,), 
              customTextField(
                  icon: Icons.person,
                  hintText: "Name",
                  controller: TextEditingController(),
                  inputType: TextInputType.text),
              SizedBox(
                height: size.height * 0.02,
              ),
              customTextField(
                  icon: Icons.location_city,
                  hintText: "Location",
                  controller: TextEditingController(),
                  inputType: TextInputType.text),
              SizedBox(height: size.height*0.02,), 
              customTextField(
                  icon: Icons.phone,
                  hintText: "Contact Number",
                  controller: TextEditingController(),
                  inputType: TextInputType.number),
              SizedBox(height: size.height*0.02,),
              customTextField(
                  icon: Icons.email,
                  hintText: "Email Address",
                  controller: TextEditingController(),
                  inputType: TextInputType.text),  
              SizedBox(height: size.height*0.02,),
              customTextField(
                  icon: Icons.lock,
                  hintText: "Password",
                  controller: TextEditingController(),
                  inputType: TextInputType.visiblePassword),    
              SizedBox(height: size.height*0.02,),
              customButton(hintText: "Register", onClick: (){}),
              SizedBox(height: size.height*0.02,), 
              Text("Already have an account?"), 
              SizedBox(height: size.height*0.02,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login())); 
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
