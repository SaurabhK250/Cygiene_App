import 'dart:async';
import 'package:cygiene_ui/navigation/parameters_logic.dart';
import 'package:cygiene_ui/views/profile_pages/about_us_view.dart';
import 'package:cygiene_ui/views/profile_pages/blogs_view.dart';
import 'package:cygiene_ui/views/profile_pages/faqs_view.dart';
import 'package:cygiene_ui/views/profile_pages/profile_view.dart';
import 'package:cygiene_ui/views/widgets/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wireguard_vpn/wireguard_vpn.dart';
import '../../providers/vpn_provider.dart';
import 'constants/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  final _wireguardFlutterPlugin = WireguardVpn();
  bool vpnActivate = false;
  Stats stats = Stats(totalDownload: 0, totalUpload: 0);
  final String initName = 'sakec-wire4';
  final String initAddress = "192.168.69.4/24";
  final String initPort = "51820";
  final String initDnsServer = "101.53.147.30";
  final String initPrivateKey = "CDi9IdHiYJmw9mCzgBb3EIoUR8JNINnbdsMz0gYz1lE=";
  final String initAllowedIp = "0.0.0.0/0, ::/0";
  final String initPublicKey = "FytzEla1nQkpfGAouJaM1eFKR1e5N9vbt24of2+iIHg=";
  final String initEndpoint = "115.113.39.74:51820";
  final String presharedKey = "iP4F07mNzTur0nJc71T/rDxaJpIOk+Ntg8xyJafW1AY=";

  late Timer _timer;
  int _vpnDurationInSeconds = 0;
  bool isVpnButtonClicked = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    vpnActivate ? _obtainStats() : null;
    _startVpnTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startVpnTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _vpnDurationInSeconds++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final vpnState = Provider.of<VpnState>(context, listen: true);
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
     
      appBar: AppBar(
        
        toolbarHeight: 350,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Color.fromARGB(255, 2, 85, 154)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 const SizedBox(height: 80),
                const Text(
                  "Tap to connect",
                  style: TextStyle(
                      color: white, fontSize: 24, ),
                ),
                
                const SizedBox(height: 20),
                InkWell(
                  borderRadius: BorderRadius.circular(size.height),
                  onTap: () {
                    setState(() {
                      isVpnButtonClicked = !isVpnButtonClicked;
                      if (isVpnButtonClicked) {
                        vpnState.toggleConnection();
                        if (vpnState.isConnected) {
                          vpnState.startTimer();
                          _activateVpn(vpnState.isConnected, vpnState);
                        }
                      } else {
                        vpnState.stopTimer();
                        _activateVpn(vpnState.isConnected, vpnState);
                      }
                    });
                  },
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/vpn_button.jpg',
                        width: 80.0,
                        height: 80.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fiber_manual_record,
                      size: 12,
                      color: vpnState.isConnected
                          ? Color.fromARGB(255, 6, 192, 12)
                          : Colors.redAccent,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      vpnState.isConnected ? 'Connected' : 'Disconnected',
                      style: const TextStyle(
                        fontSize: 15,
                        color: white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Material(
              color: white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                                const Text(
                  "CyberPeace Secure DNS",
                  style: TextStyle(
                      color: primaryColor, fontSize: 27, fontWeight: FontWeight.bold),
                ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Duration',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Download',
                            style: TextStyle(
                              color: Color(0xFF0299FB),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${stats.totalDownload}',
                            style: const TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Mbps',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 3,
                        height: 70,
                        color: Color(0xFF666666),
                      ),
                      Column(
                        children: [
                          const Text(
                            'Upload',
                            style: TextStyle(
                              color: Color(0xFF0299FB),
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${stats.totalUpload}',
                            style: const TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Mbps',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      _formatDuration(_vpnDurationInSeconds),
                      style: const TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const parameters_logic(),
            ),
          );
        },
        label: const Text(
          "Get your cygiene score",
          style: TextStyle(color: white, fontSize: 15),
        ),
        backgroundColor: primaryColor,
        icon: const Icon(
          Icons.security,
          color: white,
        ),
      ),
    );
  }

  void _obtainStats() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      final results = await _wireguardFlutterPlugin.tunnelGetStats(initName);
      setState(() {
        stats = results ?? Stats(totalDownload: 0, totalUpload: 0);
      });
    });
  }

  void _activateVpn(bool value, VpnState vpnState) async {
  final toastMsg = value
      ? 'You are now connected to CyberPeace Secure DNS'
      : 'You are now disconnected from CyberPeace Secure DNS';
  final toastColor = value ? Colors.greenAccent : Colors.redAccent.shade100;

  Fluttertoast.showToast(
    msg: toastMsg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: toastColor,
    textColor: white,
    fontSize: 16.0,
  );

  print(toastMsg); // Print message in console

  setState(() {
    vpnActivate = value;
    if (vpnActivate) {
      _obtainStats();
      if (vpnState.isConnected) {
        vpnState.startTimer();
      }
    } else {
      vpnState.stopTimer();
    }
  });

  if (vpnActivate) {
    _activateVpnBackground(vpnState);
  } else {
    // Disconnect VPN directly
    await _disconnectVpn();
    vpnState.disconnect(); // Update state
    print("VPN disconnected");
  }

  // Print connection status in console
  print("VPN is ${vpnActivate ? 'connected' : 'disconnected'}");
}
Future<void> _disconnectVpn() async {
  await _wireguardFlutterPlugin.changeStateParams(SetStateParams(
    state: false, // Disconnect
    tunnel: Tunnel(
      name: initName,
      address: initAddress,
      dnsServer: initDnsServer,
      listenPort: initPort,
      peerAllowedIp: initAllowedIp,
      peerEndpoint: initEndpoint,
      peerPublicKey: initPublicKey,
      privateKey: initPrivateKey,
      peerPresharedKey: presharedKey,
    ),
  ));
}
  void _activateVpnBackground(VpnState vpnState) async {
    final results =
        await _wireguardFlutterPlugin.changeStateParams(SetStateParams(
      state: vpnActivate,
      tunnel: Tunnel(
        name: initName,
        address: initAddress,
        dnsServer: initDnsServer,
        listenPort: initPort,
        peerAllowedIp: initAllowedIp,
        peerEndpoint: initEndpoint,
        peerPublicKey: initPublicKey,
        privateKey: initPrivateKey,
        peerPresharedKey: presharedKey,
      ),
    ));

    setState(() {
      if (results ?? false) {
        if (vpnActivate) {
          vpnState.connect();
        } else {
          vpnState.disconnect();
        }
      } else {
        vpnState.disconnect();
      }
    });
  }

  String _formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}