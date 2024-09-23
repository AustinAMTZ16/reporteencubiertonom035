import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reporteencubiertonom035/presentacion/view/pages/home_page.dart';
import 'package:reporteencubiertonom035/presentacion/view/widgets/forms/description_form.dart';
import 'package:reporteencubiertonom035/presentacion/view/widgets/forms/request_form.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../data/api/api_data.dart';
import '../../../data/api/models/solicitud.dart';
import 'forms/files_form.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class ComplaintWidget extends StatefulWidget {
  final String empresaId;

  const ComplaintWidget({super.key, required this.empresaId});

  @override
  State<ComplaintWidget> createState() => _ComplaintWidgetState();
}

class _ComplaintWidgetState extends State<ComplaintWidget> {
  Map<String, dynamic> _requestFormValues = {};
  Map<String, dynamic> _descriptionFormValues = {};
  Map<String, dynamic> _filesFormValues = {};
  final List<bool> _stepCompleted = [false, false, false];
  late String _idEmpresa = "";
  late int _idRegistro = 0;
  bool _isButtonEnabled = true;

  List<StepState> _stepStates = [
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
  ];

  void _validateData() {
    bool validationSuccess = true;
    setState(() {
      if (_requestFormValues['idComplaintType'] == "") {
        validationSuccess = false;
        _stepStates[0] = StepState.error;
      } else {
        _stepStates[0] = StepState.complete;
      }

      if (_requestFormValues['idSucursal'] == "") {
        validationSuccess = false;
        _stepStates[0] = StepState.error;
      } else {
        _stepStates[0] = StepState.complete;
      }

      if (_descriptionFormValues['detalle'].trim().isEmpty) {
        validationSuccess = false;
        _stepStates[1] = StepState.error;
      } else {
        _stepStates[1] = StepState.complete;
      }
    });

    if (validationSuccess) {
      _saveFormData();
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  void _updateStepCompletion(int stepIndex, bool isCompleted) {
    setState(() {
      _stepCompleted[stepIndex] = isCompleted;
    });
  }

  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stepper(
                physics: const BouncingScrollPhysics(),
                type: StepperType.vertical,
                currentStep: _currentStep,
                onStepTapped: _setStep,
                controlsBuilder: (context, details) {
                  return const SizedBox();
                },
                steps: [
                  Step(
                    isActive: _currentStep == 0,
                    state: _stepStates[0],
                    title: const Text("Lugar"),
                    subtitle: const Text(
                        "Ingresa la información del lugar donde ocurrieron los eventos"),
                    content: RequestForm(
                      idEmpresa: widget.empresaId,
                      onValidData: (value) {
                        _idEmpresa = widget.empresaId;
                        _updateStepCompletion(0, true);
                        setState(() {
                          _requestFormValues = value;
                        });
                        _setStep(1);
                      },
                    ),
                  ),
                  Step(
                      isActive: _currentStep == 1,
                      state: _stepStates[1],
                      title: const Text("Reporte"),
                      subtitle: const Text(
                          "Aquí puedes describir detalladamente lo sucedido"),
                      content: DescriptionForm(
                        onValidData: (value) {
                          _updateStepCompletion(1, true);
                          _updateStepCompletion(2, true);
                          setState(() {
                            _descriptionFormValues = value;
                          });
                          _setStep(2);
                        },
                      )),
                  Step(
                      isActive: _currentStep == 2,
                      state: _stepStates[2],
                      title: const Text("Evidencia"),
                      subtitle: const Text(
                          "Si cuentas con evidencia, esta sección puede ingresar un archivo, imágen, audio o video."),
                      content: FilesForm(
                        onValidData: (File file) {
                          // _updateStepCompletion(2, true);
                          setState(() {
                            _filesFormValues = {
                              "archivos": file,
                            };
                          });
                          _setStep(3);
                        },
                      )),
                ]),
          ),
          ElevatedButton(
            onPressed:
                _stepCompleted.every((step) => step == true) && _isButtonEnabled
                    ? _validateData
                    : null,
            child: const Text("Validar y enviar datos"),
          ),
        ],
      ),
    );
  }

  void _setStep(int step) {
    if (step >= 0 && step < 3) {
      setState(() {
        _currentStep = step;
      });
    }
  }

  void _showSnackBarExito(BuildContext context, ContentType contentType,
      String title, String message,
      {bool shouldGoToHomePage = false}) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 1),
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar).closed.then((reason) {
        if (shouldGoToHomePage) {
          Future.delayed(const Duration(seconds: 1), () {
            // ignore: use_build_context_synchronously
            _showSnackBar(
                context,
                ContentType.success,
                'Gracias por usar la APP',
                'Reporte Encubierto es un mecanismo seguro y confidencial.',
                shouldGoToHomePage: true);
          });
        }
      });
  }

  void _showSnackBar(BuildContext context, ContentType contentType,
      String title, String message,
      {bool shouldGoToHomePage = false}) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      content: AwesomeSnackbarContent(
        titleFontSize: 12,
        messageFontSize: 10,
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar).closed.then((reason) {
        if (shouldGoToHomePage) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          });
        }
      });
  }

  Future<void> _saveFormData() async {
    File? file = _getFilesFormValue();
    Solicitud solicitud = _createSolicitud(file);
    Map<String, dynamic> solicitudJson = solicitud.toJson();
    int idRegistro = await ApiData.postSolicitud(solicitudJson);

    if (idRegistro > 0) {
      _idRegistro = idRegistro;
      file != null ? _saveFormFiles(idRegistro) : _updateFormData("ND");
    } else {
      // ignore: use_build_context_synchronously
      _showSnackBar(context, ContentType.failure, 'Error',
          'Error al guardar la solicitud.');
    }
  }

  File? _getFilesFormValue() {
    return _filesFormValues.isNotEmpty ? _filesFormValues['archivos'] : null;
  }

  Solicitud _createSolicitud(File? file) {
    return Solicitud(
      idReporte: 0,
      idEmpresa: _idEmpresa.toString(),
      idReporteEncubiertoTipoHecho:
          _requestFormValues['idComplaintType'].toString(),
      idSucursal: _requestFormValues['idSucursal'].toString(),
      fechaHechos: _requestFormValues['date'],
      fechaDenuncia: DateTime.now().toString(), //_requestFormValues['date'],
      denunciante: _requestFormValues['complainantName'],
      reportado: _requestFormValues['denouncedName'],
      lugar: _descriptionFormValues['lugar'],
      archivos: file?.path ??
          '', // Si file?.path es null, se asignará una cadena vacía
      detalle: _descriptionFormValues['detalle'],
      estado: "Nuevo",
    );
  }

  Future<void> _updateFormData(String nameFile) async {
    Solicitud solicitud = _createUpdatedSolicitud(nameFile);
    Map<String, dynamic> solicitudJson = solicitud.toJson();
    bool response = await _putSolicitud(solicitudJson);

    if (response) {
      // ignore: use_build_context_synchronously
      String cadenasalida =
          'Felicidades Solicitud guardada con Folio #$_idRegistro.';
      _showSnackBarExito(context, ContentType.success, 'Felicidades',
          'Solicitud guardada con Folio #$_idRegistro.',
          shouldGoToHomePage: true);
      // showTopSnackBar(
      //               Overlay.of(context),
      //                CustomSnackBar.info(
      //                 message:
      //                    cadenasalida,
      //               ),
      //             );
      _resetForms();
      _setStep(0);
    } else {
      // ignore: use_build_context_synchronously
      _showSnackBar(context, ContentType.failure, 'Error',
          'Error al guardar la solicitud.');
    }
  }

  Solicitud _createUpdatedSolicitud(String nameFile) {
    return Solicitud(
      idReporte: _idRegistro,
      idEmpresa: _idEmpresa.toString(),
      idReporteEncubiertoTipoHecho:
          _requestFormValues['idComplaintType'].toString(),
      idSucursal: _requestFormValues['idSucursal'].toString(),
      fechaHechos: _requestFormValues['date'],
      fechaDenuncia: DateTime.now().toString(), //_requestFormValues['date'],
      denunciante: _requestFormValues['complainantName'],
      reportado: _requestFormValues['denouncedName'],
      lugar: _descriptionFormValues['lugar'],
      archivos: nameFile,
      detalle: _descriptionFormValues['detalle'],
      estado: "Nuevo",
    );
  }

  Future<bool> _putSolicitud(Map<String, dynamic> solicitudJson) async {
    return await ApiData.putSolicitud(solicitudJson);
  }

  Future<void> _saveFormFiles(int idSolicitud) async {
    File originalFile = _filesFormValues['archivos'];

    String fileExtension = originalFile.path.split('.').last;
    String newFileName = '$idSolicitud.$fileExtension';
    String newPath = '${originalFile.parent.path}/$newFileName';
    File copiedFile = await originalFile.copy(newPath);
    await originalFile.delete();
    Map<String, dynamic> filesJson = {'archivos': copiedFile};
    bool response = await ApiData.postFiles(filesJson);

    if (response) {
      _updateFormData(newFileName);
    } else {
      // ignore: use_build_context_synchronously
      _showSnackBar(context, ContentType.failure, 'Error',
          'Error al guardar el documento adjunto.');
    }
  }

  void _resetForms() {
    setState(() {
      _requestFormValues = {};
      _descriptionFormValues = {};
      _filesFormValues = {};
      _stepStates = [
        StepState.indexed,
        StepState.indexed,
        StepState.indexed,
        StepState.indexed,
      ];
      _isButtonEnabled = false;
      _idRegistro = 0;
    });
  }
}
