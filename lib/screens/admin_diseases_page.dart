import 'package:flutter/material.dart';

class AdminDiseasesPage extends StatefulWidget {
  const AdminDiseasesPage({super.key});

  @override
  State<AdminDiseasesPage> createState() => _AdminDiseasesPageState();
}

class _AdminDiseasesPageState extends State<AdminDiseasesPage> {
  final List<Map<String, String>> diseases = [
    {
      'name': 'Mildiou',
      'description': 'Maladie provoquée par des champignons.',
      'status': 'active',
    },
    {
      'name': 'Oïdium',
      'description': 'Maladie caractérisée par une poudre blanche sur les feuilles.',
      'status': 'active',
    },
    {
      'name': 'Tache foliaire',
      'description': 'Maladie provoquant des taches sur les feuilles.',
      'status': 'active',
    },
  ];

  void ajouterMaladie() {
    final nomController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter une maladie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom de la maladie',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nomController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  diseases.add({
                    'name': nomController.text.trim(),
                    'description': descriptionController.text.trim(),
                    'status': 'active',
                  });
                });

                Navigator.pop(context);
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void modifierMaladie(int index) {
    final nomController =
        TextEditingController(text: diseases[index]['name']);
    final descriptionController =
        TextEditingController(text: diseases[index]['description']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier la maladie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom de la maladie',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nomController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  diseases[index]['name'] = nomController.text.trim();
                  diseases[index]['description'] =
                      descriptionController.text.trim();
                });

                Navigator.pop(context);
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void bloquerOuDebloquerMaladie(int index) {
    final bool estActive = diseases[index]['status'] == 'active';

    setState(() {
      diseases[index]['status'] = estActive ? 'blocked' : 'active';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          estActive
              ? 'La maladie a été bloquée.'
              : 'La maladie a été débloquée.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des maladies'),
      ),
      body: diseases.isEmpty
          ? const Center(
              child: Text(
                'Aucune maladie enregistrée.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                final disease = diseases[index];
                final bool estActive = disease['status'] == 'active';

                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.local_florist,
                              color: Color(0xFF2E7D32),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                disease['name']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          disease['description']!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Icon(
                              estActive
                                  ? Icons.check_circle
                                  : Icons.block,
                              size: 18,
                              color:
                                  estActive ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              estActive ? 'Active' : 'Bloquée',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    estActive ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  modifierMaladie(index);
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text('Modifier'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  bloquerOuDebloquerMaladie(index);
                                },
                                icon: Icon(
                                  estActive
                                      ? Icons.block
                                      : Icons.check_circle_outline,
                                ),
                                label: Text(
                                  estActive
                                      ? 'Bloquer'
                                      : 'Débloquer',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ajouterMaladie,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
    );
  }
}