import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';
import '../helpers/responsive_helper.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  //
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
  //
}

class _HomeScreenState extends State<HomeScreen> {
  //
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    configIsLoaded.then((value) => _fetchArticles(apiKey));
    // _fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 40),
          Center(
            child: Text(
              'The New York Times\nTop Tech Articles',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          SizedBox(height: 40),
          _articles.length > 0
              ? _buildArticlesGrid(mediaQuery)
              : Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  _fetchArticles(String apiKey) async {
    //
    List<Article> articles = await ApiService(apiKey).fetchArticlesBySection('technology');
    setState(() {
      _articles = articles;
    });
  }

  _buildArticlesGrid(MediaQueryData mediaQuery) {
    //
    List<GridTile> tiles = [];
    _articles.forEach((item) {
      tiles.add(_buildArticleTile(item, mediaQuery));
    });
    return Padding(
      padding: responsivePadding(mediaQuery),
      child: GridView.count(
        crossAxisCount: responsiveNumGridTiles(mediaQuery),
        mainAxisSpacing: 30.0,
        crossAxisSpacing: 30.0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: tiles,
      ),
    );
  }

  _buildArticleTile(Article article, MediaQueryData mediaQuery) {
    // print('>>> _buildArticleTile > article.title=${article.title}');
    return GridTile(
      child: GestureDetector(
        onTap: () => _launchURL(article.url),
        child: Column(
          children: <Widget>[
            Container(
              height: responsiveImageHeight(mediaQuery),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                image: DecorationImage(image: NetworkImage(article.imageUrl), fit: BoxFit.cover),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              height: responsiveTitleHeight(mediaQuery),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, offset: Offset(0, 1), blurRadius: 6.0),
                ],
              ),
              child: Text(
                utf8.decode(article.title.runes.toList()),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //
}
