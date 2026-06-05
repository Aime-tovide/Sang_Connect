// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import 'login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'donneurs_screen.dart';

// class HomeHopital extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   const HomeHopital({super.key, required this.userData});

//   @override
//   State<HomeHopital> createState() => _HomeHopitalState();
// }

// class _HomeHopitalState extends State<HomeHopital> {
//   List<dynamic> demandes = [];
//   bool isLoading = true;
//   int _currentIndex = 0;
//   Map<String, dynamic> stats = {
//     'demandes_actives': 0,
//     'demandes_aujourdhui': 0,
//     'donneurs_disponibles': 0,
//     'dons_recus': 0,
//   };

//   final groupeChoisi = ValueNotifier<String>('A+');
//   final quantiteController = TextEditingController();
//   final descriptionController = TextEditingController();
//   String urgence = 'moyen';

//   final List<String> groupes = [
//     'A+',
//     'A-',
//     'B+',
//     'B-',
//     'AB+',
//     'AB-',
//     'O+',
//     'O-',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     loadDemandes();
//   }

//   void loadDemandes() async {
//     setState(() => isLoading = true);
//     try {
//       final result = await ApiService.getDemandes();
//       final statsResult = await ApiService.getStats(
//         int.parse(widget.userData['id'].toString()),
//       );
//       setState(() {
//         demandes = result;
//         stats = statsResult;
//       });
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
//         return Colors.blue;
//       default:
//         return Colors.green;
//     }
//   }

//   String getUrgenceLabel(String urgence) {
//     switch (urgence) {
//       case 'critique':
//         return 'Critique';
//       case 'moyen':
//         return 'Modéré';
//       default:
//         return 'Faible';
//     }
//   }

//   String getTemps(int index) {
//     final temps = [
//       'Il y a 10 min',
//       'Il y a 25 min',
//       'Il y a 1 h',
//       'Il y a 2 h',
//     ];
//     return temps[index % temps.length];
//   }

//   void showCreateDemandeDialog() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           left: 24,
//           right: 24,
//           top: 24,
//           bottom: MediaQuery.of(context).viewInsets.bottom + 24,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Nouvelle demande',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: groupeChoisi.value,
//               decoration: InputDecoration(
//                 labelText: 'Groupe sanguin',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(
//                   Icons.water_drop_outlined,
//                   color: Colors.red,
//                 ),
//               ),
//               items: groupes
//                   .map((g) => DropdownMenuItem(value: g, child: Text(g)))
//                   .toList(),
//               onChanged: (val) => groupeChoisi.value = val!,
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: quantiteController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Quantité (poches)',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(
//                   Icons.bloodtype_outlined,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value: urgence,
//               decoration: InputDecoration(
//                 labelText: 'Niveau d\'urgence',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(
//                   Icons.warning_amber_outlined,
//                   color: Colors.red,
//                 ),
//               ),
//               items: const [
//                 DropdownMenuItem(value: 'faible', child: Text('Faible')),
//                 DropdownMenuItem(value: 'moyen', child: Text('Modéré')),
//                 DropdownMenuItem(value: 'critique', child: Text('Critique')),
//               ],
//               onChanged: (val) => setState(() => urgence = val!),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: descriptionController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'Description (optionnel)',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (quantiteController.text.isEmpty) return;
//                   final result = await ApiService.createDemande({
//                     'hopital_id': widget.userData['id'],
//                     'groupe_sanguin': groupeChoisi.value,
//                     'quantite': int.parse(quantiteController.text),
//                     'urgence': urgence,
//                     'description': descriptionController.text,
//                   });
//                   Navigator.pop(context);
//                   if (result['success']) {
//                     quantiteController.clear();
//                     descriptionController.clear();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Demande créée !'),
//                         backgroundColor: Colors.green,
//                       ),
//                     );
//                     loadDemandes();
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Publier la demande',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard(String titre, String valeur, Color color) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.08),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               titre,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               valeur,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: const TextStyle(color: Colors.grey)),
//           Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _buildAccueil() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Bienvenue ${widget.userData['nom']} 👋',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Text(
//                     'Hôpital partenaire SangConnect',
//                     style: TextStyle(color: Colors.grey, fontSize: 12),
//                   ),
//                 ],
//               ),
//               const Icon(Icons.notifications_outlined, size: 28),
//             ],
//           ),
//           const SizedBox(height: 24),
//           // Stats dynamiques
//           Row(
//             children: [
//               _buildStatCard(
//                 'Demandes actives',
//                 '${stats['demandes_actives']}',
//                 Colors.red,
//               ),
//               const SizedBox(width: 12),
//               _buildStatCard(
//                 'Donneurs disponibles',
//                 '${stats['donneurs_disponibles']}',
//                 Colors.green,
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               _buildStatCard(
//                 'Demandes aujourd\'hui',
//                 '${stats['demandes_aujourdhui']}',
//                 Colors.blue,
//               ),
//               const SizedBox(width: 12),
//               _buildStatCard(
//                 'Dons reçus',
//                 '${stats['dons_recus']}',
//                 Colors.purple,
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Dernières demandes',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
//           const SizedBox(height: 12),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10),
//               ],
//             ),
//             child: isLoading
//                 ? const Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Center(
//                       child: CircularProgressIndicator(color: Colors.red),
//                     ),
//                   )
//                 : demandes.isEmpty
//                 ? const Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Center(
//                       child: Text(
//                         'Aucune demande',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ),
//                   )
//                 : ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: demandes.length > 5 ? 5 : demandes.length,
//                     separatorBuilder: (_, __) =>
//                         Divider(height: 1, color: Colors.grey[100]),
//                     itemBuilder: (context, index) {
//                       final demande = demandes[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 14,
//                         ),
//                         child: Row(
//                           children: [
//                             Text(
//                               demande['groupe_sanguin'],
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Text(
//                               '${demande['quantite']} poches',
//                               style: const TextStyle(color: Colors.grey),
//                             ),
//                             const Spacer(),
//                             Text(
//                               getUrgenceLabel(demande['urgence']),
//                               style: TextStyle(
//                                 color: getUrgenceColor(demande['urgence']),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Text(
//                               getTemps(index),
//                               style: TextStyle(
//                                 color: Colors.grey[400],
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//           ),
//           const SizedBox(height: 24),
//           SizedBox(
//             width: double.infinity,
//             height: 56,
//             child: ElevatedButton.icon(
//               onPressed: showCreateDemandeDialog,
//               icon: const Icon(Icons.add, color: Colors.white),
//               label: const Text(
//                 'Nouvelle demande',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildListeDemandes() {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Mes demandes',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.red),
//             onPressed: loadDemandes,
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showCreateDemandeDialog,
//         backgroundColor: Colors.red,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator(color: Colors.red))
//           : demandes.isEmpty
//           ? const Center(child: Text('Aucune demande créée'))
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: demandes.length,
//               itemBuilder: (context, index) {
//                 final demande = demandes[index];
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.08),
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: getUrgenceColor(
//                             demande['urgence'],
//                           ).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Center(
//                           child: Text(
//                             demande['groupe_sanguin'],
//                             style: TextStyle(
//                               color: getUrgenceColor(demande['urgence']),
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '${demande['quantite']} poches',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               demande['description'] ?? '',
//                               style: const TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: getUrgenceColor(demande['urgence']),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           getUrgenceLabel(demande['urgence']),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   Widget _buildProfil() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.only(top: 40, bottom: 30),
//             color: Colors.white,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () => setState(() => _currentIndex = 0),
//                     ),
//                     const Text(
//                       'Profil',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.settings_outlined),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundColor: Colors.red.withOpacity(0.1),
//                   child: Text(
//                     widget.userData['nom'][0].toUpperCase(),
//                     style: const TextStyle(
//                       fontSize: 40,
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   widget.userData['nom'],
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 const Text('Hôpital', style: TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10),
//               ],
//             ),
//             child: Column(
//               children: [
//                 _buildRow('Email', widget.userData['email'] ?? '-'),
//                 Divider(height: 1, color: Colors.grey[100]),
//                 _buildRow('Téléphone', widget.userData['telephone'] ?? '-'),
//                 Divider(height: 1, color: Colors.grey[100]),
//                 _buildRow(
//                   'Adresse',
//                   widget.userData['adresse'] ?? 'Cotonou, Bénin',
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: OutlinedButton(
//                 onPressed: logout,
//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: Colors.red),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Déconnexion',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
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
//                 onPressed: () {},
//               ),
//               actions: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.notifications_outlined,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {},
//                 ),
//               ],
//             )
//           : null,
//       body: _currentIndex == 0
//           ? _buildAccueil()
//           : _currentIndex == 1
//           ? _buildListeDemandes()
//           : _currentIndex == 2
//           ? const DonneursScreen()
//           : _buildProfil(),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() => _currentIndex = index),
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list_alt_outlined),
//             label: 'Demandes',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people_outline),
//             label: 'Donneurs',
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
import 'donneurs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeHopital extends StatefulWidget {
  final Map<String, dynamic> userData;
  const HomeHopital({super.key, required this.userData});

  @override
  State<HomeHopital> createState() => _HomeHopitalState();
}

class _HomeHopitalState extends State<HomeHopital> {
  List<dynamic> demandes = [];
  bool isLoading = true;
  int _currentIndex = 0;
  Map<String, dynamic> stats = {
    'demandes_actives': 0,
    'demandes_aujourdhui': 0,
    'donneurs_disponibles': 0,
    'dons_recus': 0,
  };

  final groupeChoisi = ValueNotifier<String>('A+');
  final quantiteController = TextEditingController();
  final descriptionController = TextEditingController();
  String urgence = 'moyen';
  final List<String> groupes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void initState() {
    super.initState();
    loadDemandes();
  }

  void loadDemandes() async {
    setState(() => isLoading = true);
    try {
      final result = await ApiService.getDemandes();
      final statsResult = await ApiService.getStats(
        int.parse(widget.userData['id'].toString()),
      );
      setState(() {
        demandes = result;
        stats = statsResult;
      });
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
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  String getUrgenceLabel(String urgence) {
    switch (urgence) {
      case 'critique':
        return 'Critique';
      case 'moyen':
        return 'Modéré';
      default:
        return 'Faible';
    }
  }

  String getTemps(int index) {
    final temps = [
      'Il y a 10 min',
      'Il y a 25 min',
      'Il y a 1 h',
      'Il y a 2 h',
    ];
    return temps[index % temps.length];
  }

  void showCreateDemandeDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nouvelle demande',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: groupeChoisi.value,
              decoration: InputDecoration(
                labelText: 'Groupe sanguin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(
                  Icons.water_drop_outlined,
                  color: Colors.red,
                ),
              ),
              items: groupes
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (val) => groupeChoisi.value = val!,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantiteController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantité (poches)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(
                  Icons.bloodtype_outlined,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: urgence,
              decoration: InputDecoration(
                labelText: 'Niveau d\'urgence',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(
                  Icons.warning_amber_outlined,
                  color: Colors.red,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'faible', child: Text('Faible')),
                DropdownMenuItem(value: 'moyen', child: Text('Modéré')),
                DropdownMenuItem(value: 'critique', child: Text('Critique')),
              ],
              onChanged: (val) => setState(() => urgence = val!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description (optionnel)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () async {
                  if (quantiteController.text.isEmpty) return;
                  final result = await ApiService.createDemande({
                    'hopital_id': widget.userData['id'],
                    'groupe_sanguin': groupeChoisi.value,
                    'quantite': int.parse(quantiteController.text),
                    'urgence': urgence,
                    'description': descriptionController.text,
                  });
                  Navigator.pop(context);
                  if (result['success']) {
                    quantiteController.clear();
                    descriptionController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Demande créée !'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    loadDemandes();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Publier la demande',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String titre, String valeur, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titre,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              valeur,
              style: TextStyle(
                color: color,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                    'Bienvenue ${widget.userData['nom']} 👋',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Hôpital partenaire SangConnect',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const Icon(Icons.notifications_outlined, size: 28),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard(
                'Demandes actives',
                '${stats['demandes_actives']}',
                Colors.red,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                'Donneurs disponibles',
                '${stats['donneurs_disponibles']}',
                Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatCard(
                'Demandes aujourd\'hui',
                '${stats['demandes_aujourdhui']}',
                Colors.blue,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                'Dons reçus',
                '${stats['dons_recus']}',
                Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dernières demandes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10),
              ],
            ),
            child: isLoading
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    ),
                  )
                : demandes.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Aucune demande',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: demandes.length > 5 ? 5 : demandes.length,
                    separatorBuilder: (_, __) =>
                        Divider(height: 1, color: Colors.grey[100]),
                    itemBuilder: (context, index) {
                      final demande = demandes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Text(
                              demande['groupe_sanguin'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '${demande['quantite']} poches',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            Text(
                              getUrgenceLabel(demande['urgence']),
                              style: TextStyle(
                                color: getUrgenceColor(demande['urgence']),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              getTemps(index),
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: showCreateDemandeDialog,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Nouvelle demande',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListeDemandes() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mes demandes',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.red),
            onPressed: loadDemandes,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateDemandeDialog,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : demandes.isEmpty
          ? const Center(child: Text('Aucune demande créée'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: demandes.length,
              itemBuilder: (context, index) {
                final demande = demandes[index];
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
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: getUrgenceColor(
                            demande['urgence'],
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            demande['groupe_sanguin'],
                            style: TextStyle(
                              color: getUrgenceColor(demande['urgence']),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${demande['quantite']} poches',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              demande['description'] ?? '',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: getUrgenceColor(demande['urgence']),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          getUrgenceLabel(demande['urgence']),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildProfil() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => setState(() => _currentIndex = 0),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_hospital,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.userData['nom'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Centre National Hospitalier Universitaire',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
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
                _buildInfoRow(
                  Icons.email_outlined,
                  widget.userData['email'] ?? '-',
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[100],
                  indent: 16,
                  endIndent: 16,
                ),
                _buildInfoRow(
                  Icons.phone_outlined,
                  widget.userData['telephone'] ?? '-',
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[100],
                  indent: 16,
                  endIndent: 16,
                ),
                _buildInfoRow(
                  Icons.location_on_outlined,
                  widget.userData['adresse'] ?? 'Cotonou, Bénin',
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[100],
                  indent: 16,
                  endIndent: 16,
                ),
                _buildInfoRow(
                  Icons.calendar_today_outlined,
                  'Membre depuis : Janvier 2025',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
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
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            )
          : null,
      body: _currentIndex == 0
          ? _buildAccueil()
          : _currentIndex == 1
          ? _buildListeDemandes()
          : _currentIndex == 2
          ? DonneursScreen(hopitalData: widget.userData)
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
            icon: Icon(Icons.list_alt_outlined),
            label: 'Demandes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Donneurs',
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
