import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // Dibutuhkan untuk beberapa widget Flutter
import 'filter_carousel.dart';

// Definisi Widget TakePictureScreen
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Fungsi pengambilan foto yang menavigasi ke FilterCarousel
  void _takePicture() async {
    // Pastikan controller sudah siap
    try {
      await _initializeControllerFuture;

      // Ambil foto (operasi async)
      final XFile imageFile = await _controller.takePicture();

      if (!mounted) return;

      // Navigasi ke halaman filter dengan membawa path gambar
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PhotoFilterCarousel(
            imagePath: imageFile.path, 
          ),
        ),
      );
    } catch (e) {
      // Tampilkan error jika gagal
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error mengambil gambar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambil Foto'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika Future selesai, tampilkan preview
            return CameraPreview(_controller);
          } else {
            // Jika Future masih berjalan, tampilkan loading
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        backgroundColor: Colors.white,
        child: const Icon(Icons.camera_alt, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}