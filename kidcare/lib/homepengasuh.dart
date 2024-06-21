import 'package:flutter/material.dart';
import 'data_booking.dart';
import 'book_aktivitas.dart'; // Import file BookingService
import 'option.dart';
import 'tambah_aktivitas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KIDCARE',
      debugShowCheckedModeBanner: false,
      home: HomePengasuh(
          id_pengasuh: 1), // Contoh id_pengasuh, sesuaikan dengan kebutuhan
    );
  }
}

class HomePengasuh extends StatefulWidget {
  final int id_pengasuh;

  HomePengasuh({required this.id_pengasuh});

  @override
  _HomePengasuhState createState() => _HomePengasuhState();
}

class _HomePengasuhState extends State<HomePengasuh> {
  late Future<List<Booking>> futureBookings;

  @override
  void initState() {
    super.initState();
    futureBookings =
        BookingService.fetchBookingsByPengasuhId(widget.id_pengasuh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // Set this height as needed
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20), // Adjust the radius as needed
          ),
          child: AppBar(
            backgroundColor: const Color(0xFFFF7A8F),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OptionPage()),
                  );
                },
              ),
            ],
            flexibleSpace: const Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 5.0), // Add padding to adjust the position
                child: Text(
                  'Data Booking',
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
      body: FutureBuilder<List<Booking>>(
        future: futureBookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bookings found'));
          } else {
            List<Booking> bookings = snapshot.data!;

            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                Booking booking = bookings[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 5.0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(
                        booking.namaAnak,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Umur Anak: ${booking.umurAnak} tahun',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 13),
                          ),
                          Text(
                            'Tanggal Mulai: ${booking.tglMulai}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 13),
                          ),
                          Text(
                            'Status: ${booking.status}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 13),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddAktivitasScreen(
                                  id_pengasuh: booking.idPengasuh,
                                  id_user: booking.idUser,
                                  namaAnak: booking.namaAnak,
                                  id_booking: booking.idBooking),
                            ),
                          );
                        },
                        child: Text(
                          'Detail',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              fontSize: 13),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: const Color(0xFFFF7A8F),
                          foregroundColor: Colors.white, // Button text color
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
