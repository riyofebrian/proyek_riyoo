class SiswaModel {
  final int id;
  final String nis, nama, tplahir, tglahir, kelamin, agama, alamat;

  SiswaModel({
    required this.id,
    required this.nis,
    required this.nama,
    required this.tplahir,
    required this.tglahir,
    required this.kelamin,
    required this.agama,
    required this.alamat,
  });

  factory SiswaModel.fromJson(Map<String, dynamic> json) {
    return SiswaModel(
      id: json['id'],
      nis: json['nis'],
      nama: json['nama'],
      tplahir: json['tplahir'],
      tglahir: json['tglahir'],
      kelamin: json['kelamin'],
      agama: json['agama'],
      alamat: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nis': nis,
    'nama': nama,
    'tplahir': tplahir,
    'tglahir': tglahir,
    'kelamin': kelamin,
    'agama': agama,
    'alamat': alamat,
  };
}
