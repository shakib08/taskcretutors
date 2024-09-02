import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ShowData(),
    );
  }
}

class ShowData extends StatelessWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return UserStream(user: user);
    } else {
      return Text('User not logged in');
    }
  }
}

class UserStream extends StatelessWidget {
  final User user;

  const UserStream({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('No data found for the user.');
        }

       
        var userData = snapshot.data!.data() as Map<String, dynamic>?; 

        return SafeArea(
          child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  
                  children: [
                   
                SizedBox(height: size.height*0.06,), 
                Text("Profile Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06),),
                Text('Name: ${userData!['name']}', style: TextStyle(fontSize: size.width*0.04)),
                Text('Location: ${userData!['location']}', style: TextStyle(fontSize: size.width*0.04)),
                Text('Contact Number: ${userData!['phone']}', style: TextStyle(fontSize: size.width*0.04)),
                Text('Email: ${userData!['email']}', style: TextStyle(fontSize: size.width*0.04)),
                // Add more fields as needed
              ],
            ),
          ),
        );
      },
    );
  }
}