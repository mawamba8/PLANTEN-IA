import 'package:flutter/material.dart';
import 'diagnostic_result_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  final List<Map<String, dynamic>> diagnostics = const [
    {
      'disease': 'Mildiou',
      'date': '15 septembre 2026',
      'confidence': '87%',
      'type': 'Image',
      'description':
          'Le diagnostic suggère un mildiou foliaire, avec des taches irrégulières sur les feuilles et un développement rapide dans les conditions humides.',
      'symptoms': [
        'Taches irrégulières sur les feuilles',
        'Feuilles déformées',
        'Humidité élevée autour de la plante',
      ],
      'recommendations': [
        'Retirer les feuilles fortement infectées.',
        'Éviter les arrosages en soirée.',
        'Améliorer la ventilation autour des plantes.',
      ],
      'prevention': 'Maintenir une bonne circulation de l’air et surveiller les feuilles à chaque arrosage.',
      'icon': Icons.warning_amber_rounded,
      'color': 0xFFFF9800,
    },
    {
      'disease': 'Tache foliaire',
      'date': '12 septembre 2026',
      'confidence': '91%',
      'type': 'Image',
      'description':
          'La plante présente des taches circulaires avec des bordures plus sombres, typiques d’une maladie foliaire agressive.',
      'symptoms': [
        'Taches rondes sur les feuilles',
        'Feuilles jaunissantes',
        'Dégradation progressive du feuillage',
      ],
      'recommendations': [
        'Retirer les feuilles atteintes.',
        'Aérer la zone de culture.',
        'Utiliser un traitement foliaire adapté.',
      ],
      'prevention': 'Éviter les excès d’eau et contrôler régulièrement les feuilles du bas.',
      'icon': Icons.eco_outlined,
      'color': 0xFF2E7D32,
    },
    {
      'disease': 'Oïdium',
      'date': '8 septembre 2026',
      'confidence': '82%',
      'type': 'Texte',
      'description':
          'Le symptôme principal est une poussière blanchâtre sur les feuilles et les tiges, typique d’une attaque par oïdium.',
      'symptoms': [
        'Poudre blanche sur les feuilles',
        'Croissance ralentie',
        'Feuilles altérées',
      ],
      'recommendations': [
        'Traiter rapidement avec un fongicide adapté.',
        'Éviter les zones trop denses.',
        'Contrôler l’humidité ambiante.',
      ],
      'prevention': 'Prévenir l’humidité excessive et maintenir un bon espacement entre plantes.',
      'icon': Icons.local_florist_outlined,
      'color': 0xFF1E88E5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5),
      appBar: AppBar(
        title: const Text(
          'Mon historique',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Mes diagnostics',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Retrouvez ici les diagnostics réalisés sur vos plantes.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 25),

          ...diagnostics.map((diagnostic) {
            final color = Color(diagnostic['color'] as int);
            final icon = diagnostic['icon'] as IconData;
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: _diagnosticCard(
                context: context,
                disease: diagnostic['disease'] as String,
                date: diagnostic['date'] as String,
                confidence: diagnostic['confidence'] as String,
                icon: icon,
                color: color,
                diagnosticData: diagnostic,
              ),
            );
          }),

          const SizedBox(height: 25),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFF2E7D32),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Les résultats affichés sont actuellement des données de démonstration.',
                    style: TextStyle(
                      color: Color(0xFF1B5E20),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _diagnosticCard({
    required BuildContext context,
    required String disease,
    required String date,
    required String confidence,
    required IconData icon,
    required Color color,
    required Map<String, dynamic> diagnosticData,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiagnosticResultPage(
              diagnosticData: diagnosticData,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    disease,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Confiance : $confidence',
                    style: const TextStyle(
                      color: Color(0xFF2E7D32),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}