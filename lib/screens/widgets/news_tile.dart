import 'package:app/model/news_saved_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../common.dart';
import '../../model/news_model.dart';
import '../news_read_page.dart';

class NewsTile extends StatefulWidget {
  final News news;
  const NewsTile({super.key, required this.news});

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  Color changeColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsReadPage(news: widget.news)),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.news.urlToImage,
                fit: BoxFit.fill,
                height: size.height * 0.13,
                width: size.width * 0.25,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_outline_rounded),
                    Text(
                      widget.news.author,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * 0.60,
                  child: Text(
                    widget.news.title,
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
                      dateFormat(widget.news.publishedAt),
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      ' - ${widget.news.source.name}',
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
                child: Icon(
                  Icons.bookmark_outline,
                  color: changeColor,
                ),
                onTap: () {
                  Box box = Hive.box<SavedNews>('newsdb');
                  box.add(SavedNews(
                      author: widget.news.author,
                      title: widget.news.title,
                      description: widget.news.description,
                      url: widget.news.url,
                      urlToImage: widget.news.urlToImage,
                      publishedAt: widget.news.publishedAt,
                      content: widget.news.content));
                }),
          ],
        ),
      ),
    );
  }
}
