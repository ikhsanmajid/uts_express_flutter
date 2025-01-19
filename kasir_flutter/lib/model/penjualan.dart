class PenjualanModel {
  final int? id;
  final int nonota;
  final String nobarcode;
  final int jumlah;

  PenjualanModel({
    this.id,
    required this.nonota,
    required this.nobarcode,
    required this.jumlah,
  });

  factory PenjualanModel.fromJson(Map<String, dynamic> json) {
    return PenjualanModel(
      id: json['id'],
      nonota: json['nonota'],
      nobarcode: json['nobarcode'],
      jumlah: json['jumlah'],
    );
  }
}
