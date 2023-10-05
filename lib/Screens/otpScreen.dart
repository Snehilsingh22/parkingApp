// import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Screens/phoneNoScreen.dart';
import 'package:parkeasy/Screens/registerScreen.dart';
import 'package:parkeasy/Utils/colors.dart';
import 'package:parkeasy/widgets/custombtn.dart';
import 'package:provider/provider.dart';

// import 'home.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String myPhone;

  const OtpScreen(
      {super.key, required this.verificationId, required this.myPhone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController phoneController = TextEditingController();
  String? otpCode;

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
          : Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/man.gif',
                      ),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: GestureDetector(
                    //     onTap: () => Navigator.of(context).pop(),
                    //     child: const Icon(Icons.arrow_back),
                    //   ),
                    // ),
                    // Container(
                    //   width: 100,
                    //   height: 100,
                    //   padding: const EdgeInsets.all(20.0),
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: Colors.teal.shade50,
                    //   ),
                    //   child: const Icon(
                    //     Icons.person_2_rounded,
                    //     size: 50,
                    //     color: Colors.teal,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    const Text(
                      "OTP Verification",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Enter the OTP sent to ${widget.myPhone}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      cursorColor: Colors.amber,
                      controller: phoneController,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          otpCode = value;
                        });
                      },
                      maxLength: 6,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter OTP",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                        suffixIcon: IconButton(
                          onPressed: phoneController.clear,
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                      ),
                    ),
                    const Row(
                      children: [
                        Text(''),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: CustomButton(
                        text: "Verify",
                        onPressed: () {
                          verifyOtp(context, otpCode!, widget.myPhone);
                          if (otpCode != null) {
                            verifyOtp(context, otpCode!, widget.myPhone);
                          } else {
                            Fluttertoast.showToast(
                              msg: "Login Failed",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.amber,
                              textColor: Colors.black,
                              fontSize: 16.0,
                            );
                          }
                        },
                      ),
                    ),
                    // const SizedBox(height: 20),
                    // const Text(
                    //   "Didn't receive any code?",
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black38,
                    //   ),
                    // ),
                    // const SizedBox(height: 15),
                    // const TextButton(onPressed:, child: Text('Edit Phone Number'),
                    // ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          'Edit Phone Number ?',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
    ));
  }

  void verifyOtp(BuildContext context, String userOtp, String phoneNumber) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db

        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              Fluttertoast.showToast(
                msg: "Login Successful",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.yellow,
                textColor: Colors.black,
                fontSize: 16.0,
              );
              // user exists in our app

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            } else {
              Fluttertoast.showToast(
                msg: "Login Successful",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.yellow,
                textColor: Colors.black,
                fontSize: 16.0,
              );
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInfromationScreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
