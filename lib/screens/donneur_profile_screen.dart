import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DonneurProfileScreen extends StatelessWidget {
  final Map<String, dynamic> donneur;
  final Map<String, dynamic> hopitalData;

  const DonneurProfileScreen({
    super.key,
    required this.donneur,
    required this.hopitalData,
  });

  @override
  Widget build(BuildContext context) {
    final bool disponible =
        donneur['disponible'] == 1 || donneur['disponible'] == '1';
    final int nbDons = int.parse(donneur['nb_dons'].toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.red.withOpacity(0.1),
                  child: Text(
                    donneur['prenom'][0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 44,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Nom
            Text(
              '${donneur['prenom']} ${donneur['nom']}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            // Groupe sanguin
            Text(
              donneur['groupe_sanguin'],
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // Infos
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.phone_outlined,
                    donneur['telephone'] ?? 'N/A',
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey[100],
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildInfoRow(
                    Icons.email_outlined,
                    donneur['email'] ?? 'N/A',
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey[100],
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildInfoRow(
                    Icons.location_on_outlined,
                    donneur['ville'] != null
                        ? '${donneur['ville']}, Bénin'
                        : 'Cotonou, Bénin',
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey[100],
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildInfoRow(
                    Icons.calendar_today_outlined,
                    donneur['dernier_don'] != null
                        ? 'Dernier don : ${donneur['dernier_don']}'
                        : 'Aucun don effectué',
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey[100],
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildInfoRow(
                    Icons.favorite_border,
                    'Dons effectués : $nbDons',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Boutons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Confirmer le don
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: disponible
                          ? () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const AlertDialog(
                                  content: Row(
                                    children: [
                                      CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 16),
                                      Text('Confirmation en cours...'),
                                    ],
                                  ),
                                ),
                              );
                              final result = await ApiService.confirmerDon(
                                int.parse(donneur['id'].toString()),
                                int.parse(hopitalData['id'].toString()),
                              );
                              Navigator.pop(context);
                              if (result['success']) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('✅ Don confirmé !'),
                                    content: Text(
                                      '${donneur['prenom']} ${donneur['nom']} a été confirmé comme donneur.',
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result['message']),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBackgroundColor: Colors.grey[300],
                      ),
                      child: Text(
                        disponible
                            ? 'Confirmer le don'
                            : 'Donneur indisponible',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Contacter
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Contacter le donneur'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nom : ${donneur['prenom']} ${donneur['nom']}',
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Téléphone : ${donneur['telephone'] ?? 'N/A'}',
                                ),
                                const SizedBox(height: 8),
                                Text('Email : ${donneur['email'] ?? 'N/A'}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Fermer',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Contacter',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 22),
          const SizedBox(width: 16),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
