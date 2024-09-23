import 'dart:convert';

List<Solicitud> filesFromJson(String str) =>
    List<Solicitud>.from(json.decode(str).map((x) => Files.fromJson(x)));

class Solicitud {
  final int idReporte;
  final String idEmpresa;
  final String idReporteEncubiertoTipoHecho;
  final String idSucursal;
  final String fechaDenuncia;
  final String fechaHechos;
  final String denunciante;
  final String reportado;
  final String lugar;
  final String archivos;
  final String detalle;
  final String estado;

  Solicitud({
    required this.idReporte,
    required this.idEmpresa,
    required this.idReporteEncubiertoTipoHecho,
    required this.idSucursal,
    required this.fechaDenuncia,
    required this.fechaHechos,
    required this.denunciante,
    required this.reportado,
    required this.lugar,
    required this.archivos,
    required this.detalle,
    required this.estado,
  });

  factory Solicitud.fromJson(Map<String, dynamic> json) {
    return Solicitud(
      idReporte: json['id_reporte'],
      idEmpresa: json['id_empresa'],
      idReporteEncubiertoTipoHecho: json['id_reporte_encubierto_tipo_hecho'],
      idSucursal: json['id_sucursal'],
      fechaDenuncia: json['fecha_denuncia'],
      fechaHechos: json['fecha_hechos'],
      denunciante: json['denunciante'],
      reportado: json['reportado'],
      lugar: json['lugar'],
      archivos: json['archivos'],
      detalle: json['detalle'],
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_reporte'] = idReporte;
    data['id_empresa'] = idEmpresa;
    data['id_reporte_encubierto_tipo_hecho'] = idReporteEncubiertoTipoHecho;
    data['id_sucursal'] = idSucursal;
    data['fecha_denuncia'] = fechaDenuncia;
    data['fecha_hechos'] = fechaHechos;
    data['denunciante'] = denunciante;
    data['reportado'] = reportado;
    data['lugar'] = lugar;
    data['archivos'] = archivos;
    data['detalle'] = detalle;
    data['estado'] = estado;
    return data;
  }
}

class Files {
  final List<Map<String, dynamic>> archivos;

  Files({this.archivos = const []});

  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
        archivos: json['archivos'] != null
            ? List<Map<String, dynamic>>.from(json['archivos'])
            : []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['archivos'] = archivos;
    return data;
  }
}
