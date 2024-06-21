import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class UlasanPage extends StatefulWidget {
  final String id_user;
  final int? idBooking; // Optional idBooking if it's available
  final int? idPengasuh; // Optional idPengasuh if it's available
  final String namaPengasuh;

  UlasanPage({
    required this.id_user,
    required this.idBooking,
    required this.idPengasuh,
    required this.namaPengasuh,
  });

  @override
  _UlasanPageState createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  final _textController = TextEditingController();

  Future<void> _submitReview() async {
    try {
      // Prepare the request body
      var requestBody = {
        "ulasan": _textController.text,
        "id_user": int.parse(widget.id_user),
      };

      // Add idPengasuh to requestBody if it's not null
      if (widget.idPengasuh != null) {
        requestBody["id_pengasuh"] = widget.idPengasuh as Object;
      }

      // Send HTTP POST request
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/tambah_ulasan/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Check response status
      if (response.statusCode == 201) {
        // Show success message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Color(0xFFFF7A8F),
                ),
                SizedBox(width: 10),
                Text(
                  'Ulasan Berhasil Ditambahkan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7A8F),
                  ),
                ),
              ],
            ),
            content: Text(
              'Ulasan Anda untuk pengasuh ${widget.namaPengasuh} telah berhasil disimpan.',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFFF7A8F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        //Show error message
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Terjadi error saat menyimpan ulasan.'),
        //   ),
        // );
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     title: Text('Ulasan Berhasil Ditambahkan'),
        //     content: Text(
        //         'Ulasan Anda untuk pengasuh ${widget.namaPengasuh} telah berhasil disimpan.'),
        //     actions: [
        //       TextButton(
        //         onPressed: () {
        //           Navigator.of(context).pushAndRemoveUntil(
        //             MaterialPageRoute(builder: (context) => MyHomePage()),
        //             (route) => false,
        //           );
        //         },
        //         child: Text('OK'),
        //       ),
        //     ],
        //   ),
        // );

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Color(0xFFFF7A8F),
                ),
                SizedBox(width: 10),
                Text(
                  'Ulasan Berhasil Ditambahkan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7A8F),
                  ),
                ),
              ],
            ),
            content: Text(
              'Ulasan Anda untuk pengasuh ${widget.namaPengasuh} telah berhasil disimpan.',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A8F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Ulasan'),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
      appBar: AppBar(
        title: const Text(
          'Ulasan',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFF7A8F),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFFFF7A8F),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    MyHomePage(userId: int.parse(widget.id_user)),
              ),
            );
          },
        ),
      ),

      // body: Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Berikan ulasan untuk pengasuh ${widget.namaPengasuh}',
      //         style: TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),
      //         textAlign: TextAlign.center,
      //       ),
      //       SizedBox(height: 20.0),
      //       TextField(
      //         controller: _textController,
      //         maxLines: 5,
      //         decoration: InputDecoration(
      //           hintText: 'Tulis ulasan Anda di sini...',
      //           border: OutlineInputBorder(),
      //         ),
      //       ),
      //       SizedBox(height: 20.0),
      //       ElevatedButton(
      //         onPressed: () {
      //           _submitReview();
      //         },
      //         child: Text('Simpan Ulasan'),
      //       ),
      //     ],
      //   ),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'BAGAIMANA PENGALAMANMU BERSAMA',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF7A8F),
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset(
                  'image/nanny.jpg',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.namaPengasuh,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Ceritakan Pengalamanmu!',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 188, 188, 188)
                            .withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 188, 188, 188),
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _submitReview();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: const Color(0xFFFF7A8F),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'BAGIKAN',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
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
