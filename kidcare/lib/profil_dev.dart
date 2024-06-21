import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kidcare/home.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilDev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(50.0), // Set this height as needed
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20), // Adjust the radius as needed
            ),
            child: AppBar(
              backgroundColor: const Color(0xFFFF7A8F),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(id_user: '1'),
                    ),
                  );
                },
              ),
              flexibleSpace: const Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 5.0), // Add padding to adjust the position
                  child: Text(
                    'Profil Developer',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            biodataCard(
              'Biodata Anggota 1',
              'image/talia.jpg',
              'Nama : Talia Aprianti',
              'TTL : Surabaya, 14 April 2004',
              'Alamat : Perum. Taman Puspa Sari Candi-Sidoarjo',
              'No : 083849727449',
              'Riwayat Pendidikan : SMKN 2 Buduran',
              'Prestasi : Juara 2 Lomba UI Koperasi Sekolah',
              '22082010035@student.upnjatim.ac.id',
              'https://github.com/Talia-Apr',
            ),
            biodataCard(
              'Biodata Anggota 2',
              'image/risda.jpg',
              'Nama : Risda Rahmawati Harsono',
              'TTL : Sidoarjo, 01 Februari 2004',
              'Alamat : Kali Tengah, Tanggulangin-Sidoarjo',
              'No : 0895326442194 / 087753396348',
              'Riwayat Pendidikan : SMKN 2 Buduran',
              'Prestasi : Juara 2 LKS AI Wilker 1 Jawa Timur',
              '22082010040@student.upnjatim.ac.id',
              'https://github.com/risdaah',
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 223, 228),
          ),
          child: const Center(
            child: Text(
              'Copyright © 2024 | All Rights Reserved | Kelompok 17',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFFFF7A8F),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget biodataCard(
    String title,
    String imagePath,
    String name,
    String ttl,
    String address,
    String phone,
    String education,
    String achievement,
    String email,
    String githubUrl,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: Card(
        color: Colors.white, // Set background color of the card to white
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    15.0), // Anda bisa menyesuaikan nilai ini
                child: Image.asset(
                  imagePath,
                  width: 130,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFFF7A8F),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      ttl,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      address,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      education,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      achievement,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 3.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _launchEmail(email);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF7A8F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _launchGitHub(githubUrl);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF7A8F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.github,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'GitHub',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchGitHub(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Email',
        'body': 'Mengirim Email',
      },
    );
    final String uri = _emailLaunchUri.toString();
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
