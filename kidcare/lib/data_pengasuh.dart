class Pengasuh {
  final int idPengasuh;
  final String nama;
  final String tglLahir;
  final String alamat;
  final String sertifikasi;
  final String pengalaman;
  final int tarif;
  final String email;
  final String telp;
  final String fotoPengasuh;
  final String password;
  final int umur;
  final String deskripsi;

  Pengasuh({
    required this.idPengasuh,
    required this.nama,
    required this.tglLahir,
    required this.alamat,
    required this.sertifikasi,
    required this.pengalaman,
    required this.tarif,
    required this.email,
    required this.telp,
    required this.fotoPengasuh,
    required this.password,
    required this.umur,
    required this.deskripsi,
  });

  factory Pengasuh.fromList(List<dynamic> list) {
    return Pengasuh(
      idPengasuh: list[0] as int,
      nama: list[1] ?? '',
      tglLahir: list[2] ?? '',
      alamat: list[3] ?? '',
      sertifikasi: list[4] ?? '',
      pengalaman: list[5] ?? '',
      tarif: list[6] as int? ?? 0,
      email: list[7] ?? '',
      telp: list[8] ?? '',
      fotoPengasuh: list[9] ?? '',
      password: list[10] ?? '',
      umur: list[11] as int? ?? 0,
      deskripsi: list[12] ?? '',
    );
  }
}
