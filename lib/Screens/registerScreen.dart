import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkeasy/Models/usermodel.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Utils/colors.dart';
import 'package:parkeasy/Utils/utils.dart';
import 'package:parkeasy/widgets/custombtn.dart';
import 'package:provider/provider.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  // File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
  }

  // for selecting image
  // void selectImage() async {
  //   image = await pickImage(context);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      // InkWell(
                      //   onTap: () => selectImage(),
                      //   child: image == null
                      //       ? const CircleAvatar(
                      //           backgroundColor: Colors.teal,
                      //           radius: 50,
                      //           child: Icon(
                      //             Icons.account_circle,
                      //             size: 50,
                      //             color: Colors.white,
                      //           ),
                      //         )
                      //       : CircleAvatar(
                      //           backgroundImage: FileImage(image!),
                      //           radius: 50,
                      //         ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      // const Text(
                      //   'Upload your image',
                      //   style: TextStyle(
                      //       fontSize: 15,
                      //       color: Colors.black38,
                      //       fontWeight: FontWeight.w600),
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/user.gif'),
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.height * 0.3,
                            ),
                            // name field
                            textFeld(
                              hintText: "Enter your name",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              controller: nameController,
                            ),

                            // email
                            textFeld(
                              hintText: "Enter you email",
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              controller: emailController,
                            ),

                            // dob
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber.shade50,
                              ),
                              child: TextField(
                                controller: bioController,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  icon: Container(
                                    height: 33,
                                    width: 33,
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: primaryColor,
                                    ),
                                    child: Icon(
                                      Icons.calendar_today,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ), //icon of text field
                                  border: InputBorder.none,
                                  hintText: "Date of birth",
                                  alignLabelWithHint: true,
                                  //label text of field
                                ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now());

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yMd').format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      bioController.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: () => storeData(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    required keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        cursorColor: Colors.amber,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: primaryColor,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.amber.shade50,
          filled: true,
        ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      dob: bioController.text.trim(),
      phoneNumber: "",
    );
    if (nameController != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
