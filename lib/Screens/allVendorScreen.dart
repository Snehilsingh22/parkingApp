import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Utils/colors.dart';

class VendorScreen extends StatefulWidget {
  final String uid;
  VendorScreen(this.uid);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    AuthProvider ap = AuthProvider();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: const AutoSizeText('Vendors',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                letterSpacing: 1)),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('users')
              .doc(widget.uid)
              .collection('vendors')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: Colors.black,
                ),
              );
            }

            final documents = snapshot.data!.docs;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
                indent: 40,
                endIndent: 40,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                final name = document['name'];
                // final email = document['email'];
                final mobileNo = document['mobileNo'];

                // final imageUrl = imageMap[vehicleName] ?? '';

                return ListTile(
                  leading: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/admin.gif",
                      scale: 3,
                    ),
                    // child:
                  ),
                  title: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Name : ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16)),
                    TextSpan(
                        text: name,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7))
                  ])),
                  // subtitle: Text('Amount : $vehicleAmount'),
                  subtitle: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Mobile No : ",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        )),
                    TextSpan(
                        text: mobileNo,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7))
                  ])),
                  trailing: IconButton(
                    color: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        // ignore: avoid_types_as_parameter_names
                        builder: (BuildContext) {
                          return Dialog(
                              // backgroundColor: Colors.amber.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      50.0)), //this right here
                              child: SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        "Are you sure you want to delete this?",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor),
                                            child: const Text("Cancel",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              firestore
                                                  .collection('users')
                                                  .doc(widget.uid)
                                                  .collection('vendors')
                                                  .doc(document
                                                      .id) // document.id represents the document ID
                                                  .delete()
                                                  .then((_) {
                                                Fluttertoast.showToast(
                                                  msg: "Deleted Successfully",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 2,
                                                  backgroundColor: primaryColor,
                                                  textColor: Colors.black,
                                                  fontSize: 16.0,
                                                );
                                              }).catchError((error) {
                                                print(
                                                    'Error deleting document: $error');
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
