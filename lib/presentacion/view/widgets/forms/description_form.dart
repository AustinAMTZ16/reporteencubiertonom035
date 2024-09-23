import 'package:flutter/material.dart';

class DescriptionForm extends StatefulWidget {
  final void Function(Map<String, dynamic> values) onValidData;

  const DescriptionForm({
    super.key,
    required this.onValidData,
  });

  @override
  State<DescriptionForm> createState() => _DescriptionFormState();
}

class _DescriptionFormState extends State<DescriptionForm> {
  final TextEditingController _descriptionField = TextEditingController();
  final TextEditingController _placelField = TextEditingController();
  final Map<String, dynamic> _formDataDesc = {};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _descriptionField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: TextFormField(
              controller: _placelField,
              decoration: const InputDecoration(
                hintText: 'Lugar',
                labelText: 'Lugar donde ocurrieron los hechos',
              ),
              validator: (value) {
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: TextFormField(
              controller: _descriptionField,
              maxLines: 15,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: "Ingrese la descripción de su denuncia",
                labelText: "Descripción",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formDataDesc['detalle'] = _descriptionField.text;
                _formDataDesc['lugar'] = _placelField.text;
                widget.onValidData(_formDataDesc);
              }
            },
            child: const Text('¡Siguiente!'),
          ),
        ],
      ),
    );
  }
}
