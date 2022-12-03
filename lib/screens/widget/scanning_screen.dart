import 'package:flutter/material.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({super.key});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Scanning...",
        style: TextStyle(
          fontSize: 40,
        ),
      ),
    );
  }
}
