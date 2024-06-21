import 'package:flutter/material.dart';
import 'home.dart';
import 'notif_service.dart';
import 'data_aktivitas.dart';

class NotificationPage extends StatefulWidget {
  final String id_user;

  NotificationPage({required this.id_user});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<Aktivitas>> _aktivitasFuture;

  @override
  void initState() {
    super.initState();
    _aktivitasFuture =
        NotifService.fetchotifByUserId(int.parse(widget.id_user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFF7A8F),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
      body: FutureBuilder<List<Aktivitas>>(
        future: _aktivitasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No activities found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Aktivitas aktivitas = snapshot.data![index];
                return NotificationCard(
                  title: aktivitas.aktivitas,
                  reporter: aktivitas.id_pengasuh.toString(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String reporter;

  NotificationCard({required this.title, required this.reporter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          leading: const Icon(
            Icons.notifications,
            color: Color(0xFFFF7A8F),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            reporter,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
