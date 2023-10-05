import 'package:flutter/material.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        title: const Text(
          'Your profile',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 1),
        ),
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.amber,
                  backgroundColor: Colors.black,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/details.gif',
                      scale: 1,
                    ),
                    // CircleAvatar(
                    //   backgroundColor: Colors.teal,
                    //   backgroundImage: NetworkImage(ap.profilePic),
                    //   radius: 50,
                    // ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        // ap.userModel.name,
                        'Name: ${ap.userName}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 10),
                    // Text(ap.userModel.dob),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        'Email: ${ap.userEmail}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        // ap.userModel.dob,
                        ' DOB: ${ap.dateOfBirth}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ],
                )),
    );
  }
}
