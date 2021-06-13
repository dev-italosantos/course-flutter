import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GifFinderPage extends StatefulWidget {
  const GifFinderPage({Key? key}) : super(key: key);

  @override
  _GifFinderPageState createState() => _GifFinderPageState();
}

class _GifFinderPageState extends State<GifFinderPage> {
  String _search = "";
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;

    // ignore: unnecessary_null_comparison
    if (_search == null) {
      response = await http.get(
        Uri(
            path:
                "https://api.giphy.com/v1/gifs/trending?api_key=xTYujjERq2SZIpQWCacZH7KtmWibpMnb&limit=20&rating=g"),
      );
    } else {
      response = await http.get(
        Uri(
            path:
                "https://api.giphy.com/v1/gifs/search?api_key=xTYujjERq2SZIpQWCacZH7KtmWibpMnb&q=$_search&=20&offset=$_offset&rating=g&lang=en"),
      );
    }

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Image.network(
            "https://image.flaticon.com/icons/png/512/1837/1837538.png",
            width: 50.0,
            height: 50.0,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise Aqui!",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
