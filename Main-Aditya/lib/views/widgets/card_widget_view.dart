// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class CardData {
  final String name;
  final String imageUrl;
  final String email;
  final String phone;
  final String linkedIn;

  CardData({
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.phone,
    required this.linkedIn,
  });
}

class CustomCard extends StatelessWidget {
  final CardData card;
  const CustomCard({super.key, required this.card});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(card.imageUrl),
          ),
          const SizedBox(height: 10),
          Text(
            card.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                            IconButton(
                color: Color.fromARGB(255, 0, 0, 0),
                onPressed: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path:
                        '+92${card.phone}', // Replace with a valid number for your country
                  );
                  await launch(launchUri.toString());
                },
                icon: const Icon(Icons.call,
                ),
              ),
              IconButton(
                color: const Color.fromARGB(255, 205, 14, 1),
                onPressed: () async {
                  final Uri launchUri = Uri(
                    scheme: 'mailto',
                    path: card.email,
                  );
                  await launch(launchUri.toString());
                },
                icon: const Icon(
                  Icons.email_rounded
                ),
              ),
              IconButton(
                color: Colors.blue,
                onPressed: () async {
                  final Uri launchUri = Uri(
                    scheme: 'https',
                    path: card.linkedIn,
                  );
                  await launch(launchUri.toString());
                },
                icon: const Icon(
                  LineIcons.linkedin,
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}


class CardMData {
  final String name;
  final String imageUrl;
  final String email;
  final String linkedIn;

  CardMData({
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.linkedIn,
  });
}

class CustomMentorCard extends StatelessWidget {
  final CardMData card;
  const CustomMentorCard({super.key, required this.card});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            
            backgroundImage: AssetImage(card.imageUrl),
          ),
          const SizedBox(height: 12),
          Text(
            card.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                color: const Color.fromARGB(255, 205, 14, 1),
                onPressed: () async {
                  final Uri launchUri = Uri(
                    scheme: 'mailto',
                    path: card.email,
                  );
                  await launch(launchUri.toString());
                },
                icon: const Icon(
                  Icons.email,
                ),
              ),
              IconButton(
                color: Colors.blue,
                onPressed: () async {
                  final Uri launchUri = Uri(
                    scheme: 'https',
                    path: card.linkedIn,
                  );
                  await launch(launchUri.toString());
                },
                icon: const Icon(
                  LineIcons.linkedin,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
