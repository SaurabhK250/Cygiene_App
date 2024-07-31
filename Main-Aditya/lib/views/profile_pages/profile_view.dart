import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cygiene_ui/constants/colors.dart';
import 'package:cygiene_ui/views/profile_pages/faqs_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/User.dart';
import '../../models/authentication/FirebaseAuthServiceModel.dart';
import '../../providers/vpn_provider.dart';
import '../widgets/custom_dialog_widget_view.dart';
import 'about_us_view.dart';
import 'edit_profile_view.dart';
import 'contact_us_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData?>(context);
    final Stream<DocumentSnapshot<Map>> _userStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .snapshots(includeMetadataChanges: true);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: primaryColor,
        title: const Text(
          "Account",
          style: TextStyle(
            color: white,
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: StreamBuilder<DocumentSnapshot<Map>>(
          stream: _userStream,
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map>> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return SingleChildScrollView( // Wrap with SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
                children: <Widget>[
                  Container(
                    height: 250, // Increased height
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.person,
                            color: primaryColor,
                            size: 60,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          snapshot.data!['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snapshot.data!['email'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          child: Card(
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              onTap: (() => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfileView(
                                      data: snapshot.data,
                                    ),
                                  ),
                                ),
                              }),
                              title: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: const Icon(
                                Icons.edit,
                                color: white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            onTap: (() => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactUsView(
                                    data: snapshot.data,
                                  ),
                                ),
                              ),
                            }),
                            title: const Text(
                              'Contact Us',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(
                              Icons.contact_phone,
                              color: white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            onTap: (() => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AboutUsView(),
                                ),
                              ),
                            }),
                            title: const Text(
                              'About Us',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(
                              Icons.perm_device_information,
                              color: white,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            onTap: (() => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const faqs_view(),
                                ),
                              ),
                            }),
                            title: const Text(
                              'FAQs',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(
                              Icons.question_answer,
                              color: white,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24), // More spacing
                        const Text(
                          'Other Actions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: CustomConfirmDialog(
                                  title: "Logout",
                                  subtitle: "Are you sure you want to?",
                                  icon: const Icon(
                                    Icons.logout,
                                    color: white,
                                    size: 70,
                                  ),
                                  onYesPressed: () {
                                    setState(() {
                                      VpnState vpnState =
                                      context.read<VpnState>();
                                      vpnState.disconnect();
                                      FirebaseAuthServiceModel()
                                          .signOutUser()
                                          .then((value) => {
                                        AndroidAlarmManager.cancel(0)
                                            .then((value) => {
                                          // Reset the VPN state provider to initial state
                                          Navigator.pushNamed(
                                              context, '/login')
                                        })
                                      });
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const ListTile(
                              title: Text(
                                'Log Out',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: Icon(
                                Icons.logout,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40), // More spacing at the bottom
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}