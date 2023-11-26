import 'dart:async';

import 'package:firebase_utilitas/firebase_utilitas.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataPage extends StatefulWidget {
  final String? name, email, id;
  DataPage({Key? key, this.name, this.email, this.id});
  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final fs = FirebaseUtilitas();
  final db = FirebaseFirestore.instance;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  bool isedit = false;

  @override
  void initState() {
    super.initState();
    if (widget.name != null && widget.email != null) {
      name.text = widget.name!;
      email.text = widget.email!;
      setState(() {
        isedit = true;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: Center(
        child: Column(
          children: [
            InputWidget(
              control: name,
              label: "Name",
            ),
            InputWidget(
              control: email,
              label: "Email",
            ),
            ElevatedButton(
              onPressed: () {
                addDataToFirestore();
              },
              child: Text(isedit ? "Edit" : "add"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addDataToFirestore() async {
    String nameValue = name.text;
    String emailValue = email.text;

    if (nameValue.isNotEmpty && emailValue.isNotEmpty) {
      if (isedit) {
        await fs.addDataCollection(
            "users", {"name": name.text, "email": email.text});
      } else {
        db.collection("users").add({
          "name": nameValue,
          "email": emailValue,
        }).then((DocumentReference doc) {
          print('DocumentSnapshot added with ID: ${doc.id}');
          // Optionally, you can navigate back to the previous screen or perform other actions
        }).catchError((error) {
          print("Error adding document: $error");
          // Handle the error, e.g., show a snackbar or an error message
        });
      }
    } else {
      print("Name and email cannot be empty");
      // Optionally, you can show a snackbar or an error message
    }
  }
}

class InputWidget extends StatelessWidget {
  final TextEditingController control;
  final String label;

  const InputWidget({
    required this.control,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: control,
      decoration: InputDecoration(hintText: label),
    );
  }
}
