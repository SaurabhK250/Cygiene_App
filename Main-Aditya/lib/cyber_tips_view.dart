import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsApiService {
  static const _apiKey = '954559b9924c4d108f6215097a699a4d';
  static const _baseUrl = 'https://newsapi.org/v2';

  Future<List<dynamic>> fetchCyberNews() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/everything?q=cyber&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyber News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsListScreen(),
    );
  }
}

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsApiService _newsApiService = NewsApiService();
  late Future<List<dynamic>> _newsArticles;

  @override
  void initState() {
    super.initState();
    _newsArticles = _newsApiService.fetchCyberNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cyber News'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _newsArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return NewsTile(article: article);
              },
            );
          }
        },
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final dynamic article;

  NewsTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: article['urlToImage']!= null
          ? Image.network(
        article['urlToImage'],
        width: 100,
        fit: BoxFit.cover,
      )
          : null,
      title: Text(article['title']),
      onTap: () {
        final description = article['description'];
        final url = article['url'];
        if (description!= null && url!= null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailScreen(description: description, url: url),
            ),
          );
        }
      },
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final String description;
  final String url;

  NewsDetailScreen({required this.description, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(description),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _launchURL(url);
              },
              child: Text('Read Full Article'),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}