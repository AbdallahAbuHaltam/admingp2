import 'dart:io';
import 'package:admingp2/models/facilities.dart';
import 'package:admingp2/screens/launch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/auth.dart';
import 'list_page.dart';

int selectedIndex = -1;
String dat = '';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final AuthService _auth = AuthService();

  final _formKey1 = GlobalKey<FormState>();

  bool _isCheckedWater = false;
  bool _isTextFormVisibleWater = false;

  bool _isCheckedGatorade = false;
  bool _isTextFormVisibleGatorade = false;
  bool _isCheckedKit = false;
  bool _isTextFormVisibleKit = false;
  var sizeOfPlaygroungList = ["5*5", "6*6"];
  String sizeOfPlaygroungValue = "5*5";

  var typeOfPlaygroundList = [
    "Football",
    "Basketball",
    "Tennis",
    "Padel",
    "Swimming",
    "volleyball",
    "Table tennis"
  ];
  String typeOfPlaygroundValue = "Football";

  var typeOfPaymentList = ["Cash", "visa"];
  String typeOfPaymentValue = "Cash";

  final TextEditingController _stadiumnamecontroller = TextEditingController();
  double _pricecontroller = 0.0;
  double _waterPriceController = 0.0;
  double _gatoradePriceController = 0.0;
  final TextEditingController _kitPriceController = TextEditingController();

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
      body: Form(
        key: _formKey1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Playground name(1)

                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _stadiumnamecontroller.text = value;
                    });
                  },
                  onSaved: (newValue) {
                    _stadiumnamecontroller.text = newValue!;
                  },
                  keyboardType: TextInputType.name,
                  style: const TextStyle(),
                  enabled: true,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Name of playground',
                    labelStyle: const TextStyle(
                      color: Colors.redAccent,
                    ),
                    hintText: 'Enter Playground Name',
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

                // SizedBox

                const SizedBox(
                  height: 20,
                ),

                //Playground type(2)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        child: Text(
                          "Type of playground",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 232, 232, 232),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            value: typeOfPlaygroundValue,
                            onChanged: (String? value) {
                              setState(() {
                                typeOfPlaygroundValue = value!;
                              });
                            },
                            items: typeOfPlaygroundList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                ),

                //SizedBox

                const SizedBox(
                  height: 15,
                ),

                //SizedBox

                const SizedBox(
                  height: 10,
                ),

                //Playground Price(4)

                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _pricecontroller = double.parse(value);
                    });
                  },
                  onSaved: (newValue) {
                    _pricecontroller = double.parse(newValue!);
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

                //SizedBox

                const SizedBox(
                  height: 20,
                ),

                //Playground Size(5)

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Text(
                          "Size of playground ",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 70, vertical: 0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 232, 232, 232),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            value: sizeOfPlaygroungValue,
                            onChanged: (String? value) {
                              setState(() {
                                sizeOfPlaygroungValue = value!;
                              });
                            },
                            items: sizeOfPlaygroungList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                ),
                ////SizedBox

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 10, 8, 30),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 223, 223, 223)),
                    child: Column(
                      children: [
                        Text(
                          "Add facilites : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedWater,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedWater = value!;

                                  _isTextFormVisibleWater = value;
                                });
                              },
                            ),
                            Text('Water'),
                          ],
                        ),
                        Visibility(
                          visible: _isTextFormVisibleWater,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? "Must be more 1 length "
                                  : null,
                              onChanged: (val) {
                                _waterPriceController = double.parse(val);
                              },
                              onSaved: (value) {
                                _waterPriceController = double.parse(value!);
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter price',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedGatorade,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedGatorade = value!;

                                  _isTextFormVisibleGatorade = value;
                                });
                              },
                            ),
                            Text('Gatorage'),
                          ],
                        ),
                        Visibility(
                          visible: _isTextFormVisibleGatorade,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? "Must be more 1 length "
                                  : null,
                              onChanged: (val) {
                                _gatoradePriceController = double.parse(val);
                              },
                              onSaved: (value) {
                                _gatoradePriceController = double.parse(value!);
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter price',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _isCheckedKit,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedKit = value!;

                                  _isTextFormVisibleKit = value;
                                });
                              },
                            ),
                            Text('Kit'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //Pyement Method(6)

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 40),
                        child: Text(
                          "Payment type",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 70, vertical: 0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 232, 232, 232),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            value: typeOfPaymentValue,
                            onChanged: (String? value) {
                              setState(() {
                                typeOfPaymentValue = value!;
                              });
                            },
                            items: typeOfPaymentList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
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
                    if (_formKey1.currentState!.validate()) {
                      _formKey1.currentState!.save();

                      _auth.addPlaygroundData(
                          playgroundName: _stadiumnamecontroller.text,
                          price: _pricecontroller,
                          type: typeOfPlaygroundValue,
                          size: sizeOfPlaygroungValue,
                          payment: typeOfPaymentValue,
                          date: dat,
                          facilities: Facilities(
                            waterPrice: _waterPriceController,
                            gatoradePrice: _gatoradePriceController,
                            kit: "kit",
                          ));
                      _auth.addFacilities(
                        water: "water",
                        waterPrice: _waterPriceController,
                        gatorade: "gatorade",
                        gatoradePrice: _gatoradePriceController,
                        kit: "kit",
                      );
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListPage()),
                    );
                    final snackBar = SnackBar(
                      content: Text('Playground Add !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
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
        ),
      ),
    );
  }
}
