import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task/Pages/createnote.dart';
import 'package:task/Pages/login.dart';
import 'package:task/Pages/profile.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "CareTutors",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: const NavigationDrawer(),
        body: notes(),
      ),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  User? user = FirebaseAuth.instance.currentUser;
  String userName = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                var userData = snapshot.data!.data()
                    as Map<String, dynamic>?; // Explicit cast

                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 40,
                    ),
                    Text(
                      '${userData?['name'] ?? "Name not available"}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.05),
                    )
                  ],
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to Home page
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Navigate to Profile page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => profile()));
              // Implement navigation to profile page here
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              // Implement logout functionality here
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class notes extends StatefulWidget {
  const notes({super.key});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('notes').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No notes found.');
                }

                final notes = snapshot.data!.docs;

                return Column(
                  children: notes.map((doc) {
                    var noteData = doc.data() as Map<String, dynamic>;
                    return Container(
                       width: size.width * 0.9, // Set the width of the card to 80% of the screen width
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Card(
                      
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                noteData['title'] ?? 'No Title',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                noteData['description'] ?? 'No Description',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>createnote()));// Define your onPressed action here
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(
                    20), // Adjust the padding for the desired size
                elevation: 5, // Adjust the elevation for shadow effect
                backgroundColor: Colors.black
              ),
              child: Icon(
                Icons.add, // "+" sign
                color: Colors.white, // Icon color
                size: 24, // Icon size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
