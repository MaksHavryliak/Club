import 'package:club/screen/posts_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularClubsScreen extends StatelessWidget {
  static const String id = "popular_clubs_screen";

  const PopularClubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Top gay clubs in Ukraine'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(PostsScreen.id);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const Text(
                "The Verkhovna Rada of Ukraine",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Image.network(
                'https://www.rada.gov.ua/images/korniienko/030322rjh2.jpg',
                height: 300,
                width: 500,
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(16)),
          Column(
            children: [
              const Text(
                "The Ukraine national football team",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Image.network(
                'https://cdn.novyny.pro/i/image_1440x810/media/image/667/578/54e/66757854eb67c.jpg.webp',
                height: 260,
                width: 500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
