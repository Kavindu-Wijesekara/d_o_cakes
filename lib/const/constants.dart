import 'package:flutter/material.dart';

// final kFormTextBoxStyle = InputDecoration(
//   contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
//   hintText: 'Enter the hint text',
//   labelText: 'lable',
//   floatingLabelBehavior: FloatingLabelBehavior.never,
//   prefixIcon: const Icon(Icons.mail),
//   enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(35),
//     borderSide: const BorderSide(color: Colors.white54),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(35),
//     borderSide: const BorderSide(color: Colors.pink, width: 2.0),
//   ),
//   errorBorder: const OutlineInputBorder(
//     borderRadius: BorderRadius.only(
//       topRight: Radius.circular(35),
//       topLeft: Radius.circular(35),
//       bottomLeft: Radius.circular(5),
//       bottomRight: Radius.circular(5),
//     ),
//     borderSide: BorderSide(color: Colors.red, width: 1.0),
//   ),
//   focusedErrorBorder: const OutlineInputBorder(
//     borderRadius: BorderRadius.only(
//       topRight: Radius.circular(35),
//       topLeft: Radius.circular(35),
//       bottomLeft: Radius.circular(5),
//       bottomRight: Radius.circular(5),
//     ),
//     borderSide: BorderSide(color: Colors.red),
//   ),
//   errorStyle: const TextStyle(fontWeight: FontWeight.w700),
//   filled: true,
//   fillColor: Colors.transparent,
// );

final kFormTextBoxStyle = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
  hintText: 'Enter the hint text',
  labelText: 'lable',
  floatingLabelBehavior: FloatingLabelBehavior.never,
  prefixIcon: const Icon(Icons.mail),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(35),
    borderSide: const BorderSide(color: Colors.white54),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(35),
    borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(35),
    borderSide: const BorderSide(color: Colors.red, width: 1.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(35),
    borderSide: const BorderSide(color: Colors.red),
  ),
  errorStyle: const TextStyle(fontWeight: FontWeight.w700),
  filled: true,
  fillColor: Colors.white38,
);

final kElevatedButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(10.0),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  backgroundColor: MaterialStateProperty.all(Colors.pink),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35.0),
      side: const BorderSide(width: 1.0, color: Colors.white),
    ),
  ),
);

final kCakeUploadTextBoxStyle = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(35),
    borderSide: const BorderSide(color: Colors.black12),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(35),
    borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(35),
    borderSide: const BorderSide(color: Colors.red, width: 1.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(35),
    borderSide: const BorderSide(color: Colors.red),
  ),
  errorStyle: const TextStyle(fontWeight: FontWeight.w500),
  filled: true,
  fillColor: Colors.yellowAccent.shade100,
);
