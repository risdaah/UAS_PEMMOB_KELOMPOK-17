import 'dart:convert';
import 'package:http/http.dart' as http;
import 'data_booking.dart';

class BookingService {
  static Future<List<Booking>> fetchAllBookings() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/tampilkan_semua_booking'));

    if (response.statusCode == 200) {
      List<dynamic> bookingJsonList = json.decode(response.body)['data'];
      return bookingJsonList
          .map((bookingJson) => Booking.fromJson(bookingJson))
          .toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  static Future<List<Booking>> fetchBookingsByUserId(int userId) async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/tampilkan_booking_tertentu/?id_user=$userId'));

    if (response.statusCode == 200) {
      List<dynamic> bookingJsonList = json.decode(response.body)['data'];
      return bookingJsonList
          .map((bookingJson) => Booking.fromJson(bookingJson))
          .toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}
