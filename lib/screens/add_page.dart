import 'dart:io';
import 'package:admingp2/models/facilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  final _formKey3 = GlobalKey<FormState>();

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

  /*Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  final picker = ImagePicker();*/
  String imageUrl = '';

  Future<void> _getImageUrl() async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('image.jpg');

    try {
      String downloadURL = await storageReference.getDownloadURL();
      setState(() {
        imageUrl = downloadURL;
      });
    } catch (error) {
      // Handle error while fetching the image URL
      print('Error: $error');
    }
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _selectImageFromLibrary() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() {
        // Image uploaded successfully
        storageReference.getDownloadURL().then((fileURL) {
          // You can now save the fileURL to Firestore or use it as needed
          print("File URL: $fileURL");
        });
      }).catchError((error) {
        // Handle image upload error
        print("Image upload error: $error");
      });
    }
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
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 5),
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

              /* Container(
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
              ),*/
              Center(
                child: ElevatedButton(
                  onPressed: _selectImageFromLibrary,
                  child: Text('Select Image'),
                ),
              ),

              //SizedBox

              const SizedBox(
                height: 40,
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
                      Visibility(
                        visible: _isTextFormVisibleKit,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _kitPriceController,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => value!.isEmpty
                                ? "Must be more 1 length "
                                : null,
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
                  if (_formKey1.currentState!.validate()) {
                    _formKey1.currentState!.save();

                    _auth.addPlaygroundData(
                        playgroundName: _stadiumnamecontroller.text,
                        price: _pricecontroller,
                        type: typeOfPlaygroundValue,
                        size: sizeOfPlaygroungValue,
                        payment: typeOfPaymentValue,
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
      ),
    );
  }
}
