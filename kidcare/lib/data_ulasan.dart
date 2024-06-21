class Ulasan {
  final int idUlasan;
  final String ulasan;
  final int idPengasuh;
  final int idUser;
  final String nama;
  final String foto_user;

  Ulasan({
    required this.idUlasan,
    required this.ulasan,
    required this.idPengasuh,
    required this.idUser,
    required this.nama,
    required this.foto_user,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) {
    return Ulasan(
      idUlasan: json['idUlasan'] as int? ?? 0,
      ulasan: json['ulasan'] as String? ?? '',
      idPengasuh: json['idPengasuh'] as int? ?? 0,
      idUser: json['idUser'] as int? ?? 0,
      nama: json['nama'] as String? ?? '',
      foto_user: json['foto_user'] as String? ?? '',
    );
  }
}
