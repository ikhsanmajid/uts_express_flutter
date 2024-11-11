class ProductsModel {
  late final String nobarcode;
  late final String nama;
  late final int harga;
  late final int stok;

  ProductsModel({
    required this.nobarcode,
    required this.nama,
    required this.harga,
    required this.stok,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      nobarcode: json['nobarcode'],
      nama: json['nama'],
      harga: json['harga'],
      stok: json['stok'],
    );
  }
}
