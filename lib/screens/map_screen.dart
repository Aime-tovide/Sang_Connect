// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import '../services/api_service.dart';

// class MapScreen extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   final String userType;
//   const MapScreen({super.key, required this.userData, required this.userType});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
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
//       final result = await ApiService.getDemandes();
//       setState(() => demandes = result);
//     } catch (e) {
//       print(e);
//     }
//     setState(() => isLoading = false);
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
//         title: const Text('Carte des demandes'),
//         backgroundColor: Colors.red,
//         foregroundColor: Colors.white,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator(color: Colors.red))
//           : FlutterMap(
//               options: const MapOptions(
//                 initialCenter: LatLng(6.3676, 2.4252),
//                 initialZoom: 13,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   userAgentPackageName: 'com.example.blood_app',
//                 ),
//                 MarkerLayer(
//                   markers: demandes
//                       .where(
//                         (d) => d['latitude'] != null && d['longitude'] != null,
//                       )
//                       .map((demande) {
//                         return Marker(
//                           point: LatLng(
//                             double.parse(demande['latitude'].toString()),
//                             double.parse(demande['longitude'].toString()),
//                           ),
//                           width: 80,
//                           height: 80,
//                           child: GestureDetector(
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                   title: Text(
//                                     demande['hopital_nom'] ?? 'Hôpital',
//                                   ),
//                                   content: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Groupe : ${demande['groupe_sanguin']}',
//                                       ),
//                                       Text(
//                                         'Quantité : ${demande['quantite']} poches',
//                                       ),
//                                       Text('Urgence : ${demande['urgence']}'),
//                                       Text(
//                                         'Contact : ${demande['hopital_telephone'] ?? 'N/A'}',
//                                       ),
//                                     ],
//                                   ),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(context),
//                                       child: const Text('Fermer'),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             child: Column(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(4),
//                                   decoration: BoxDecoration(
//                                     color: getUrgenceColor(demande['urgence']),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Text(
//                                     demande['groupe_sanguin'],
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 Icon(
//                                   Icons.location_on,
//                                   color: getUrgenceColor(demande['urgence']),
//                                   size: 30,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       })
//                       .toList(),
//                 ),
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';

class MapScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String userType;
  const MapScreen({super.key, required this.userData, required this.userType});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<dynamic> demandes = [];
  bool isLoading = true;

  // Position centrale Cotonou
  final LatLng _center = const LatLng(6.3676, 2.4252);

  @override
  void initState() {
    super.initState();
    loadDemandes();
  }

  void loadDemandes() async {
    setState(() => isLoading = true);
    try {
      final result = await ApiService.getDemandes();
      setState(() => demandes = result);
    } catch (e) {
      print(e);
    }
    setState(() => isLoading = false);
  }

  // Positions fictives pour la démo
  LatLng getPosition(int index) {
    final positions = [
      const LatLng(6.3750, 2.4200),
      const LatLng(6.3600, 2.4100),
      const LatLng(6.3700, 2.4400),
      const LatLng(6.3800, 2.4300),
      const LatLng(6.3550, 2.4350),
    ];
    return positions[index % positions.length];
  }

  String getDistance(int index) {
    final distances = ['2 km', '5 km', '7 km', '3 km', '4 km'];
    return distances[index % distances.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Carte des urgences',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : Column(
              children: [
                // Carte
                SizedBox(
                  height: 300,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: _center,
                        initialZoom: 13,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.blood_app',
                        ),
                        // Point bleu position actuelle
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _center,
                              width: 20,
                              height: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.4),
                                      blurRadius: 8,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Marqueurs hôpitaux
                            ...List.generate(
                              demandes.length > 5 ? 5 : demandes.length,
                              (index) => Marker(
                                point: getPosition(index),
                                width: 40,
                                height: 40,
                                child: GestureDetector(
                                  onTap: () {
                                    final demande = demandes[index];
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      builder: (context) => Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              demande['hopital_nom'] ??
                                                  'Hôpital',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Groupe : ${demande['groupe_sanguin']}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              'Quantité : ${demande['quantite']} poches',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              'Urgence : ${demande['urgence']}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Répondre',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Liste urgences
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${demandes.length} urgences proches',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.separated(
                            itemCount: demandes.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final demande = demandes[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        demande['hopital_nom'] ?? 'Hôpital',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      demande['groupe_sanguin'],
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      getDistance(index),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // Bouton actualiser
                        SizedBox(
                          width: double.infinity,
                          child: TextButton.icon(
                            onPressed: loadDemandes,
                            icon: const Icon(Icons.refresh, color: Colors.red),
                            label: const Text(
                              'Actualiser la carte',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
