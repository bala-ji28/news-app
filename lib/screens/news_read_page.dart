import 'package:flutter/material.dart';
import '../common.dart';
import '../model/news_model.dart';

class NewsReadPage extends StatefulWidget {
  final News news;
  const NewsReadPage({super.key, required this.news});

  @override
  State<NewsReadPage> createState() => _NewsReadPageState();
}

class _NewsReadPageState extends State<NewsReadPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Happy Reading',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.news.urlToImage,
                  fit: BoxFit.fill,
                  height: size.height * 0.35,
                  width: double.infinity,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                widget.news.title,
                maxLines: 3,
                style: const TextStyle(
                    fontSize: 17.0, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  const Icon(Icons.person_outline_rounded),
                  Text(
                    widget.news.author,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14.0),
                  ),
                  Text(
                    ' - ${dateFormat(widget.news.publishedAt)}',
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                widget.news.content.toString(),
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextButton(
                child: const Text(
                  "Read More",
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
                onPressed: () async {
                  urlLauncher(widget.news.url);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
