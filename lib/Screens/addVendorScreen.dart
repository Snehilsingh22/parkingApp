import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Utils/colors.dart';
import 'package:parkeasy/Utils/utils.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final VendorNameController = TextEditingController();
  final PhoneNoController = TextEditingController();
  // final emailController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Uint8List? _image;
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = true;

  String? validateEmail(String value) {
    final RegExp emailRegex = RegExp(
      r'[a-z A-z 0-9_\-\.]+[@][a-z]+[\.][a-z]{2,3}$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegex.hasMatch(value) ? null : 'Enter a valid email address';
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        showCloseIcon: true,
        closeIconColor: Colors.white,
      ),
    );
  }
  //  void _createSubcollection(BuildContext context, String vendorName, String email, String image, String phoneNo) {
  //   // Add your logic to create a subcollection here
  //   if (!isEmailValid) {
  //     showSnackbar(context, 'Please enter a valid email address.');
  //     return; // Prevent further processing if the email is not valid
  //   }

  //   // Add the rest of your logic for creating the subcollection here
  // }
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: primaryColor,
        ),
        backgroundColor: primaryColor,
        title: const Text(
          "Add Vendors",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/sale.gif'),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.06,
              backgroundImage: AssetImage('assets/admin.gif'),
              backgroundColor: primaryColor,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: VendorNameController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    MdiIcons.account,
                    color: Colors.black,
                  ),
                  hintText: 'Enter vendor name',
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
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: emailController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    MdiIcons.gmail,
                    color: Colors.black,
                  ),
                  hintText: 'Enter email address',
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
                onChanged: (value) {
                  setState(() {
                    isEmailValid = validateEmail(value) == null;
                  });
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                cursorColor: primaryColor,
                controller: PhoneNoController,
                style: const TextStyle(),
                onChanged: (value) {
                  setState(() {
                    PhoneNoController.text = value;
                  });
                },
                maxLength: 10,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                enableSuggestions: true,
                autofillHints: const [AutofillHints.telephoneNumber],
                decoration: InputDecoration(
                  hintText: "Enter phone number",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 224, 169, 4)),
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 400,
                              ),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            " + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ),
                  suffixIcon: PhoneNoController.text.length == 10
                      ? Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          child: const Icon(
                            Icons.done,
                            color: Colors.black,
                            size: 20,
                          ),
                        )
                      : null,
                ),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    final String uid = "users";
                    addVendorPhoneNumber(
                        VendorNameController.text, PhoneNoController.text);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(30),
                        color: primaryColor),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ListTile(
                      leading: Icon(
                        MdiIcons.check,
                        color: Colors.black,
                      ),
                      title: const Text('Add Vendor'),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addVendorPhoneNumber(String phoneNumber, String name) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? adminUser = auth.currentUser;

    if (adminUser != null) {
      final adminId = adminUser.uid;
      final vendorData = {
        'name': name,
        'phoneNumber': phoneNumber,
      };

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(adminId)
            .collection('vendors')
            .add(vendorData);
        print('Vendor added successfully');
      } catch (e) {
        print('Error adding vendor: $e');
      }
    } else {
      print('Admin user not authenticated');
    }
  }
  // Future<void> _createSubcollection(BuildContext context, String name,
  //     String email, imageUrl, String mobileNo) async {
  //   AuthProvider ap = AuthProvider();

  //   if (email.isEmpty || name.isEmpty || email.isEmpty) {
  //     showSnackBar(context, "Please enter all fields");
  //   } else if (isEmailValid) {
  //     try {
  //       User? user = _auth.currentUser;

  //       if (user != null) {
  //         final String uid = user.uid;

  //         // Create a subcollection named "vehicles" inside the user's document
  //         CollectionReference vehiclesCollection = _firestore
  //             .collection('AllAdmin')
  //             .doc(ap.userPhone)
  //             .collection('vendors');
  //         // String imageUrl = await uploadImageToStorage(_image, uid);
  //         // Add a new document to the "vehicles" subcollection
  //         await vehiclesCollection.add({
  //           'name': name,
  //           'Email': email,
  //           'mobileNo': mobileNo,
  //           'imageUrl': _image,

  //           // Add other fields as needed
  //         });

  //         print('Subcollection document created successfully.');
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => VendorScreen(uid)));
  //       } else {
  //         print('User is not logged in.');
  //       }
  //     } catch (e) {
  //       print('Error creating subcollection document: $e');
  //     }
  //   } else {
  //     showSnackBar(context, "Enter valid email");
  //   }
  // }

  Future<String> uploadImageToStorage(Uint8List? image, String vendorId) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('vendors/$vendorId/image.jpg');

      UploadTask uploadTask = storageReference.putData(image!);

      // Wait for the upload to complete and get the download URL
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return ''; // Handle the error gracefully
    }
  }
}
