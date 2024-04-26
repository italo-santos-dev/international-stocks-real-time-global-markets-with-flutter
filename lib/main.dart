import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StocksListPage(),
    );
  }
}

class StocksListPage extends StatefulWidget {
  @override
  _StocksListPageState createState() => _StocksListPageState();
}

class _StocksListPageState extends State<StocksListPage> {
  List<dynamic> stocks = [];

  @override
  void initState() {
    super.initState();
    fetchStocks();
  }

  Future<void> fetchStocks() async {
    final String apiUrl =
        "https://financialmodelingprep.com/api/v3/stock/list?apikey=YOUR_KEY";

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        stocks = jsonData;
      });
    } else {
      throw Exception('Falied to load stocks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks'),
      ),
      body: ListView.builder(
          itemCount: stocks.length,
          itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                title: Text(
                  stocks[index]['symbol'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black87
                  ),
                ),
                subtitle: Text(
                  stocks[index]['name'],
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54
                  ),
                ),
                trailing: Text(
                  '\$ ${stocks[index]['price']}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.green
                  ),
                ),
              ),
            ),
        );
      }),
    );
  }
}