class ModelMaterOutlet {
  dynamic kodeOut;
  dynamic namaOut;

  ModelMaterOutlet({this.kodeOut, this.namaOut});

  ModelMaterOutlet.fromJson(Map<String, dynamic> json) {
    kodeOut = json['kode_out'];
    namaOut = json['nama_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_out'] = this.kodeOut;
    data['nama_out'] = this.namaOut;
    return data;
  }
}
