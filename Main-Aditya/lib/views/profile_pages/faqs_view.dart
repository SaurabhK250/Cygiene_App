import 'package:cygiene_ui/home_view.dart';
import 'package:flutter/material.dart';

class faqs_view extends StatelessWidget {
  const faqs_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'FAQs',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 111, 173),
        body: ListView(children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 30),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const ExpansionTile(
              title: Text(
                '1.  What is Cygiene ?',
                style: TextStyle(
                    color: Color.fromARGB(255, 6, 111, 173),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              // leading:Text("1.", style: TextStyle(color: Color.fromARGB(255, 6, 111, 173),fontSize: 25),),
              children: [
                ListTile(
                  title: Text(
                    """Cygiene helps the user to prevent various attacks by pointing out the vulnerabilities present in the smartphone and helps them to take necessary precautions. It shows a score called Cygiene score, which helps the user to evaluate about smartphone security level and how they can improve the Cygiene score, which in turn make their device more secure.
""",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const ExpansionTile(
              title: Text(
                '2.  Why Cygiene ?',
                style: TextStyle(
                    color: Color.fromARGB(255, 6, 111, 173),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              // leading:Text("1.", style: TextStyle(color: Color.fromARGB(255, 6, 111, 173),fontSize: 25),),
              children: [
                ListTile(
                  title: Text("""Cygiene will make user more conscious about the current mobile security threats. Our aim is to make user aware about common security threats and help them to counter these threats by configuring common security settings.Our app will help the user to understand the security risk of their mobile phone and will suggest them to take preventive measures.""",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.justify),
                )
              ],
            ),
          ),
        ]
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeView(),
            ),
          );
        }
        ,),
        );
  }
}
