class Booking {
  final int idBooking;
  final String namaPengasuh;
  final String tglMulai;
  final String tglSelesai;
  final String waktuMulai;
  final String waktuSelesai;
  final String daftarKegiatan;
  final String catatan;
  final String patokanRumah;
  final int idPengasuh;
  final int idUser;
  final String namaAnak;
  final String umurAnak;
  final String status;

  Booking({
    required this.idBooking,
    required this.namaPengasuh,
    required this.tglMulai,
    required this.tglSelesai,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.daftarKegiatan,
    required this.catatan,
    required this.patokanRumah,
    required this.idPengasuh,
    required this.idUser,
    required this.namaAnak,
    required this.umurAnak,
    required this.status,
  });

  factory Booking.fromJson(List<dynamic> json) {
    return Booking(
      idBooking: json[0] as int,
      namaPengasuh: json[1] as String,
      tglMulai: json[2] as String,
      tglSelesai: json[3] as String,
      waktuMulai: json[4] as String,
      waktuSelesai: json[5] as String,
      daftarKegiatan: json[6] as String,
      catatan: json[7] as String,
      patokanRumah: json[8] as String,
      idPengasuh: json[9] as int,
      idUser: json[10] as int,
      namaAnak: json[11] as String,
      umurAnak: json[12] as String,
      status: json[13] as String,
    );
  }
}
