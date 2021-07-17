import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GifFinderPage extends StatefulWidget {
  const GifFinderPage({Key? key}) : super(key: key);

  @override
  _GifFinderPageState createState() => _GifFinderPageState();
}

class _GifFinderPageState extends State<GifFinderPage> {
  String _search = "";
  int _offSet = 0;

  Future<Map> _getGifs() async {
    http.Response response;

    // ignore: unnecessary_null_comparison
    if (_search == null) {
      response = await http.get(
        Uri(
          path:
              "https://api.giphy.com/v1/gifs/trending?api_key=xTYujjERq2SZIpQWCacZH7KtmWibpMnb&limit=25&rating=g",
        ),
      );
    } else {
      response = await http.get(
        Uri(
          path:
              "https://api.giphy.com/v1/gifs/search?api_key=xTYujjERq2SZIpQWCacZH7KtmWibpMnb&q=$_search&=20&offset=$_offSet&rating=g&lang=en",
        ),
      );
    }
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((map) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
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
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return _createGifTable(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Image.network(
            snapshot.data["data"][index]["images"]["fixed_height"]["url"],
            height: 300.0,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
