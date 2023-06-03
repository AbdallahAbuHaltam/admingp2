import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'add_page.dart';
import 'list_page.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  int _selectedIndex = 0;

  late String name;
  late String type = 'Football';
  late String price;
  late String size = '5*5';
  late String pay = 'Cash';
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  final picker = ImagePicker();

  static const List<Widget> _widgetOptions = <Widget>[
    ListPage(),
    AddPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions.elementAt(index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.redAccent,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: ListView(
          children: [
            TextField(
              style: const TextStyle(),
              onChanged: (String value) {
                print('value $value');
                setState(() {
                  name = value;
                });
                print('name $name');
              },
              enabled: true,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFFF694D),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: ' Playground name',
                hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                prefixIcon: const Icon(
                  Icons.date_range,
                  color: Colors.redAccent,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            //SizedBox
            const SizedBox(
              height: 20,
            ),
            //Playground type(2)
            DropdownButtonFormField<String>(
              value: type,
              onChanged: (String? newValue) {
                setState(() {
                  type = newValue!;
                });
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Type',
                labelStyle: const TextStyle(color: Colors.redAccent),
                hintText: 'Select Playground Type',
                hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                hintMaxLines: 1,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items:  [
                DropdownMenuItem<String>(
                  value: 'Football',
                  child: Row(
                    children: [
                      Text(
                        'Football',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 22, 50),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.sports_football,
                        color: Color.fromARGB(255, 0, 22, 50),
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Basketball',
                  child: Row(
                    children: [
                      Text('Basketball'),
                      SizedBox(width: 10),
                      Icon(Icons.sports_basketball),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Tennis',
                  child: Row(
                    children: [
                      Text('Tennis'),
                      SizedBox(width: 10),
                      Icon(Icons.sports_tennis),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Padel',
                  child: Row(
                    children: [
                      Text('Padel'),
                      SizedBox(width: 10),
                      Icon(Icons.sports_cricket),
                    ],
                  ),
                ),
              ],
            ),

// SizedBox
            const SizedBox(
              height: 30,
            ),
            //image pick from gallary(3)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < _images.length; i++)
                    InkWell(
                      onTap: () => setState(() => _images.removeAt(i)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Image.file(
                          File(_images[i].path),
                          width: 90,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (_images.length < 3)
                    InkWell(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            //SizedBox
            const SizedBox(
              height: 30,
            ),
            //Playground Price(4)
            TextField(
              onChanged: (String value) {
                setState(() {
                  price = value;
                });
              },
              keyboardType: TextInputType.number,
              style: TextStyle(),
              enabled: true,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFFF694D),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: ' Playground Price',
                hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                prefixIcon: const Icon(
                  Icons.monetization_on,
                  color: Colors.redAccent,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            //SizedBox
            const SizedBox(
              height: 20,
            ),
            //Playground Size(5)
            DropdownButtonFormField<String>(
              value: size,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Playground Size',
                hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                prefixIcon: const Icon(
                  Icons.nature_people,
                  color: Colors.redAccent,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  size = value ?? '';
                });
              },
              items: const [
                DropdownMenuItem(
                  value: '5*5',
                  child: Text('5*5'),
                ),
                DropdownMenuItem(
                  value: '6*6',
                  child: Text('6*6'),
                ),
                DropdownMenuItem(
                  value: '7*7',
                  child: Text('7*7'),
                ),
                DropdownMenuItem(
                  value: '8*8',
                  child: Text('8*8'),
                ),
              ],
            ),
////SizedBox
            const SizedBox(
              height: 20,
            ),
            //Pyement Method(6)
            DropdownButtonFormField<String>(
              value: pay,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Pyement Method',
                hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                hintMaxLines: 1,
                hintTextDirection: TextDirection.ltr,
                prefixIcon: const Icon(
                  Icons.payment,
                  color: Colors.redAccent,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  pay = value ?? '';
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'Cash',
                  child: Text('Cash'),
                ),
                DropdownMenuItem(
                  value: 'Visa',
                  child: Text('Visa'),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text('Other'),
                ),
              ],
            ),
            //SizedBox
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.redAccent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              onPressed: _images.isNotEmpty
                  ? () {
                      Navigator.pop(context, {
                        'name': name,
                        'type': type,
                        'price': price,
                        'size': size,
                        'pay': pay,
                        'imagePath': _images.first.path,
                      });
                    }
                  : null,
              child: const Text(
                'SAVE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
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
            label: 'bookings',
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
