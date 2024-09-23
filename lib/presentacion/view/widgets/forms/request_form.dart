import 'dart:async';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reporteencubiertonom035/data/api/models/tipo_denuncia.dart';

import '../../../../data/api/api_data.dart';
import '../../../../data/api/models/sucursal.dart';

class RequestForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onValidData;
  final String idEmpresa;

  const RequestForm({
    super.key,
    required this.onValidData,
    required this.idEmpresa,
  });

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final _requestFormKey = GlobalKey<FormState>();
  final TextEditingController _complainantNameField = TextEditingController();
  final TextEditingController _denouncedNameField = TextEditingController();
  final TextEditingController _complaintTypeField = TextEditingController();
  final TextEditingController _dateField = TextEditingController();
  final Map<String, dynamic> _formData = {};

  final format = DateFormat("yyyy-MM-dd HH:mm");

  late List<Sucursal> _sucursales = [];
  late Sucursal? _selectedSucursal;
  late List<TipoDenuncia> _tipoDenuncias = [];
  late TipoDenuncia? _selectedTipoDenuncias;

  @override
  void initState() {
    super.initState();
    _loadSucursales();
    _loadTipoDenuncias();
  }

  Future<void> _loadSucursales() async {
    try {
      final sucursales = await ApiData.obtenerSucursales(widget.idEmpresa);
      setState(() {
        _sucursales = sucursales;
        if (_sucursales.isNotEmpty) {
          _selectedSucursal = sucursales[0];
        }
      });
    } catch (error) {
      //
    }
  }

  Future<void> _loadTipoDenuncias() async {
    try {
      final tipoDenuncias = await ApiData.obtenerTipoDenuncias();
      setState(() {
        _tipoDenuncias = tipoDenuncias;
        if (_tipoDenuncias.isNotEmpty) {
          _selectedTipoDenuncias = tipoDenuncias[0];
        }
      });
    } catch (error) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _requestFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildComplainantNameField(),
          _buildDenouncedNameField(),
          _buildSucursalDropdown(),
          _buildTipoDenunciasDropdown(),
          _buildComplaintTypeField(),
          _buildDatePicker(),
          const SizedBox(height: 50),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildComplainantNameField() {
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: TextFormField(
        controller: _complainantNameField,
        decoration: const InputDecoration(
          hintText: 'Nombre Completo',
          labelText: '¿Desea proporcionar su nombre?',
        ),
        validator: (value) {
          return null;
        },
      ),
    );
  }

  Widget _buildDenouncedNameField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: TextFormField(
        controller: _denouncedNameField,
        decoration: const InputDecoration(
          hintText:
              'Ingrese Nombre completo y puesto de trabajo de a quien reporta*',
          labelText: 'Persona Reportada, Puesto*',
        ),
        validator: (value) {
          return null;
        },
      ),
    );
  }

  Widget _buildSucursalDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: _sucursales.isEmpty
          ? const LinearProgressIndicator()
          : DropdownButtonFormField<Sucursal>(
              decoration: const InputDecoration(labelText: 'Sucursal'),
              value: _selectedSucursal,
              onChanged: (Sucursal? value) {
                setState(() {
                  _selectedSucursal = value!;
                });
              },
              items: _sucursales.map((Sucursal sucursal) {
                return DropdownMenuItem<Sucursal>(
                  value: sucursal,
                  child: Text(
                    sucursal.nombre,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Por favor seleccione una sucursal';
                }
                return null;
              },
            ),
    );
  }

  Widget _buildTipoDenunciasDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: _tipoDenuncias.isEmpty
          ? const LinearProgressIndicator()
          : DropdownButtonFormField<TipoDenuncia>(
              isExpanded: true,
              style: const TextStyle(
                  overflow: TextOverflow.fade, color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Tipo de hecho a reportar',
                labelText: 'Tipo de hecho',
              ),
              value: _selectedTipoDenuncias,
              onChanged: (TipoDenuncia? value) {
                setState(() {
                  _selectedTipoDenuncias = value!;
                  _complaintTypeField.text = value.detalle;
                });
              },
              items: _tipoDenuncias.map((TipoDenuncia tipodenuncia) {
                return DropdownMenuItem<TipoDenuncia>(
                  value: tipodenuncia,
                  child: _selectedTipoDenuncias != null &&
                          _selectedTipoDenuncias!.id == tipodenuncia.id
                      ? Text(tipodenuncia.descripcion)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tipodenuncia.descripcion,
                            ),
                            if (_tipoDenuncias.last != tipodenuncia)
                              const SizedBox(
                                height:
                                    8.0, // Ajusta este valor según sea necesario.
                                child:
                                    Divider(color: Colors.grey, thickness: 0.5),
                              ),
                          ],
                        ),
                );
              }).toList(),
              validator: (value) {
                if (value == null || _selectedTipoDenuncias == null) {
                  return 'Por favor seleccione un tipo de denuncia';
                }
                return null;
              },
            ),
    );
  }

  Widget _buildComplaintTypeField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          // Acción al tocar el campo, por ejemplo, abrir un cuadro de diálogo de selección.
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Significado del Hecho a reportar',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _complaintTypeField.text.isEmpty
                    ? '                                                                              '
                    : _complaintTypeField.text,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _complaintTypeField.text.isEmpty
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextFormField(
                  //enabled: false,
                  controller: _dateField,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es requerido';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Ingrese Fecha',
                    labelText: 'Fecha',
                    helperText: 'Fecha aproximada de los hechos',
                  ),
                  onTap: () {
                    _showDateTimePicker(context);
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  _showDateTimePicker(context);
                },
                child: const Icon(Icons.calendar_today),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _showDateTimePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      // ignore: use_build_context_synchronously
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );
      final dateTime = DateTimeField.combine(date, time);
      _dateField.text = format.format(dateTime);
    }
  }

  Widget _buildSubmitButton() {
    return TextButton(
      onPressed: () async {
        if (_requestFormKey.currentState!.validate()) {
          _formData['complainantName'] = _complainantNameField.text;
          _formData['denouncedName'] = _denouncedNameField.text;
          _formData['idComplaintType'] = _selectedTipoDenuncias!.id;
          _formData['date'] = _dateField.text;
          _formData['idSucursal'] = _selectedSucursal!.id;
          widget.onValidData(_formData);
        }
      },
      child: const Text('¡Siguiente!'),
    );
  }
}
