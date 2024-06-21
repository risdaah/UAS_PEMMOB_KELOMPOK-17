// import 'package:flutter/material.dart';
// import 'package:kidcare/homepengasuh.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'data_pengasuh.dart';
// import 'data_ulasan.dart';

// Future<List<Ulasan>> fetchUlasan(int idPengasuh) async {
//   final response = await http
//       .get(Uri.parse('http://127.0.0.1:8000/ulasan_pengguna/$idPengasuh'));

//   if (response.statusCode == 200) {
//     Map<String, dynamic> jsonResponse = json.decode(response.body);
//     List<dynamic> ulasanJsonList = jsonResponse['data'];
//     return ulasanJsonList.map((ulasan) => Ulasan.fromJson(ulasan)).toList();
//   } else {
//     return [];
//   }
// }

// class DetailTugasPage extends StatefulWidget {
//   final Pengasuh pengasuh;
//   final String id_user;

//   DetailTugasPage({required this.pengasuh, required this.id_user});

//   @override
//   _DetailTugasPageState createState() => _DetailTugasPageState();
// }

// class _DetailTugasPageState extends State<DetailTugasPage> {
//   // late Future<List<Ulasan>> futureUlasan;

//   @override
//   void initState() {
//     super.initState();
//     // futureUlasan = fetchUlasan(widget.pengasuh.idPengasuh);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           color: const Color(0xFFFF7A8F),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(left: 16.0),
//                             child: Text(
//                               'DETAIL ORANG TUA',
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 25,
//                                 color: Color(0xFFFF7A8F),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           const Padding(
//                             padding: EdgeInsets.only(left: 16.0),
//                             child: Text(
//                               '',
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(100.0),
//                             child: Image.asset(
//                               'image/reviewer.jpg',
//                               width: 100,
//                               height: 100,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   )),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Column(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Tanggal Mulai',
//                                   // bookingData['tgl_mulai']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Tanggal Selesai',
//                                   // bookingData['tgl_selesai']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Waktu Mulai',
//                                   // bookingData['waktu_mulai']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Waktu Selesai',
//                                   // bookingData['waktu_selesai']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Nama Anak',
//                                   // bookingData['nama_anak']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Umur Anak',
//                                   // bookingData['umur_anak']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Daftar Kegiatan',
//                                   // bookingData['daftar_kegiatan']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Catatan',
//                                   // bookingData['catatan']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Alamat',
//                                   // bookingData['patokan_rumah']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'Detail Alamat',
//                                   // bookingData['patokan_rumah']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'id_pengasuh',
//                                   // bookingData['id_pengasuh']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'id_user',
//                                   // bookingData['id_user']
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 5.0, right: 5.0),
//                                 child: _buildInfoItem(
//                                   context,
//                                   'status',
//                                   // bookingData['status']
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           const Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 5.0,
//                                     left: 30.0,
//                                     right: 30.0,
//                                     bottom: 20.0),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       'TOTAL PEMBAYARAN',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFFFF7A8F),
//                                       ),
//                                     ),
//                                     Expanded(
//                                         child:
//                                             SizedBox()), // Widget kosong sebagai spacer
//                                     Text(
//                                       '1.000.000',
//                                       style: TextStyle(
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFFFF7A8F),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.only(bottom: 20.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFFFF7A8F),
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 20, horizontal: 50),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => HomePengasuh()),
//                                     );
//                                   },
//                                   // Nanti muncul notif di ortu
//                                   child: const Text(
//                                     'Aktivitas Selesai',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFFFF7A8F),
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 20, horizontal: 50),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   // Nanti statusnya berganti ke Selesai
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => HomePengasuh()),
//                                     );
//                                   },
//                                   child: const Text(
//                                     'Tugas Selesai',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoItem(BuildContext context, String label) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//       child: Container(
//         width: screenWidth - 40, // Menggunakan lebar layar - padding horizontal
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//               color: const Color.fromARGB(255, 188, 188, 188).withOpacity(0.5),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 0),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 color: Color(0xFFFF7A8F),
//                 fontSize: 12,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             const Text(
//               'Temp',
//               // value,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
