import 'dart:io';

import 'package:flutter/material.dart';

import 'edit_page.dart';

class CardColumn extends StatelessWidget {
  const CardColumn({
    Key? key,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    required this.title5,
    required this.fontSize,
    required this.imagePath,
    required this.imagePath1,
    required this.imagePath2,
  }) : super(key: key);

  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String title5;
  final double fontSize;
  final String imagePath;
  final String imagePath1;
  final String imagePath2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Images
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.file(
                      File(imagePath),
                      width: 340,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 5),
                    //Playground Size(5)
                    Text(
                      title4,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Image.file(
                      File(imagePath1),
                      width: 340,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 5),
                    //Playground Size(5)
                    Text(
                      title4,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Image.file(
                      File(imagePath2),
                      width: 340,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 5),
                    //Playground Size(5)
                    Text(
                      title4,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        //SizedBox
        const SizedBox(
          height: 5,
        ),

        // Other elements
        //Playground name(1)
        Row(
          children: [
            const Icon(
              Icons.stadium_sharp,
              color: Colors.redAccent,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title1,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            //Playground type(2)
            Text(
              title2,
              style: const TextStyle(
                color: Color.fromARGB(255, 10, 137, 241),
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ],
        ),
        //SizedBox
        const SizedBox(height: 5),
        //Playground Price(4)
        Row(
          children: [
            const Icon(
              Icons.attach_money,
              color: Colors.redAccent,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title3,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ],
        ),
        //SizedBox
        const SizedBox(height: 5),
        //Pyement Method(6)
        Row(
          children: [
            const Icon(
              Icons.payment,
              color: Colors.redAccent,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title5,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
        //SizedBox
        const SizedBox(height: 10),
        //Edit IconButton
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
