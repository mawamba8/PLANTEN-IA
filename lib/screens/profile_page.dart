import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController =
      TextEditingController(text: 'Agriculteur');
  final TextEditingController emailController =
      TextEditingController(text: 'agriculteur@email.com');
  final TextEditingController phoneController =
      TextEditingController(text: '+237 6XX XX XX XX');

  void _saveProfile() {
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil mis à jour avec succès.'),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
          'Mon profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 55,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              nameController.text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 30),
            _infoCard(
              icon: Icons.person_outline,
              title: 'Nom complet',
              value: nameController.text,
            ),
            const SizedBox(height: 15),
            _infoCard(
              icon: Icons.email_outlined,
              title: 'Adresse e-mail',
              value: emailController.text,
            ),
            const SizedBox(height: 15),
            _infoCard(
              icon: Icons.phone_outlined,
              title: 'Téléphone',
              value: phoneController.text,
            ),
            const SizedBox(height: 15),
            _infoCard(
              icon: Icons.badge_outlined,
              title: 'Rôle',
              value: 'Agriculteur',
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      final nameField =
                          TextEditingController(text: nameController.text);
                      final emailField =
                          TextEditingController(text: emailController.text);
                      final phoneField =
                          TextEditingController(text: phoneController.text);

                      return AlertDialog(
                        title: const Text('Modifier le profil'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nameField,
                              decoration: const InputDecoration(
                                labelText: 'Nom complet',
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: emailField,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: phoneField,
                              decoration: const InputDecoration(
                                labelText: 'Téléphone',
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Annuler'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              nameController.text = nameField.text;
                              emailController.text = emailField.text;
                              phoneController.text = phoneField.text;
                              Navigator.pop(dialogContext);
                              _saveProfile();
                            },
                            child: const Text('Enregistrer'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text(
                  'Modifier le profil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text(
                  'Se déconnecter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF2E7D32),
            size: 28,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}