import 'package:flutter/material.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final List<Map<String, String>> users = [
    {
      'name': 'Agriculteur 1',
      'email': 'agriculteur1@email.com',
      'role': 'Agriculteur',
      'status': 'active',
    },
    {
      'name': 'Agriculteur 2',
      'email': 'agriculteur2@email.com',
      'role': 'Agriculteur',
      'status': 'active',
    },
    {
      'name': 'Administrateur',
      'email': 'admin@plantcare.com',
      'role': 'Administrateur',
      'status': 'active',
    },
  ];

  void ajouterUtilisateur() {
    final nomController = TextEditingController();
    final emailController = TextEditingController();
    final roleController = TextEditingController(text: 'Agriculteur');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un utilisateur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom complet',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Adresse e-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: 'Rôle',
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
                if (nomController.text.trim().isEmpty ||
                    emailController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  users.add({
                    'name': nomController.text.trim(),
                    'email': emailController.text.trim(),
                    'role': roleController.text.trim().isEmpty
                        ? 'Agriculteur'
                        : roleController.text.trim(),
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

  void modifierUtilisateur(int index) {
    final nomController =
        TextEditingController(text: users[index]['name']);
    final emailController =
        TextEditingController(text: users[index]['email']);
    final roleController =
        TextEditingController(text: users[index]['role']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier l’utilisateur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom complet',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Adresse e-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: 'Rôle',
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
                if (nomController.text.trim().isEmpty ||
                    emailController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  users[index]['name'] = nomController.text.trim();
                  users[index]['email'] = emailController.text.trim();
                  users[index]['role'] = roleController.text.trim();
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

  void bloquerOuDebloquerUtilisateur(int index) {
    final bool estActif = users[index]['status'] == 'active';

    setState(() {
      users[index]['status'] = estActif ? 'blocked' : 'active';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          estActif
              ? 'L’utilisateur a été bloqué.'
              : 'L’utilisateur a été débloqué.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des utilisateurs'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final bool estActif = user['status'] == 'active';

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        child: Text(
                          user['name']![0].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name']!,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(user['email']!),
                            const SizedBox(height: 4),
                            Text(
                              user['role']!,
                              style: const TextStyle(
                                color: Color(0xFF2E7D32),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(
                        estActif
                            ? Icons.check_circle
                            : Icons.block,
                        size: 18,
                        color: estActif ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        estActif ? 'Actif' : 'Bloqué',
                        style: TextStyle(
                          color: estActif ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            modifierUtilisateur(index);
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Modifier'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            bloquerOuDebloquerUtilisateur(index);
                          },
                          icon: Icon(
                            estActif
                                ? Icons.block
                                : Icons.check_circle_outline,
                          ),
                          label: Text(
                            estActif ? 'Bloquer' : 'Débloquer',
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
        onPressed: ajouterUtilisateur,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
    );
  }
}