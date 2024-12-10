import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:collection/collection.dart';

class ImageAttachmentManager {
  final List<Uint8List> _images = [];

  List<Uint8List> get images => List.unmodifiable(_images);

  /// Selecciona múltiples imágenes y las agrega, evitando duplicados exactos.
  Future<void> pickImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile>? pickedFiles = await picker.pickMultiImage();

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        List<Uint8List> imageBytes = [];
        for (var file in pickedFiles) {
          final bytes = await file.readAsBytes();
          final exists = _images.any((image) => const ListEquality().equals(image, bytes));
          if (!exists) {
            imageBytes.add(bytes);
          }
        }
        _images.addAll(imageBytes);
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  /// Elimina una imagen de la lista por índice.
  void clearImageAtIndex(int index) {
    if (index >= 0 && index < _images.length) {
      _images.removeAt(index);
    }
  }

  /// Limpia todas las imágenes.
  void clearAllImages() {
    _images.clear();
  }
}
