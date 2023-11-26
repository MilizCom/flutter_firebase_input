import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_input_data/navigation_utils.dart';

import 'dataPage.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List listData = [];
  final db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await db.collection("users").snapshots().listen((event) {
      List d = [];
      for (var doc in event.docs) {
        d.add({"id": doc.id, "data": doc.data()});
        print("${doc.id} => ${doc.data()}");
      }
      setState(() {
        listData = d;
      });
    });
  }

  void delet(String id) {
    db.collection("users").doc(id).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataPage()),
                );
              },
              child: Text("add"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  final data = listData[index]["data"];
                  final id = listData[index]["id"];
                  return Card(
                    // Your card content goes here
                    child: ListTile(
                      title: Text(data["name"]),
                      trailing: Container(
                        width: 100,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                NavigatePush(
                                  context,
                                  DataPage(
                                      name: data["name"],
                                      email: data["email"],
                                      id: id),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                delet(id);
                                getData();
                              },
                            ),
                          ],
                        ),
                      ),
                      // Add more widgets as needed for your card content
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
