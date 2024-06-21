import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'data_pengasuh.dart';
import 'data_ulasan.dart';
import 'detail_booking.dart';

Future<List<Ulasan>> fetchUlasan(int idPengasuh) async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/ulasan_pengguna/$idPengasuh'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> ulasanJsonList = jsonResponse['data'];
    return ulasanJsonList.map((ulasan) => Ulasan.fromJson(ulasan)).toList();
  } else {
    return [];
  }
}

class DetailPengasuhPage extends StatefulWidget {
  final Pengasuh pengasuh;
  final String id_user;

  DetailPengasuhPage({required this.pengasuh, required this.id_user});

  @override
  _DetailPengasuhPageState createState() => _DetailPengasuhPageState();
}

class _DetailPengasuhPageState extends State<DetailPengasuhPage> {
  late Future<List<Ulasan>> futureUlasan;

  @override
  void initState() {
    super.initState();
    futureUlasan = fetchUlasan(widget.pengasuh.idPengasuh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFFFF7A8F),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Detail Pengasuh',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFF7A8F),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'http://127.0.0.1:8000/getimage/' +
                                    widget.pengasuh.fotoPengasuh
                                        .split('/')
                                        .last,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.pengasuh.nama,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: Color(0xFFFF7A8F),
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.pengasuh.alamat,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    color: Color(0xFFFF7A8F),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.payments_sharp,
                                  color: Color(0xFFFF7A8F),
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Rp. ${widget.pengasuh.tarif}/Jam',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    color: Color(0xFFFF7A8F),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(
                              Icons.comment_rounded,
                              color: Color.fromARGB(255, 145, 145, 145),
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              // '${widget.pengasuh.rating}',
                              'komen',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 16.0),
                          child: Text(
                            'Detail',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF7A8F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Container(
                            width: double.infinity, // Mengatur lebar penuh
                            alignment: Alignment
                                .centerLeft, // Mengatur alignment container ke kiri
                            child: Text(
                              widget.pengasuh.deskripsi,
                              textAlign: TextAlign
                                  .left, // Mengatur teks agar rata kiri
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 16.0),
                          child: Text(
                            'Pengalaman',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF7A8F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '${widget.pengasuh.pengalaman} Tahun dengan bayi dan anak-anak.',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 16.0),
                          child: Text(
                            'Umur',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF7A8F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '${widget.pengasuh.umur} Tahun',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 16.0),
                          child: Text(
                            'Sertifikasi',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF7A8F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            widget.pengasuh.sertifikasi,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 16.0),
                          child: Text(
                            'Menurut Orang Tua Lainnya',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF7A8F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    FutureBuilder<List<Ulasan>>(
                      future: futureUlasan,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(70.0),
                              child: Text(
                                'Belum ada ulasan',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 156, 156, 156),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String imageUrl = snapshot.data![index].foto_user
                                  .split('/')
                                  .last;
                              bool isImageAvailable = imageUrl.isNotEmpty;

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: isImageAvailable
                                              ? Image.network(
                                                  'http://127.0.0.1:8000/getimage/$imageUrl',
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'image/reviewer.jpg',
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index].nama,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                snapshot.data![index].ulasan,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingForm(
                        id_pengasuh: widget.pengasuh.idPengasuh.toString(),
                        nama_pengasuh: widget.pengasuh.nama,
                        foto_pengasuh: 'http://127.0.0.1:8000/getimage/' +
                            widget.pengasuh.fotoPengasuh.split('/').last,
                        id_user: widget.id_user.toString(),
                      ),
                    ),
                  );
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
                child: Text(
                  'BOOKING',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
