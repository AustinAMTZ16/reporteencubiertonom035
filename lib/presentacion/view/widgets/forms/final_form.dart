import 'package:flutter/material.dart';

class FinalForm extends StatefulWidget {
  final void Function(Map<String, dynamic> values) onValidData;
  // const FinalForm({super.key, required this.onValidData});

  const FinalForm({
    super.key,
    required this.onValidData,
  });

  @override
  State<FinalForm> createState() => _FinalFormState();
}

class _FinalFormState extends State<FinalForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        logo(),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(height: 10),
        const Text(
          'La Justicia se defiende con la razón',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

Image logo() => Image.asset(
      'assets/images/justicia.png',
      height: 250,
      width: 250,
    );
