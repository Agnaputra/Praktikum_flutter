import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'displaypicture_screen.dart';
import 'dart:io';

/// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Inisialisasi kamera
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Tutup kamera saat widget dihapus
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture - 2341720065')),

      // Menampilkan preview kamera
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika kamera sudah siap, tampilkan preview
            return CameraPreview(_controller);
          } else {
            // Jika belum, tampilkan indikator loading
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      // Tombol kamera untuk mengambil gambar
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // Pastikan kamera sudah siap
            await _initializeControllerFuture;

            // Ambil gambar
            final image = await _controller.takePicture();

            // Pastikan context masih aktif sebelum pindah halaman
            if (!context.mounted) return;

            // Navigasi ke halaman DisplayPictureScreen dan tampilkan hasil foto
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // Tangani error jika ada
            print('Terjadi kesalahan saat mengambil gambar: $e');
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
