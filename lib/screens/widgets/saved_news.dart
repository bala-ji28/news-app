import 'package:app/model/news_saved_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../common.dart';

class SavedNewsPage extends StatefulWidget {
  const SavedNewsPage({super.key});

  @override
  State<SavedNewsPage> createState() => _SavedNewsPageState();
}

class _SavedNewsPageState extends State<SavedNewsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: Hive.box<SavedNews>('newsdb').listenable(),
        builder: (context, Box<SavedNews> box, child) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('Database is empty'),
            );
          }
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, i) {
                var savedNews = box.getAt(i);
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person_outline_rounded),
                              Text(
                                savedNews!.author,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.85,
                            child: Text(
                              savedNews.title,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                dateFormat(savedNews.publishedAt),
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                          child: const Icon(
                            Icons.bookmark_outline,
                            color: Colors.red,
                          ),
                          onTap: () {
                            box.deleteAt(i);
                          }),
                    ],
                  ),
                );
              });
        });
  }
}
