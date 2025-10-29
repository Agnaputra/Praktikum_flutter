import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'widget/takepicture_screen.dart';

// Fungsi utama harus async untuk inisialisasi kamera
Future<void> main() async {
  // Pastikan inisialisasi widget binding
  WidgetsFlutterBinding.ensureInitialized(); 

  // Dapatkan daftar kamera yang tersedia di perangkat
  final cameras = await availableCameras();

  // Ambil kamera pertama dari daftar (biasanya kamera belakang)
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      title: 'Kamera Filter Gabungan',
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        camera: firstCamera,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}