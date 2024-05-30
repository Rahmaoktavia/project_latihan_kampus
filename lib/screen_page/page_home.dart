import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_latihan_kampus/screen_page/page_detail_kampus.dart';
import '../Model/model_kampus.dart';

void main() => runApp(PageHome());

class PageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<ModelKampus> futureKampus;

  @override
  void initState() {
    super.initState();
    futureKampus = fetchKampus();
  }

  Future<ModelKampus> fetchKampus() async {
    final response = await http.get(Uri.parse('http://192.168.156.142/project_kampus/getBerita.php'));

    if (response.statusCode == 200) {
      return ModelKampus.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load kampus: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rahma Oktavia'),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.language, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    TextField(
    decoration: InputDecoration(
    hintText: 'Kampus',
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    ),
    SizedBox(height: 16),
    Text('Most Visited', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    SizedBox(height: 16),
    SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: FutureBuilder<ModelKampus>(
    future: futureKampus,
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Text("Error: ${snapshot.error}");
    } else if (snapshot.hasData) {
    return Row(
    children: snapshot.data!.data.map((kampus) {
    final imageUrl = 'http://192.168.156.142/project_kampus/gambar/${kampus.gambar}';
    return InkWell(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => KampusDetail(kampus: kampus), // Meneruskan objek kampus
    ),
    );
    },
    child: Container(
    margin: EdgeInsets.only(right: 16),
    width: 200,
    child: Column(
    children: [
    CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
    height: 150,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    image: DecorationImage(
    image: imageProvider,
    fit: BoxFit.cover,
    ),
    ),
    ),
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
    ),
    SizedBox(height: 8),
    Text(kampus.nama, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    Text(kampus.lokasi, style: TextStyle(fontSize: 14, color: Colors.grey)),
    ],
    ),
    ),
    );
    }).toList(),
    );
    } else {
    return Text("No data available");
    }
    },
    ),
    ),
    SizedBox(height: 16),
    Text('Near You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    SizedBox(height: 16),
    SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: FutureBuilder<ModelKampus>(
    future: futureKampus,
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Text("Error: ${snapshot.error}");
    } else if (snapshot.hasData) {
    return SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    child: Column(
    children: snapshot.data!.data.map((kampus) {
    final imageUrl = 'http://192.168.156.142/project_kampus/gambar/${kampus.gambar}';
    return InkWell(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => KampusDetail(kampus: kampus), // Meneruskan objek kampus
    ),
    );
    },
    child: Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16), // Menambahkan padding di sekitar card
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 5,
    offset: Offset(0, 3), // changes position of shadow
    ),
    ],
    ),
    child: Row(
    children: [
    CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.cover,
      ),
    ),
    ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
      SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(kampus.nama, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_pin, color: Colors.green),
                Expanded(
                  child: Text(
                    '${kampus.lokasi} - 1.5km',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 2, // Set maxLines to 2 for multi-line display
                    overflow: TextOverflow.ellipsis, // Overflow strategy
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: () {},
      ),
    ],
    ),
    ),
    );
    }).toList(),
    ),
    );
    } else {
      return Text("No data available");
    }
    },
    ),
    ),
    ],
    ),
    ),
        ),
    );
  }
}


