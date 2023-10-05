import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Utils/colors.dart';

class PriceScreen extends StatelessWidget {
  final String uid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  PriceScreen(this.uid);
  final Map<String, String> imageMap = {
    "Full Size Pickup": "assets/Vehicle/one.png",
    "Mini Pickup": "assets/Vehicle/2.png",
    "Mini Van": "assets/Vehicle/3.png",
    "SUV": "assets/Vehicle/4.png",
    "Utility Van": "assets/Vehicle/5.png",
    "Crew Pickup": "assets/Vehicle/6.png",
    // "Full Size Pickup": "assets/Vehicle/one.png",
    "Mini Bus": "assets/Vehicle/8.png",
    "Van": "assets/Vehicle/9.png",
    "Step Van": "assets/Vehicle/10.png",
    // "Utility Van": "assets/Vehicle/one.png",
    "City Delivery": "assets/Vehicle/12.png",
    // "Mini Bus": "assets/Vehicle/one.png",
    "Walk In": "assets/Vehicle/14.png",
    // "City Delivery": "assets/Vehicle/one.png",
    "Conventional Van": "assets/Vehicle/16.png",
    "Lanscape Utility": "assets/Vehicle/17.png",
    "Large walk In": "assets/Vehicle/19.png",
    "Bucket": "assets/Vehicle/20.png",
    // "City Delivery": "assets/Vehicle/one.png",
    "Large Walk In": "assets/Vehicle/21.png",
    "Bevrage": "assets/Vehicle/22.png",
    "Rack": "assets/Vehicle/23.png",
    "School Bus": "assets/Vehicle/24.png",
    "Single Axle Van": "assets/Vehicle/25.png",
    "Stake Body": "assets/Vehicle/26.png",
    "City Transit Bus": "assets/Vehicle/27.png",
    "Furniture": "assets/Vehicle/28.png",
    "High Profile Semi": "assets/Vehicle/29.png",
    "Home fuel": "assets/Vehicle/30.png",
    "Medium Semi Tractor": "assets/Vehicle/31.png",
    "Refuse": "assets/Vehicle/32.png",
    "Tow": "assets/Vehicle/33.png",
    "Cement Mixer": "assets/Vehicle/35.png",
    "Dump": "assets/Vehicle/36.png",
    "Fire Truck": "assets/Vehicle/37.png",
    "Fuel": "assets/Vehicle/38.png",
    "Heavy Semi Tractor": "assets/Vehicle/39.png",
    "Refrigerated Van": "assets/Vehicle/40.png",
    "Semi sleeper": "assets/Vehicle/41.png",
    "Tour Bus": "assets/Vehicle/42.png",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        title: const Text(
          'Vehicle Pricing',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('users')
              .doc(uid)
              .collection('vehicles')
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
                final vehicleName = document['name'];
                final vehicleAmount = document['amount'];
                final imageUrl = imageMap[vehicleName] ?? '';

                return ListTile(
                  leading: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      imageUrl,
                      scale: 3.1,
                    ),
                    // child:
                  ),
                  title: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Vehicle name : ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16)),
                    TextSpan(
                        text: vehicleName,
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
                        text: "Amount : ",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        )),
                    TextSpan(
                        text: vehicleAmount,
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
                                                  .doc(uid)
                                                  .collection('vehicles')
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
