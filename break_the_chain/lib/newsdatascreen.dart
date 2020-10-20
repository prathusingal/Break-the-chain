import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'homepage.dart';
import 'news_data.dart';
import 'newstile.dart';

NewsDataModel cm = NewsDataModel();

class NewsDataScreen extends StatefulWidget {
  final dynamic newsdata;
  NewsDataScreen({@required this.newsdata});
  @override
  _NewsDataScreenState createState() => _NewsDataScreenState();
}

class _NewsDataScreenState extends State<NewsDataScreen> {
  dynamic newsArticles;
  @override
  void initState() {
    super.initState();
    updateUI(widget.newsdata);
  }

  void updateUI(dynamic mydata) {
    if (mydata == null) {
      newsArticles = {};
    } else {
      setState(() {
        newsArticles = mydata;
      });
    }
  }

  List<Widget> getListTiles(dynamic articles) {
    List<Widget> newsTiles = [];
    for (var article in articles) {
      newsTiles.add(
        NewsTile(
          url: article["url"],
          urlToImage: article["urlToImage"],
          title: article["title"],
          description: article["description"],
        ),
      );
    }
    return newsTiles;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamed(HomePage.homepageId);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: 35.0,
            onPressed: () {
              Navigator.pushNamed(context, HomePage.homepageId);
            },
          ),
          backgroundColor: Colors.teal,
          title: Text(
            "Health News",
            style: kCovidDataTitleTextStyle,
          ),
        ),
        body: SafeArea(
          child: Container(
            child: ListView(
              children: getListTiles(newsArticles),
            ),
          ),
        ),
      ),
    );
  }
}
