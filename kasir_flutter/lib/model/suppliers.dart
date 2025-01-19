class SuppliersModel {
  final int? id_sup;
  final String nama;
  final String alamat;
  final String no_hp;

  SuppliersModel({
    this.id_sup,
    required this.nama,
    required this.alamat,
    required this.no_hp,
  });

  factory SuppliersModel.fromJson(Map<String, dynamic> json) {
    return SuppliersModel(
      id_sup: json['id_sup'],
      nama: json['nama'],
      alamat: json['alamat'],
      no_hp: json['no_hp'],
    );
  }
}
