import 'dart:convert' show json;

TipoDenuncia tipoDenunciaFromJson(String str) =>
    TipoDenuncia.fromJson(json.decode(str));

String tipoDenunciaToJson(TipoDenuncia data) => json.encode(data.toJson());

List<TipoDenuncia> tiposDenunciasFromJson(String str) =>
    List<TipoDenuncia>.from(
        json.decode(str).map((x) => TipoDenuncia.fromJson(x)));

class TipoDenuncia {
  TipoDenuncia(
      {required this.id, required this.descripcion, required this.detalle});

  int id;
  String descripcion;
  String detalle;

  factory TipoDenuncia.fromJson(Map<String, dynamic> json) => TipoDenuncia(
      id: int.parse(json["id_reporte_encubierto_tipo_hecho"]),
      descripcion: json["descripcion"],
      detalle: json["detalle"]);

  Map<String, dynamic> toJson() => {
        "id_reporte_encubierto_tipo_hecho": id,
        "descripcion": descripcion,
        detalle: "detalle"
      };
}
