import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:reporteencubiertonom035/data/api/api_data.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginForm extends StatefulWidget {
  final Function(String value) onValidData;
  final GlobalKey<FormState> formKey;
  const LoginForm({
    super.key,
    required this.onValidData,
    required this.formKey,
  });
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _password = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isScanning = false;
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;
  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Permiso denegado'),
          content: const Text(
              'Para poder escanear códigos QR, necesitas otorgar permisos de cámara.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenSize.height * 0.10),
          //WelcomeWidget(screenSize: screenSize),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.15,
              vertical: screenSize.height * 0.03,
            ),
            child: TextFormField(
              controller: _password,
              decoration:
                  const InputDecoration(labelText: "Contraseña de la Empresa"),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "La contraseña es requerida";
                }
                return null;
              },
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Wrap(
            spacing: 5,
            children: [
              TextButton.icon(
                  onPressed: () async {
                    await _validate();
                  },
                  icon: const Icon(Icons.login_rounded),
                  label: const Text("Iniciar sesion")),
              TextButton.icon(
                  onPressed: () {
                    // await _scanQR();
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) {
                          setState(() {
                            this.code = code;
                            _password.text = code ?? "";
                          });
                        });
                  },
                  icon: const Icon(Icons.qr_code_2_rounded),
                  label: const Text("Escanear"))
            ],
          ),
          // SizedBox(height: screenSize.height * 0.05),
          TextButton(
              onPressed: () {
                _launchURL();
              },
              child: Text(
                "Politicas de privacidad",
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ))
        ],
      ),
    );
  }

  _launchURL() async {
    if (await canLaunchUrl(
        Uri.parse('https://nom035.administrabajo.com/avisoprivacidad.html'))) {
      await launchUrl(
          Uri.parse('https://nom035.administrabajo.com/avisoprivacidad.html'));
    } else {
      await launchUrl(
          Uri.parse('https://nom035.administrabajo.com/avisoprivacidad.html'));
    }
  }

  Future _login(String password) async {
    try {
      final idEmpresa = await ApiData().login(password);
      widget.onValidData(idEmpresa);
    } catch (e) {
      //
    }
  }

  Future _validate() async {
    if (widget.formKey.currentState != null &&
        widget.formKey.currentState!.validate()) {
      await _login(_password.text);
    }
  }
}
