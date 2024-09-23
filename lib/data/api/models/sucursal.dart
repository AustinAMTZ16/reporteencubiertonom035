import 'dart:convert';

Sucursal sucursalFromJson(String str) => Sucursal.fromJson(json.decode(str));

String sucursalToJson(Sucursal data) => json.encode(data.toJson());

List<Sucursal> sucursalesFromJson(String str) =>
    List<Sucursal>.from(json.decode(str).map((x) => Sucursal.fromJson(x)));

class Sucursal {
  Sucursal({required this.id, required this.nombre});

  int id;
  String nombre;

  factory Sucursal.fromJson(Map<String, dynamic> json) =>
      Sucursal(id: int.parse(json["id_sucursal"]), nombre: json["nombre"]);

  Map<String, dynamic> toJson() => {"id_sucursal": id, "nombre": nombre};
}
