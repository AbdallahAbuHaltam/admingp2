import 'package:flutter/material.dart';
import 'add_page.dart';
import 'booking_page.dart';
import 'card_column.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _selectedIndex = 0;
  final List<Widget> _cardList = [];

  void _addCard(List list) {
    String name = list[0];
    String type = list[1];
    String price = list[2];
    String size = list[3];
    String pay = list[4];
    String imagePath = list[5];
    String imagePath1 = list[6];
    String imagePath2 = list[7];

    setState(() {
      _cardList.add(
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: CardColumn(
                    title1: name,
                    title2: type,
                    title3: price,
                    title4: size,
                    title5: pay,
                    fontSize: 18,
                    imagePath: imagePath,
                    imagePath1: imagePath1,
                    imagePath2: imagePath2,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Navigation Bar
  static final List<Widget> _widgetOptions = <Widget>[
    const ListPage(),
    const AddPage(),
    BookingPage(),
  ];

  void _onItemTapped(int index) async {
    if (_selectedIndex == index) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            index != 1 ? _widgetOptions.elementAt(index) : const AddPage(),
      ),
    );

    if (result != null) {
      final List list = result.values.toList(); // Convert Map to List
      _addCard(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(237, 253, 253, 253),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 25,
              child: IconButton(
                onPressed: () {
                  // Handle image selection from gallery
                },
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'List Page',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                // Handle notification button pressed
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.redAccent,
                size: 30,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            ..._cardList,
          ],
        ),
      ),
      // Navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
            ),
            label: 'Bookings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
