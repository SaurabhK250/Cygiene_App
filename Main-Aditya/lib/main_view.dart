import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cygiene_ui/constants/colors.dart';
import 'package:cygiene_ui/providers/vpn_provider.dart';
import 'package:cygiene_ui/views/installed_apps.dart';
import 'package:cygiene_ui/views/profile_pages/contact_us_view.dart';
import 'package:cygiene_ui/views/profile_pages/faqs_view.dart';
import 'package:cygiene_ui/views/widgets/custom_dialog_widget_view.dart';
import 'package:flutter/material.dart';
import 'package:cygiene_ui/views/profile_pages/contact_us_view.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:line_icons/line_icons.dart';
import 'home_view.dart';
import 'models/User.dart';
import 'views/profile_pages/blogs_view.dart';
import 'package:provider/provider.dart';
import '../../models/authentication/FirebaseAuthServiceModel.dart';
import 'views/installed_apps.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeView(),
    const BlogsView(),
    const faqs_view(),
    const AppCheckExample()
  ];
  final List<void> methods = [];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeView();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData?>(context);
    final Stream<DocumentSnapshot<Map>> _userStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .snapshots(includeMetadataChanges: true);

    return Scaffold(
      // appBar: AppBar(

      //   title: Text("VPN", style: TextStyle(color: white)),
      //   centerTitle: true,
      // ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
    );
  }
}
