import 'package:flutter/material.dart';

class HomeAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 40); // Mengurangi tinggi lengkungan awal
    // Lengkungan pertama ke atas dengan kurva lebih halus
    path.quadraticBezierTo(
      size.width / 15, size.height - 100, // Kontrol ke atas
      size.width / 2, size.height - 40, // Kembali ke bawah ke tengah
    );
    // Lengkungan kedua ke bawah dengan kurva lebih halus
    path.quadraticBezierTo(
      size.width * 4 / 4, size.height - 20, // Kontrol ke bawah
      size.width, size.height - 100, // Kembali ke atas ke kanan
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}