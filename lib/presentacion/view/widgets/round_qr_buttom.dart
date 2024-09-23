// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class RoundQRButtom extends StatelessWidget {
//   final Function onPressed;
//   final String qrData;

//   const RoundQRButtom({
//     Key? key,
//     required this.onPressed,
//     required this.qrData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.blue[200], //Color(0xff132137),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed as void Function()?,
//           borderRadius: BorderRadius.circular(38.0),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: QrImageView(
//               data: qrData,
//               version: QrVersions.auto,
//               size: 80.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
