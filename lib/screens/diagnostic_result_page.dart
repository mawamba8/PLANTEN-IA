import 'package:flutter/material.dart';

class DiagnosticResultPage extends StatelessWidget {
  final Map<String, dynamic>? diagnosticData;

  const DiagnosticResultPage({super.key, this.diagnosticData});

  @override
  Widget build(BuildContext context) {
    final data = diagnosticData ??
        {
          'disease': 'Mildiou',
          'confidence': '87%',
          'description':
              'Le mildiou est une maladie causée par des agents pathogènes qui peut provoquer des taches sur les feuilles et affecter la croissance de la plante.',
          'symptoms': [
            'Taches sur les feuilles',
            'Feuilles jaunissantes',
            'Développement irrégulier',
          ],
          'recommendations': [
            'Retirer les feuilles fortement infectées.',
            'Éviter l’excès d’humidité autour de la plante.',
            'Améliorer la circulation de l’air entre les plantes.',
            'Utiliser un traitement adapté si nécessaire.',
          ],
          'prevention': 'Éviter les arrosages excessifs et assurer un bon drainage.',
          'type': 'Image',
        };

    final disease = data['disease'] as String? ?? 'Maladie détectée';
    final confidence = data['confidence'] as String? ?? '87%';
    final double progress = _parseConfidence(confidence);
    final description = data['description'] as String? ?? '';
    final symptoms = (data['symptoms'] as List?)?.map((e) => e.toString()).toList() ?? const [];
    final recommendations = (data['recommendations'] as List?)?.map((e) => e.toString()).toList() ?? const [];
    final prevention = data['prevention'] as String? ?? 'Maintenir un bon suivi et prévenir l’humidité excessive.';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5),
      appBar: AppBar(
        title: const Text(
          'Résultat du diagnostic',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Diagnostic terminé 🌱',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Voici le résultat de l’analyse de votre plante via le mode ${data['type'] ?? 'Image'}.',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.orange,
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Maladie détectée',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              disease,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Niveau de confiance',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF2E7D32),
                    backgroundColor: Colors.grey.shade200,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '$confidence de confiance',
                    style: const TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _section(
              title: 'Description',
              icon: Icons.info_outline,
              child: Text(
                description,
                style: const TextStyle(
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 20),

            _section(
              title: 'Symptômes',
              icon: Icons.healing_outlined,
              child: Column(
                children: symptoms
                    .map((item) => _recommendation(item))
                    .toList(),
              ),
            ),

            const SizedBox(height: 20),

            _section(
              title: 'Recommandations',
              icon: Icons.health_and_safety_outlined,
              child: Column(
                children: recommendations
                    .map((item) => _recommendation(item))
                    .toList(),
              ),
            ),

            const SizedBox(height: 20),

            _section(
              title: 'Prévention',
              icon: Icons.shield_outlined,
              child: Text(
                prevention,
                style: const TextStyle(
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Ce résultat est fourni à titre indicatif. En cas de doute, consultez un spécialiste agricole.',
                      style: TextStyle(
                        fontSize: 13,
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
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text(
                  'Faire un nouveau diagnostic',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static double _parseConfidence(String value) {
    final cleaned = value.replaceAll('%', '').trim();
    final parsed = double.tryParse(cleaned) ?? 87;
    return (parsed / 100).clamp(0.0, 1.0);
  }

  static Widget _section({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF2E7D32),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          child,
        ],
      ),
    );
  }

  static Widget _recommendation(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF2E7D32),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}