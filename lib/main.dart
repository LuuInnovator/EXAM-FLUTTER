// lib/main.dart

import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart'; // Import thư viện diacritic
import 'image_urls.dart'; // Import file ảnh

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TASC App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Destination> destinations = [
    Destination(name: 'Hà Nội', rating: 4.7, imageUrl: ImageUrls.haNoi),
    Destination(name: 'Đà Nẵng', rating: 4.5, imageUrl: ImageUrls.daNang),
    Destination(name: 'Nha Trang', rating: 4.6, imageUrl: ImageUrls.nhaTrang),
    Destination(name: 'Phú Quốc', rating: 4.8, imageUrl: ImageUrls.phuQuoc),
  ];

  List<Destination> filteredDestinations = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDestinations = destinations; // Khởi tạo danh sách lọc bằng danh sách ban đầu
  }

  void filterDestinations(String query) {
    // Loại bỏ dấu khỏi chuỗi tìm kiếm
    final normalizedQuery = removeDiacritics(query.toLowerCase());

    if (query.isEmpty) {
      setState(() {
        filteredDestinations = destinations;
      });
    } else {
      setState(() {
        filteredDestinations = destinations
            .where((destination) =>
            removeDiacritics(destination.name.toLowerCase())
                .contains(normalizedQuery))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi Guy!'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Where are you going next?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchController,
              onChanged: filterDestinations,
              decoration: InputDecoration(
                hintText: 'Search your destination',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                suffixIcon: Icon(Icons.search, color: Colors.purple),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Popular Destinations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible( // Sử dụng Flexible để chiếm không gian còn lại
            child: ListView.builder(
              itemCount: filteredDestinations.length,
              itemBuilder: (context, index) {
                return DestinationCard(
                  name: filteredDestinations[index].name,
                  rating: filteredDestinations[index].rating,
                  imageUrl: filteredDestinations[index].imageUrl,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Destination {
  final String name;
  final double rating;
  final String imageUrl;

  Destination({required this.name, required this.rating, required this.imageUrl});
}

class DestinationCard extends StatelessWidget {
  final String name;
  final double rating;
  final String imageUrl;

  DestinationCard({required this.name, required this.rating, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageScreen(imageUrl: imageUrl),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text('$rating ⭐', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 4),
                Icon(Icons.favorite, color: Colors.red, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Màn hình hiển thị ảnh lớn
class ImageScreen extends StatelessWidget {
  final String imageUrl;

  ImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
