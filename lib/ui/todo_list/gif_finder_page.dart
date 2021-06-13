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

    if (_search == null)
      response = await http.get(
        Uri(
            path:
                "https://api.giphy.com/v1/gifs/trending?api_key=xTYujjERq2SZIpQWCacZH7KtmWibpMnb&limit=20&rating=g"),
      );
    else
      response = await http.get(
        Uri(
            path:
                "https://api.giphy.com/v1/gifs/search?api_key=xTYujjERq2SZIpQWCacZH7KtmWibpMnb&q=$_search&=20&offset=$_offset&rating=g&lang=en"),
      );

    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGifs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
