import 'package:flutter/material.dart';
import 'admin_users_page.dart';
import 'admin_diseases_page.dart';
import 'admin_statistics_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        title: const Text(
          'Administration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bonjour, Administrateur 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Gérez la plateforme PlantCare AI.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Vue d’ensemble',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.people_outline,
                    title: 'Utilisateurs',
                    value: '0',
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _statCard(
                    icon: Icons.local_florist_outlined,
                    title: 'Maladies',
                    value: '0',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.analytics_outlined,
                    title: 'Diagnostics',
                    value: '0',
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _statCard(
                    icon: Icons.admin_panel_settings_outlined,
                    title: 'Administrateurs',
                    value: '1',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Gestion',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 15),

            _menuCard(
              icon: Icons.people_outline,
              title: 'Gestion des utilisateurs',
              description:
                  'Consulter et gérer les utilisateurs de la plateforme.',
             onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminUsersPage(),
    ),
  );
},
            ),

            const SizedBox(height: 12),

            _menuCard(
              icon: Icons.local_florist_outlined,
              title: 'Gestion des maladies',
              description:
                  'Ajouter, modifier ou supprimer les maladies des plantes.',
             onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminDiseasesPage(),
    ),
  );
},
            ),

            const SizedBox(height: 12),

            _menuCard(
              icon: Icons.bar_chart_outlined,
              title: 'Statistiques',
              description:
                  'Consulter les statistiques et les activités de la plateforme.',
              onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminStatisticsPage(),
    ),
  );
},
            ),

            const SizedBox(height: 30),

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

  static Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 35,
            color: const Color(0xFF2E7D32),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _menuCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
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
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF2E7D32),
                size: 30,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}