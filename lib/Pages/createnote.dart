import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> _createNote() async {
    final String title = titleController.text.trim();
    final String description = descriptionController.text.trim();
    
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both fields')),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user logged in')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('notes').add({
        'title': title,
        'description': description,
        'userId': user.uid, // Store the user ID
        'timestamp': DateTime.now(), // Optional: Store the creation time
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note created successfully')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create note: $e')),
      );
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          customTextField(
              icon: Icons.title,
              hintText: "Title",
              controller: titleController,
              inputType: TextInputType.text), 

          SizedBox(height: size.height*0.02,), 

          customTextField(
              icon: Icons.description,
              hintText: "Description",
              controller: descriptionController,
              inputType: TextInputType.text),

          SizedBox(height: size.height*0.02,), 
          customButton(hintText: "Create", onClick: _createNote)      
        ],
      ),
    );
  }
}
