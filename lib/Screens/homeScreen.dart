// ignore_for_file: non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/addVehicleScreen.dart';
import 'package:parkeasy/Screens/addVendorScreen.dart';
import 'package:parkeasy/Screens/allVendorScreen.dart';
import 'package:parkeasy/Screens/phoneNoScreen.dart';
import 'package:parkeasy/Screens/priceScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  loader() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<AuthProvider>(context, listen: false)
        .getDataFromFirestore();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.amber,
        ),
        backgroundColor: Colors.amber,
        title: const Text(
          "ParkEasy",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                // ignore: avoid_types_as_parameter_names
                builder: (BuildContext) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0)), //this right here
                      child: SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Are you sure?",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber),
                                    child: const Text("Cancel",
                                        style: TextStyle(color: Colors.black)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen(),
                                          ));
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
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CircleAvatar(
            //   backgroundColor: Colors.teal,
            //   backgroundImage: NetworkImage(ap.profilePic),
            //   radius: 50,
            // ),
            // const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.only(right: 15),
            //   child: Text(
            //     // ap.userModel.name,
            //     'Name: ${ap.userName}',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            //   ),
            // ),
            // const SizedBox(height: 10),
            // // Text(ap.userModel.dob),
            // Padding(
            //   padding: const EdgeInsets.only(left: 40),
            //   child: Text(
            //     'Email: ${ap.userEmail}',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.w600,
            //         fontSize: 15),
            //   ),
            // ),
            // const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.only(left: 2),
            //   child: Text(
            //     // ap.userModel.dob,
            //     ' DOB: ${ap.dateOfBirth}',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.w600,
            //         fontSize: 16),
            //   ),
            // ),
            // CustomButton(text: 'Add Vehicle', onPressed: () {}),
            // CustomButton(text: 'Add User', onPressed: () {})
            const Image(
              image: AssetImage('assets/hi.gif'),
              height: 260,
              width: 260,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddVehicleScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.amber),
                  width: 250,
                  child: ListTile(
                    leading: Icon(
                      MdiIcons.car,
                      color: Colors.black,
                    ),
                    title: const Text('Add Vehicle'),
                  ),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddUserScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.amber),
                  width: 250,
                  child: ListTile(
                    leading: Icon(
                      MdiIcons.account,
                      color: Colors.black,
                    ),
                    title: const Text('Add Vendors'),
                  ),
                )),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PriceScreen()));
                      },
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.amber,
                          child: Center(
                              child: Icon(
                            MdiIcons.currencyRupee,
                            color: Colors.black,
                            size: 40,
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AutoSizeText(
                      'Current Pricing',
                      style: TextStyle(fontSize: 17),
                      maxLines: 1,
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VendorScreen()));
                      },
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.amber,
                          child: Center(
                              child: Icon(
                            MdiIcons.account,
                            color: Colors.black,
                            size: 40,
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AutoSizeText(
                      'Vendors',
                      style: TextStyle(fontSize: 17),
                      maxLines: 1,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
