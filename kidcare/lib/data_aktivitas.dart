class Aktivitas {
  final int id_aktivitas;
  final String aktivitas;
  final int id_pengasuh;
  final int id_user;

  Aktivitas({
    required this.id_aktivitas,
    required this.aktivitas,
    required this.id_pengasuh,
    required this.id_user,
  });

  factory Aktivitas.fromJson(List<dynamic> json) {
    return Aktivitas(
      id_aktivitas: json[0] as int,
      aktivitas: json[1] as String,
      id_pengasuh: json[2] as int,
      id_user: json[3] as int,
    );
  }
}
