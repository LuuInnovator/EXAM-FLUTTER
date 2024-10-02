import 'package:flutter/material.dart';

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
    Destination(name: 'Hà Nội', rating: 4.7, imageUrl: 'https://images.unsplash.com/photo-1507512070204-5f1b4e1dbd6c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3M3wwfDF8c2VhcmNofDF8fGhhJTIwbm9pJTIwYmF0aCUyMGNhbnRlcnxlbnwwfHx8fDE2MjQ0NzE5NzY&ixlib=rb-1.2.1&q=80&w=400'),
    Destination(name: 'Đà Nẵng', rating: 4.5, imageUrl: 'https://images.unsplash.com/photo-1522419117884-d3ae00b27000?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3M3wwfDF8c2VhcmNofDMyfHxkYW5hbmd8ZW58MHx8fHwxNjI0NDcxOTc2&ixlib=rb-1.2.1&q=80&w=400'),
    Destination(name: 'Nha Trang', rating: 4.6, imageUrl: 'https://images.unsplash.com/photo-1519949651368-97f3d44f265c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3M3wwfDF8c2VhcmNofDE1fHxuaGF0cmFuZ3xlbnwwfHx8fDE2MjQ0NzE5NzY&ixlib=rb-1.2.1&q=80&w=400'),
    Destination(name: 'Phú Quốc', rating: 4.8, imageUrl: 'https://images.unsplash.com/photo-1560807702-9c3e9a0d4b76?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3M3wwfDF8c2VhcmNofDJ8fHBodSUyMHF1b3xlbnwwfHx8fDE2MjQ0NzE5NzY&ixlib=rb-1.2.1&q=80&w=400'),
  ];

  List<Destination> filteredDestinations = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDestinations = destinations; // Khởi tạo danh sách lọc bằng danh sách ban đầu
  }

  void filterDestinations(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredDestinations = destinations; // Nếu ô tìm kiếm trống, hiển thị tất cả
      });
    } else {
      setState(() {
        filteredDestinations = destinations
            .where((destination) => destination.name.toLowerCase().contains(query.toLowerCase()))
            .toList(); // Lọc theo tên địa điểm
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
      body: SingleChildScrollView(
        child: Column(
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
                onChanged: filterDestinations, // Gọi hàm lọc khi người dùng nhập
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
            Container(
              height: 350, // Chiều cao cho vùng "Popular Destination"
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
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
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
