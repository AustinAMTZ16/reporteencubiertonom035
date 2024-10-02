import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reporteencubiertonom035/data/api/models/tipo_denuncia.dart';
import 'package:reporteencubiertonom035/data/api/models/usuario.dart';
import 'models/sucursal.dart';
import 'dart:io';

class ApiData {
  static String baseUrl = "http://143.198.131.18";

  ///ReporteEncubierto/catalogoTiposReporte.php

/*Login */
  Future<String> login(String password) async {
    // final passwordParam = password.contains('"')
    //     ? Uri.encodeQueryComponent(password)
    //     : Uri.encodeQueryComponent('"$password"');

    final passwordParam = Uri.encodeQueryComponent('"$password"');

    final url = Uri.parse(
        '$baseUrl/ReporteEncubierto/accesoReporteEncubierto.php?contrasena_reporte_ecubierto=$passwordParam');

    final response = await http.get(url);

    print('Generated URL: $url');

    if (response.statusCode == 200) {
      final usuarios = usuarioFromJson(response.body.toString());

      if (usuarios.isNotEmpty) {
        final usuario = usuarios.first;
        final idEmpresas = usuario.idEmpresa;
        return idEmpresas;
      }
    } else {
      throw Exception('Fallo en la solicitud de la URL: $url');
      //return response.body.message();
    }

    return "0";
  }

/*Obtiene Todo Listado de Sucursales */
  static Future<List<Sucursal>> obtenerSucursales(String idEmpresa) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/ReporteEncubierto/catalogoSucursales.php?id_empresa=$idEmpresa'));

    if (response.statusCode == 200) {
      final List<dynamic> sucursalesJson = json.decode(response.body);
      return sucursalesJson
          .map((sucursalJson) => Sucursal.fromJson(sucursalJson))
          .toList();
    } else {
      throw Exception('Failed to load sucursales');
    }
  }

/*Obtiene Listado de Sucursales filtrado por IdEmpresa*/
  Future<List<Sucursal>> obtenerSucursal(int idEmpresa) async {
    final response = await http.get(Uri.parse(
        "$baseUrl/ReporteEncubierto/catalogoSucursales.php?id_empresa=$idEmpresa"));
    if (response.statusCode == 200) {
      final List<dynamic> sucursalesJson = json.decode(response.body);
      return sucursalesJson
          .map((sucursalJson) => Sucursal.fromJson(sucursalJson))
          .toList();
    } else {
      throw Exception('Failed to load sucursales');
    }
  }

/*Obtiene Todo Listado de Tipo de Denuncisa */
/* Obtiene Todo Listado de Tipo de Denuncisa */
  static Future<List<TipoDenuncia>> obtenerTipoDenuncias() async {
    final response = await http
        .get(Uri.parse("$baseUrl/ReporteEncubierto/catalogoTiposReporte.php"));

    if (response.statusCode == 200) {
      final List<dynamic> tipoDenunciaJson = json.decode(response.body);
      List<TipoDenuncia> tipoDenuncias = tipoDenunciaJson
          .map((tipoDenunciaJson) => TipoDenuncia.fromJson(tipoDenunciaJson))
          .toList();

      // Ordena la lista de tipoDenuncias por el atributo 'nombre'
      tipoDenuncias.sort((a, b) => a.descripcion.compareTo(b.descripcion));

      return tipoDenuncias;
    } else {
      throw Exception('Failed to load tipo de denuncias');
    }
  }

/*Insert Denuncia*/
  static Future<int> postSolicitud(Map data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ReporteEncubierto/insertReporteEncubierto.php'),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Intenta convertir la respuesta en un entero
      int jsonResponse;
      try {
        jsonResponse = int.parse(response.body);
      } catch (e) {
        return 0;
      }
      // Retorna directamente la respuesta como un entero
      return jsonResponse;
    } else {
      return 0;
    }
  }

/*Update Denuncia*/
  static Future<bool> putSolicitud(Map data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/ReporteEncubierto/updateReporteEncubierto.php'),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

/*Insert Files */
  static Future<bool> postFiles(Map<String, dynamic> data) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('$baseUrl/ReporteEncubierto/insertReporteEncubierto.php'));

    File file = data['archivos'];
    request.files.add(await http.MultipartFile.fromPath('archivos', file.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
