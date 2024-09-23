import 'dart:convert';

List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  Usuario({
    required this.password,
    required this.email,
    required this.status,
    required this.facebook,
    required this.gestion,
    required this.googlePlus,
    required this.idDireccion,
    required this.idEmpresa,
    required this.idGiro,
    required this.idStand,
    required this.idTest,
    required this.idUsuario,
    required this.linkedin,
    required this.nombreComercial,
    required this.patrocinador,
    required this.razonSocial,
    required this.rfc,
    required this.sitioWeb,
    required this.telefono,
    required this.terminosCondiciones,
    required this.tipo,
    required this.twitter,
    required this.youtube,
  });

  final String password;
  final String email;
  final String status;
  final String facebook;
  final String gestion;
  final String googlePlus;
  final String idDireccion;
  final String idEmpresa;
  final String idGiro;
  final String? idStand;
  final String? idTest;
  final String idUsuario;
  final String linkedin;
  final String nombreComercial;
  final String patrocinador;
  final String razonSocial;
  final String rfc;
  final String? sitioWeb;
  final String telefono;
  final String terminosCondiciones;
  final String tipo;
  final String twitter;
  final String youtube;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        password: json["contrasena_reporte_ecubierto"],
        email: json["correo"],
        status: json["estado"],
        facebook: json["facebook"],
        gestion: json["gestion"],
        googlePlus: json["googleplus"],
        idDireccion: json["iddireccion"],
        idEmpresa: json["idempresa"],
        idGiro: json["idgiro"],
        idStand: json["idstand"],
        idTest: json["idtest"],
        idUsuario: json["idusuario"],
        linkedin: json["linkedin"],
        nombreComercial: json["nombre_comercial"],
        patrocinador: json["patrocinador"],
        razonSocial: json["razon_social"],
        rfc: json["RFC"],
        sitioWeb: json["sitio_web"],
        telefono: json["telefono"],
        terminosCondiciones: json["terminos_condiciones"],
        tipo: json["tipo"],
        twitter: json["twitter"],
        youtube: json["youtube"],
      );

  Map<String, dynamic> toJson() => {
        "contrasena_reporte_ecubierto": password,
        "correo": email,
        "estado": status,
        "facebook": facebook,
        "gestion": gestion,
        "googleplus": googlePlus,
        "iddireccion": idDireccion,
        "idempresa": idEmpresa,
        "idgiro": idGiro,
        "idstand": idStand,
        "idtest": idTest,
        "idusuario": idUsuario,
        "linkedin": linkedin,
        "nombre_comercial": nombreComercial,
        "patrocinador": patrocinador,
        "razon_social": razonSocial,
        "RFC": rfc,
        "sitio_web": sitioWeb,
        "telefono": telefono,
        "terminos_condiciones": terminosCondiciones,
        "tipo": tipo,
        "twitter": twitter,
        "youtube": youtube,
      };
}
