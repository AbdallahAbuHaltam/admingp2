import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  final List<String> bookings = [
    'Booking 1',
    'Booking 2',
    'Booking 3',
    'Booking 4',
    'Booking 5',
    'Booking 6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Bookings'),
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(bookings[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to booking details page
            },
          );
        },
      ),
    );
  }
}
