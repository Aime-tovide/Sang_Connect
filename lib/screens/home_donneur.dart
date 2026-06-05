// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import 'login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeDonneur extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   const HomeDonneur({super.key, required this.userData});

//   @override
//   State<HomeDonneur> createState() => _HomeDonneurState();
// }

// class _HomeDonneurState extends State<HomeDonneur> {
//   List<dynamic> demandes = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadDemandes();
//   }

//   void loadDemandes() async {
//     setState(() => isLoading = true);
//     try {
//       // final result = await ApiService.getDemandes(
//       //   groupeSanguin: widget.userData['groupe_sanguin'],
//       // );
//       // final result = await ApiService.getDemandes();
//       final result = await ApiService.getDemandes(
//         groupeSanguin: widget.userData['groupe_sanguin'],
//       );
//       setState(() => demandes = result);
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Erreur de chargement')));
//     }
//     setState(() => isLoading = false);
//   }

//   void logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }

//   Color getUrgenceColor(String urgence) {
//     switch (urgence) {
//       case 'critique':
//         return Colors.red;
//       case 'moyen':
//         return Colors.orange;
//       default:
//         return Colors.green;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Bonjour ${widget.userData['prenom'] ?? widget.userData['nom']} !',
//         ),
//         backgroundColor: Colors.red,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(icon: const Icon(Icons.logout), onPressed: logout),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             color: Colors.red[50],
//             child: Row(
//               children: [
//                 const Icon(Icons.bloodtype, color: Colors.red),
//                 const SizedBox(width: 8),
//                 Text(
//                   'Groupe sanguin : ${widget.userData['groupe_sanguin']}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Demandes compatibles',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.refresh, color: Colors.red),
//                   onPressed: loadDemandes,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: isLoading
//                 ? const Center(
//                     child: CircularProgressIndicator(color: Colors.red),
//                   )
//                 : demandes.isEmpty
//                 ? const Center(
//                     child: Text('Aucune demande pour votre groupe sanguin'),
//                   )
//                 : ListView.builder(
//                     itemCount: demandes.length,
//                     itemBuilder: (context, index) {
//                       final demande = demandes[index];
//                       return Card(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: getUrgenceColor(
//                               demande['urgence'],
//                             ),
//                             child: Text(
//                               demande['groupe_sanguin'],
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                           title: Text(demande['hopital_nom'] ?? 'Hôpital'),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Quantité : ${demande['quantite']} poches'),
//                               Text(demande['description'] ?? ''),
//                             ],
//                           ),
//                           trailing: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: getUrgenceColor(demande['urgence']),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               demande['urgence'],
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import 'login_screen.dart';
// import 'map_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeDonneur extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   const HomeDonneur({super.key, required this.userData});

//   @override
//   State<HomeDonneur> createState() => _HomeDonneurState();
// }

// class _HomeDonneurState extends State<HomeDonneur> {
//   List<dynamic> demandes = [];
//   bool isLoading = true;
//   int _currentIndex = 0;
//   bool disponible = true;

//   @override
//   void initState() {
//     super.initState();
//     loadDemandes();
//   }

//   void loadDemandes() async {
//     setState(() => isLoading = true);
//     try {
//       final result = await ApiService.getDemandes(
//         groupeSanguin: widget.userData['groupe_sanguin'],
//       );
//       setState(() => demandes = result);
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Erreur de chargement')));
//     }
//     setState(() => isLoading = false);
//   }

//   void logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }

//   Color getUrgenceColor(String urgence) {
//     switch (urgence) {
//       case 'critique':
//         return Colors.red;
//       case 'moyen':
//         return Colors.orange;
//       default:
//         return Colors.green;
//     }
//   }

//   Widget _buildAccueil() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 10),
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Bonjour ${widget.userData['prenom']} 👋',
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Text(
//                     'Merci d\'être donneur.',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//               Stack(
//                 children: [
//                   const Icon(Icons.notifications_outlined, size: 28),
//                   Positioned(
//                     right: 0,
//                     top: 0,
//                     child: Container(
//                       width: 16,
//                       height: 16,
//                       decoration: const BoxDecoration(
//                         color: Colors.red,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Center(
//                         child: Text(
//                           '1',
//                           style: TextStyle(color: Colors.white, fontSize: 10),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),
//           // Carte disponibilité
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Disponible pour don',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     const Text(
//                       'Statut actuel',
//                       style: TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                     const SizedBox(height: 8),
//                     GestureDetector(
//                       onTap: () => setState(() => disponible = !disponible),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: disponible ? Colors.green : Colors.grey,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           disponible ? 'ACTIF' : 'INACTIF',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: disponible ? Colors.green : Colors.grey,
//                       width: 2,
//                     ),
//                   ),
//                   child: Icon(
//                     disponible ? Icons.check : Icons.close,
//                     color: disponible ? Colors.green : Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           // Titre demandes
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Demandes urgentes près de vous',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               GestureDetector(
//                 onTap: loadDemandes,
//                 child: const Text(
//                   'Voir tout',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           // Liste demandes
//           isLoading
//               ? const Center(
//                   child: CircularProgressIndicator(color: Colors.red),
//                 )
//               : demandes.isEmpty
//               ? Center(
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 30),
//                       Icon(
//                         Icons.favorite_border,
//                         size: 60,
//                         color: Colors.grey[300],
//                       ),
//                       const SizedBox(height: 12),
//                       const Text(
//                         'Aucune demande compatible',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 )
//               : ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: demandes.length,
//                   itemBuilder: (context, index) {
//                     final demande = demandes[index];
//                     final urgence = demande['urgence'] ?? 'moyen';
//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Badge urgence
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: getUrgenceColor(urgence),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 urgence.toUpperCase(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               demande['hopital_nom'] ?? 'Hôpital',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             const Text(
//                               'Groupe requis',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               demande['groupe_sanguin'],
//                               style: const TextStyle(
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 const Icon(
//                                   Icons.location_on_outlined,
//                                   size: 16,
//                                   color: Colors.grey,
//                                 ),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   '${demande['quantite']} poches',
//                                   style: const TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   'Il y a quelques min',
//                                   style: TextStyle(
//                                     color: Colors.grey[400],
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                         'Vous avez répondu à la demande de ${demande['hopital_nom']}',
//                                       ),
//                                       backgroundColor: Colors.green,
//                                     ),
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 14,
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Répondre',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),
//       appBar: _currentIndex == 0
//           ? AppBar(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               leading: IconButton(
//                 icon: const Icon(Icons.menu, color: Colors.black),
//                 onPressed: logout,
//               ),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.red.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       widget.userData['groupe_sanguin'],
//                       style: const TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : null,
//       body: _currentIndex == 0
//           ? _buildAccueil()
//           : _currentIndex == 1
//           ? MapScreen(userData: widget.userData, userType: 'donneur')
//           : _currentIndex == 2
//           ? const Center(
//               child: Text('Notifications', style: TextStyle(fontSize: 18)),
//             )
//           : Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundColor: Colors.red.withOpacity(0.1),
//                     child: Text(
//                       widget.userData['prenom'][0].toUpperCase(),
//                       style: const TextStyle(
//                         fontSize: 32,
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     '${widget.userData['prenom']} ${widget.userData['nom']}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     widget.userData['email'] ?? '',
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: logout,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                     ),
//                     child: const Text(
//                       'Se déconnecter',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() => _currentIndex = index),
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map_outlined),
//             label: 'Carte',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications_outlined),
//             label: 'Notifications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profil',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';
import 'map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notifications_screen.dart';

class HomeDonneur extends StatefulWidget {
  final Map<String, dynamic> userData;
  const HomeDonneur({super.key, required this.userData});

  @override
  State<HomeDonneur> createState() => _HomeDonneurState();
}

class _HomeDonneurState extends State<HomeDonneur> {
  List<dynamic> demandes = [];
  bool isLoading = true;
  int _currentIndex = 0;
  bool disponible = true;

  @override
  void initState() {
    super.initState();
    loadDemandes();
  }

  void loadDemandes() async {
    setState(() => isLoading = true);
    try {
      final result = await ApiService.getDemandes(
        groupeSanguin: widget.userData['groupe_sanguin'],
      );
      setState(() => demandes = result);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erreur de chargement')));
    }
    setState(() => isLoading = false);
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Color getUrgenceColor(String urgence) {
    switch (urgence) {
      case 'critique':
        return Colors.red;
      case 'moyen':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[100],
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildAccueil() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bonjour ${widget.userData['prenom']} 👋',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Merci d\'être donneur.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Stack(
                children: [
                  const Icon(Icons.notifications_outlined, size: 28),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Disponible pour don',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Statut actuel',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => setState(() => disponible = !disponible),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: disponible ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          disponible ? 'ACTIF' : 'INACTIF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: disponible ? Colors.green : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    disponible ? Icons.check : Icons.close,
                    color: disponible ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Demandes urgentes près de vous',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              GestureDetector(
                onTap: loadDemandes,
                child: const Text(
                  'Voir tout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                )
              : demandes.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Icon(
                        Icons.favorite_border,
                        size: 60,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Aucune demande compatible',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: demandes.length,
                  itemBuilder: (context, index) {
                    final demande = demandes[index];
                    final urgence = demande['urgence'] ?? 'moyen';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: getUrgenceColor(urgence),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                urgence.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              demande['hopital_nom'] ?? 'Hôpital',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Groupe requis',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              demande['groupe_sanguin'],
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${demande['quantite']} poches',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Il y a quelques min',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Vous avez répondu à la demande de ${demande['hopital_nom']}',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: const Text(
                                  'Répondre',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildProfil() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40, bottom: 30),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => setState(() => _currentIndex = 0),
                    ),
                    const Text(
                      'Profil',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.red.withOpacity(0.1),
                      child: Text(
                        widget.userData['prenom'][0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '${widget.userData['prenom']} ${widget.userData['nom']}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10),
              ],
            ),
            child: Column(
              children: [
                _buildProfileRow(
                  'Groupe sanguin',
                  widget.userData['groupe_sanguin'] ?? '-',
                ),
                _buildDivider(),
                _buildProfileRow(
                  'Téléphone',
                  widget.userData['telephone'] ?? '-',
                ),
                _buildDivider(),
                _buildProfileRow('Email', widget.userData['email'] ?? '-'),
                _buildDivider(),
                _buildProfileRow('Ville', 'Cotonou, Bénin'),
                _buildDivider(),
                _buildProfileRow('Dons effectués', '0 dons'),
                _buildDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Badge', style: TextStyle(color: Colors.grey)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Donneur régulier 🏅',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Modifier le profil',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: logout,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Déconnexion',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: logout,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.userData['groupe_sanguin'],
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
      body: _currentIndex == 0
          ? _buildAccueil()
          : _currentIndex == 1
          ? MapScreen(userData: widget.userData, userType: 'donneur')
          : _currentIndex == 2
          ? const NotificationsScreen()
          : _buildProfil(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
