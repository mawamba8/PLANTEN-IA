import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';
import 'diagnostic_result_page.dart';

class DiagnosticPage extends StatefulWidget {
  const DiagnosticPage({super.key});

  @override
  State<DiagnosticPage> createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends State<DiagnosticPage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController symptomesController = TextEditingController();

  XFile? image;

  Future<void> choisirImage() async {
    final XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
    }
  }

  Future<void> prendrePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (photo != null) {
      setState(() {
        image = photo;
      });
    }
  }

  void enleverImage() {
    setState(() {
      image = null;
    });
  }

  Future<void> analyserAvecIA() async {
    if (image == null && symptomesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ajoutez une photo ou décrivez les symptômes de la plante.',
          ),
        ),
      );
      return;
    }

    try {
      final result = await ApiService.diagnosePlant(
        filePath: image?.path,
        symptoms: symptomesController.text.trim(),
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiagnosticResultPage(diagnosticData: result),
        ),
      );
    } on ApiException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('L’analyse IA a échoué. Réessayez.')),
      );
    }
  }

  @override
  void dispose() {
    symptomesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        title: const Text(
          'Diagnostic de la plante',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Diagnostiquez votre plante 🌱',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Ajoutez une photo ou décrivez les symptômes '
              'observés afin d’obtenir un diagnostic.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              '1. Photo de la plante',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFBDBDBD),
                ),
              ),
              child: image != null
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 220,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: enleverImage,
                              icon: const Icon(Icons.close, color: Colors.white),
                              tooltip: 'Retirer l’image',
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 60,
                          color: Color(0xFF2E7D32),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Aucune image sélectionnée',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: prendrePhoto,
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Prendre une photo'),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: choisirImage,
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('Galerie'),
                  ),
                ),
              ],
            ),

            if (image != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: enleverImage,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Changer / supprimer'),
                ),
              ),
            ],

            const SizedBox(height: 30),

            const Text(
              '2. Décrire les symptômes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: symptomesController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText:
                    'Exemple : les feuilles sont jaunes et présentent des taches...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Color(0xFF2E7D32),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pour obtenir un meilleur diagnostic, '
                      'utilisez une photo claire de la plante '
                      'et décrivez les symptômes observés.',
                      style: TextStyle(
                        color: Color(0xFF1B5E20),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: analyserAvecIA,
                icon: const Icon(Icons.auto_awesome),
                label: const Text(
                  'Analyser avec l’IA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}