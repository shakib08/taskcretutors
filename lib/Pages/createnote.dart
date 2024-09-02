import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task/widgets/CustomTextField.dart';
import 'package:task/widgets/customButton.dart';

class createnote extends StatefulWidget {
  const createnote({super.key});

  @override
  State<createnote> createState() => _createnoteState();
}

class _createnoteState extends State<createnote> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Note",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: responsiveView(),
    ));
  }
}

class responsiveView extends StatefulWidget {
  const responsiveView({super.key});

  @override
  State<responsiveView> createState() => _responsiveViewState();
}

class _responsiveViewState extends State<responsiveView> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          customTextField(
              icon: Icons.title,
              hintText: "Title",
              controller: title,
              inputType: TextInputType.text), 

          SizedBox(height: size.height*0.02,), 

          customTextField(
              icon: Icons.description,
              hintText: "Description",
              controller: description,
              inputType: TextInputType.text),

          SizedBox(height: size.height*0.02,), 
          customButton(hintText: "Create", onClick: (){})      
        ],
      ),
    );
  }
}
