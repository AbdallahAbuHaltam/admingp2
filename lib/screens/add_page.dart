import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String type = 'Football';
  String size = '5*5';
  String pay = 'Cash';
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();
  final AuthService _auth = AuthService();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final TextEditingController _stadiumnamecontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  final picker = ImagePicker();
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
          'Add',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 5),
          children: [
            //Playground name(1)
            Form(
              key: _formKey1,
              child: TextFormField(
                controller: _stadiumnamecontroller,
                style: const TextStyle(),
                onChanged: (String value) {
                  setState(() {
                    _stadiumnamecontroller.text = value;
                  });
                },
                onSaved: (newValue) {
                  _stadiumnamecontroller.text = newValue!;
                },
                enabled: true,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'name',
                  labelStyle: const TextStyle(
                    color: Colors.redAccent,
                  ),
                  hintText: 'Enter Playground name',
                  hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                  hintMaxLines: 1,
                  hintTextDirection: TextDirection.ltr,
                  prefixIcon: const Icon(
                    Icons.stadium,
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
            ),
            // SizedBox
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
              onSaved: (newValue) {
                type = newValue!;
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
              items: [
                DropdownMenuItem<String>(
                  value: type,
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

            //SizedBox
            const SizedBox(
              height: 15,
            ),

            const Text(
              "pick your images",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            // SizedBox
            const SizedBox(
              height: 40,
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
              height: 40,
            ),

            //Playground Price(4)
            Form(
              key: _formKey2,
              child: TextFormField(
                onChanged: (String value) {
                  setState(() {
                    _pricecontroller.text = value;
                  });
                },
                onSaved: (newValue) {
                  _pricecontroller.text = newValue!;
                },
                keyboardType: TextInputType.number,
                style: const TextStyle(),
                enabled: true,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Price',
                  labelStyle: const TextStyle(
                    color: Colors.redAccent,
                  ),
                  hintText: 'Enter Playground Price',
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
                labelText: 'Size',
                labelStyle: const TextStyle(
                  color: Colors.redAccent,
                ),
                hintText: 'Enter Playground Size',
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
              onSaved: (newValue) {
                size = newValue!;
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
                labelText: 'Pyement',
                labelStyle: const TextStyle(
                  color: Colors.redAccent,
                ),
                hintText: 'Enter Pyement Method',
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
            // Save Button
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
              onPressed: () {
                if (_formKey1.currentState!.validate() &&
                    _formKey2.currentState!.validate()) {
                  _formKey1.currentState!.save();
                  _formKey2.currentState!.save();

                  _auth.addPlaygroundData(
                    playgroundName: _stadiumnamecontroller.text,
                    price: _pricecontroller.text ,
                    size: size,

                  );
                }
              },

              /* _images.isNotEmpty
                  ? () {
                      Navigator.pop(context, {
                        'name': _stadiumnamecontroller.text,
                        'type': type,
                        'price': _pricecontroller.text,
                        'size': size,
                        'pay': pay,
                        'imagePath': _images.isNotEmpty ? _images[0].path : '',
                        'imagePath1': _images.length > 1 ? _images[1].path : '',
                        'imagePath2': _images.length > 2 ? _images[2].path : '',
                      });
                    }
                  : null,*/
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
    );
  }
}
