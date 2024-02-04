import 'package:flutter/material.dart';

import '../../api/api_service.dart';
import '../../model/news_model.dart';
import 'news_tile.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService newsData = ApiService();
    return FutureBuilder(
      future: newsData.fetchNews(),
      builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
        if (snapshot.hasData) {
          List<News>? news = snapshot.data;
          return ListView.builder(
            itemCount: news!.length,
            itemBuilder: (context, index) => NewsTile(news: news[index]),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
