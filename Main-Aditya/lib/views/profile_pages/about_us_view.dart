import 'package:cygiene_ui/constants/colors.dart';
import 'package:cygiene_ui/views/widgets/card_widget_view.dart';
import 'package:flutter/material.dart';
import '../../constants/lists.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor:primaryColor,
        title: const Text(
          'About us',
          style: TextStyle(color: white),
        ),
      ),
      backgroundColor: white,
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 30),
          ),


Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ExpansionTile(
              title: const Text(
                'About Cygiene',
                style: TextStyle(
                    color: Color.fromARGB(255, 6, 111, 173), fontSize: 25),
              ),
              children: [
                ListTile(
            title: Text(
                          """Smartphone attacks can be very dangerous. Precautions against such malwares should be on first priority. In conclusion, Smartphone attacks seem small, yet a modern danger developed throughout the recent years. Mobile security threats are on the rise: Mobile devices now account for more than 60 percent of digital fraud, from phishing attacks to stolen passwords.Using our phones for sensitive business such as banking makes security even
more essential. Viruses and malware should not be the major concern for the users who use their smartphones just to make calls or to click pictures. If the user downloads a lot of apps , visits various pirated sites and is very careless , the user is putting himself at great risk.In India people download anything from the internet carelessly for their needs which in return they have to face huge loss.Our aim is to educate and help smartphone users to secure their smartphones, by providing solutions to their problems. We are not anti-virus , not anti-malware, We are Cygiene - A cyber hygiene score app.""",
              style: TextStyle(fontSize: 15, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          )
              ],
              leading: const Icon(
                Icons.circle,
                color: Color.fromARGB(255, 6, 111, 173),
                size: 35,
              ),
              //tileColor: Color.fromARGB(255, 52, 183, 223),
            ),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ExpansionTile(
              title: const Text(
                'Cygiene Team',
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 111, 173),
                  fontSize: 25,
                ),
              ),
              leading: const Icon(
                Icons.policy_sharp,
                color: Color.fromARGB(255, 6, 111, 173),
                size: 35,
              ),
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of cards per row
                    mainAxisSpacing: 10.0, // Vertical spacing between cards
                    crossAxisSpacing: 10.0, // Horizontal spacing between cards
                  ),
                  itemCount: cards.length,
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling within the ExpansionTile
                  itemBuilder: (context, index) {
                    return CustomCard(card: cards[index]);
                  },
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ExpansionTile(
              title: const Text(
                'Collaborators',
                style: TextStyle(
                    color: Color.fromARGB(255, 6, 111, 173), fontSize: 25),
              ),
              children: [
                Image.asset(
                  'assets/collab.jpg',
                ),
              ],
              leading: const Icon(
                Icons.group,
                color: Color.fromARGB(255, 6, 111, 173),
                size: 35,
              ),
              //tileColor: Color.fromARGB(255, 52, 183, 223),
            ),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ExpansionTile(
              title: const Text(
                'Mentors',
                style: TextStyle(
                    color: Color.fromARGB(255, 6, 111, 173), fontSize: 25),
              ),
              leading: const Icon(
                Icons.rate_review_sharp,
                color: Color.fromARGB(255, 6, 111, 173),
                size: 35,
              ),
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of cards per row
                    mainAxisSpacing: 10.0, // Vertical spacing between cards
                    crossAxisSpacing: 10.0, // Horizontal spacing between cards
                  ),
                  itemCount: mentorCards.length,
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling within the ExpansionTile
                  itemBuilder: (context, index) {
                    return CustomMentorCard(
                      card: mentorCards[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
