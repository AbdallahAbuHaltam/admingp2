import 'dart:io';
import 'package:admingp2/models/facilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/auth.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  final AuthService _auth = AuthService();

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

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
  final TextEditingController _pricecontroller = TextEditingController();
  final TextEditingController _waterPriceController = TextEditingController();
  final TextEditingController _gatoradePriceController =
      TextEditingController();
  final TextEditingController _kitPriceController = TextEditingController();

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
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  isDense: true,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
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
                          controller: _waterPriceController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value!.isEmpty ? "Must be more 1 length " : null,
                          onChanged: (val) {
                            _waterPriceController.text = val;
                          },
                          onSaved: (value) {
                            _waterPriceController.text = value!;
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
                          controller: _gatoradePriceController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value!.isEmpty ? "Must be more 1 length " : null,
                          onChanged: (val) {
                            _gatoradePriceController.text = val;
                          },
                          onSaved: (value) {
                            _gatoradePriceController.text = value!;
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
                    Visibility(
                      visible: _isTextFormVisibleKit,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _kitPriceController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value!.isEmpty ? "Must be more 1 length " : null,
                          onChanged: (val) {
                            _kitPriceController.text = val;
                          },
                          onSaved: (value) {
                            _kitPriceController.text = value!;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter price',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
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
                if (_formKey1.currentState!.validate() &&
                    _formKey2.currentState!.validate()) {
                  _formKey1.currentState!.save();

                  _formKey2.currentState!.save();

                  _auth.addPlaygroundData(
                    playgroundName: _stadiumnamecontroller.text,
                    price: _pricecontroller.text,
                    type: typeOfPlaygroundValue,
                    size: sizeOfPlaygroungValue,
                    payment: typeOfPaymentValue,
                    facilities: Facilities(
                      waterPrice: _waterPriceController.text,
                      gatoradePrice: _gatoradePriceController.text,
                      kit: _kitPriceController.text,
                    )
                  );
                  _auth.addFacilities(
                    water: "water",
                    waterPrice: _waterPriceController.text,
                    gatorade: "gatorade",
                    gatoradePrice: _gatoradePriceController.text,
                    kit: _kitPriceController.text,
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

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('playgroundInfo').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(snapshot.data!.docs[index]['email']),
                  subtitle: Text(snapshot.data!.docs[index]['adminName']),
                ),
              );
            },
          );
        });
  }
}
