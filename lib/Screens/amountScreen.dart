import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/addVehicleScreen.dart';
import 'package:parkeasy/Screens/priceScreen.dart';
import 'package:parkeasy/Utils/utils.dart';
import 'package:provider/provider.dart';

class AmmountScreen extends StatelessWidget {
  final String tappedValue;
  final String tappedImage;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AmmountScreen({required this.tappedValue, required this.tappedImage});

  final vehicleController = TextEditingController();
  final ammountController = TextEditingController();

  void dispose() {
    ammountController.dispose();
    vehicleController.dispose();
  }

  void setamount(String uid, String vehicle, String amount) async {}
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => AddVehicleScreen()));
          },
        ),
        title: const Text(
          'Set Amount',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/doller.gif'),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                tappedImage,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.04,
              // ),
              // Image.asset(),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  initialValue: tappedValue,
                  readOnly: true,
                  // controller: vehicleController,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 224, 169, 4)),
                    ),
                  ),
                  // controller: vehicleController,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: ammountController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      MdiIcons.currencyRupee,
                      color: Colors.black,
                    ),
                    hintText: 'Enter an amount',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 224, 169, 4)),
                    ),
                  ),
                  // controller: vehicleController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextButton(
                      onPressed: () {
                        final String uid = "users";
                        _createSubcollection(context, tappedValue,
                            ammountController.text, tappedImage);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.amber),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ListTile(
                          leading: Icon(
                            MdiIcons.check,
                            color: Colors.black,
                          ),
                          title: const Text('Set Amount'),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createSubcollection(
      BuildContext context, vehicleName, String amount, String imageUrl) async {
    if (amount.isEmpty) {
      showSnackBar(context, "Please Enter an amount");
    } else {
      try {
        User? user = _auth.currentUser;

        if (user != null) {
          final String uid = user.uid;

          // Create a subcollection named "vehicles" inside the user's document
          CollectionReference vehiclesCollection =
              _firestore.collection('users').doc(uid).collection('vehicles');

          // Add a new document to the "vehicles" subcollection
          await vehiclesCollection.add({
            'name': vehicleName,
            'amount': amount,
            'imageUrl': tappedImage,
            // Add other fields as needed
          });

          print('Subcollection document created successfully.');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PriceScreen(uid)));
        } else {
          print('User is not logged in.');
        }
      } catch (e) {
        print('Error creating subcollection document: $e');
      }
    }
  }
  // Future<String?> uploadImage(File imageFile, String uid) async {
  //   try {
  //     final Reference storageReference = firebase_storage
  //         .FirebaseStorage.instance
  //         .ref()
  //         .child('users/$uid/vehicles/image.jpg');
  //     final UploadTask uploadTask = storageReference.putFile(imageFile);
  //     await uploadTask.whenComplete(() => null);
  //     final imageUrl = await storageReference.getDownloadURL();
  //     return imageUrl;
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //     return null;
  //   }
  // }
}
