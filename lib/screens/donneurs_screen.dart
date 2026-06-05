// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import 'donneur_profile_screen.dart';

// class DonneursScreen extends StatefulWidget {
//   const DonneursScreen({super.key});

//   @override
//   State<DonneursScreen> createState() => _DonneursScreenState();
// }

// class _DonneursScreenState extends State<DonneursScreen> {
//   List<dynamic> donneurs = [];
//   List<dynamic> filteredDonneurs = [];
//   bool isLoading = true;
//   final searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     loadDonneurs();
//     searchController.addListener(filterDonneurs);
//   }

//   void loadDonneurs() async {
//     setState(() => isLoading = true);
//     try {
//       final result = await ApiService.getDonneursCompatibles();
//       setState(() {
//         donneurs = result;
//         filteredDonneurs = result;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Erreur de chargement')),
//       );
//     }
//     setState(() => isLoading = false);
//   }

//   void filterDonneurs() {
//     final query = searchController.text.toLowerCase();
//     setState(() {
//       filteredDonneurs = donneurs.where((d) {
//         final nom = '${d['prenom']} ${d['nom']}'.toLowerCase();
//         return nom.contains(query);
//       }).toList();
//     });
//   }

//   String getDistance(int index) {
//     final distances = ['2 km', '3.5 km', '4 km', '5 km', '6 km'];
//     return distances[index % distances.length];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Donneurs compatibles',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.red),
//             onPressed: loadDonneurs,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Barre de recherche
//           Container(
//             color: Colors.white,
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: 'Rechercher un donneur...',
//                 prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           // Nombre de donneurs
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Row(
//               children: [
//                 Text(
//                   '${filteredDonneurs.length} donneur(s) trouvé(s)',
//                   style: const TextStyle(color: Colors.grey, fontSize: 13),
//                 ),
//               ],
//             ),
//           ),
//           // Liste
//           Expanded(
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator(color: Colors.red))
//                 : filteredDonneurs.isEmpty
//                     ? const Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.people_outline, size: 60, color: Colors.grey),
//                             SizedBox(height: 12),
//                             Text('Aucun donneur trouvé', style: TextStyle(color: Colors.grey)),
//                           ],
//                         ),
//                       )
//                     : ListView.builder(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         itemCount: filteredDonneurs.length,
//                         itemBuilder: (context, index) {
//                           final donneur = filteredDonneurs[index];
//                           final bool disponible = donneur['disponible'] == 1 || donneur['disponible'] == '1';
//                           final int nbDons = int.parse(donneur['nb_dons'].toString());

//                           return Container(
//                             margin: const EdgeInsets.only(bottom: 12),
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.08),
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     // Avatar
//                                     CircleAvatar(
//                                       radius: 28,
//                                       backgroundColor: Colors.red.withOpacity(0.1),
//                                       child: Text(
//                                         donneur['prenom'][0].toUpperCase(),
//                                         style: const TextStyle(
//                                           fontSize: 22,
//                                           color: Colors.red,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 '${donneur['prenom']} ${donneur['nom']}',
//                                                 style: const TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                               const Spacer(),
//                                               Text(
//                                                 donneur['groupe_sanguin'],
//                                                 style: const TextStyle(
//                                                   color: Colors.red,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.circle,
//                                                 size: 10,
//                                                 color: disponible ? Colors.green : Colors.grey,
//                                               ),
//                                               const SizedBox(width: 4),
//                                               Text(
//                                                 disponible ? 'Disponible' : 'Indisponible',
//                                                 style: TextStyle(
//                                                   color: disponible ? Colors.green : Colors.grey,
//                                                   fontSize: 13,
//                                                 ),
//                                               ),
//                                               const Spacer(),
//                                               Text(
//                                                 getDistance(index),
//                                                 style: const TextStyle(color: Colors.grey, fontSize: 13),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Text(
//                                             '$nbDons dons effectués',
//                                             style: const TextStyle(color: Colors.grey, fontSize: 12),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 12),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: OutlinedButton(
//                                     onPressed: () {
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) => AlertDialog(
//                                           title: Text('${donneur['prenom']} ${donneur['nom']}'),
//                                           content: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text('Groupe : ${donneur['groupe_sanguin']}'),
//                                               Text('Téléphone : ${donneur['telephone'] ?? 'N/A'}'),
//                                               Text('Dons : $nbDons'),
//                                               Text('Statut : ${disponible ? 'Disponible' : 'Indisponible'}'),
//                                             ],
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () => Navigator.pop(context),
//                                               child: const Text('Fermer'),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                     style: OutlinedButton.styleFrom(
//                                       side: const BorderSide(color: Colors.red),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                     ),
//                                     child: const Text('Voir profil',
//                                       style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'donneur_profile_screen.dart';

class DonneursScreen extends StatefulWidget {
  final Map<String, dynamic> hopitalData;
  const DonneursScreen({super.key, required this.hopitalData});

  @override
  State<DonneursScreen> createState() => _DonneursScreenState();
}

class _DonneursScreenState extends State<DonneursScreen> {
  List<dynamic> donneurs = [];
  List<dynamic> filteredDonneurs = [];
  bool isLoading = true;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDonneurs();
    searchController.addListener(filterDonneurs);
  }

  void loadDonneurs() async {
    setState(() => isLoading = true);
    try {
      final result = await ApiService.getDonneursCompatibles();
      setState(() {
        donneurs = result;
        filteredDonneurs = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erreur de chargement')));
    }
    setState(() => isLoading = false);
  }

  void filterDonneurs() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredDonneurs = donneurs.where((d) {
        final nom = '${d['prenom']} ${d['nom']}'.toLowerCase();
        return nom.contains(query);
      }).toList();
    });
  }

  String getDistance(int index) {
    final distances = ['2 km', '3.5 km', '4 km', '5 km', '6 km'];
    return distances[index % distances.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Donneurs compatibles',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.red),
            onPressed: loadDonneurs,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un donneur...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${filteredDonneurs.length} donneur(s) trouvé(s)',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  )
                : filteredDonneurs.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Aucun donneur trouvé',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredDonneurs.length,
                    itemBuilder: (context, index) {
                      final donneur = filteredDonneurs[index];
                      final bool disponible =
                          donneur['disponible'] == 1 ||
                          donneur['disponible'] == '1';
                      final int nbDons = int.parse(
                        donneur['nb_dons'].toString(),
                      );

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.red.withOpacity(0.1),
                                  child: Text(
                                    donneur['prenom'][0].toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${donneur['prenom']} ${donneur['nom']}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            donneur['groupe_sanguin'],
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 10,
                                            color: disponible
                                                ? Colors.green
                                                : Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            disponible
                                                ? 'Disponible'
                                                : 'Indisponible',
                                            style: TextStyle(
                                              color: disponible
                                                  ? Colors.green
                                                  : Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            getDistance(index),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '$nbDons dons effectués',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DonneurProfileScreen(
                                            donneur: donneur,
                                            hopitalData: widget.hopitalData,
                                          ),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.red),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Voir profil',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
