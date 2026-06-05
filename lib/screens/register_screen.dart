// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import 'login_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final nomController = TextEditingController();
//   final prenomController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final telephoneController = TextEditingController();
//   final adresseController = TextEditingController();
//   String userType = 'donneur';
//   String groupeSanguin = 'A+';
//   bool isLoading = false;

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

//   void register() async {
//     setState(() => isLoading = true);
//     try {
//       Map<String, dynamic> result;
//       if (userType == 'donneur') {
//         result = await ApiService.registerUser({
//           'nom': nomController.text,
//           'prenom': prenomController.text,
//           'email': emailController.text,
//           'password': passwordController.text,
//           'telephone': telephoneController.text,
//           'groupe_sanguin': groupeSanguin,
//         });
//       } else {
//         result = await ApiService.registerHopital({
//           'nom': nomController.text,
//           'email': emailController.text,
//           'password': passwordController.text,
//           'telephone': telephoneController.text,
//           'adresse': adresseController.text,
//         });
//       }

//       if (result['success']) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Inscription réussie ! Connectez-vous.'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(result['message'])));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Erreur lors de l\'inscription')),
//       );
//     }
//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Inscription'),
//         backgroundColor: Colors.red,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => setState(() => userType = 'donneur'),
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: userType == 'donneur'
//                             ? Colors.red
//                             : Colors.grey[200],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Donneur',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: userType == 'donneur'
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => setState(() => userType = 'hopital'),
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: userType == 'hopital'
//                             ? Colors.red
//                             : Colors.grey[200],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Hôpital',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: userType == 'hopital'
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: nomController,
//               decoration: const InputDecoration(
//                 labelText: 'Nom',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             if (userType == 'donneur') ...[
//               TextField(
//                 controller: prenomController,
//                 decoration: const InputDecoration(
//                   labelText: 'Prénom',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//             ],
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Mot de passe',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: telephoneController,
//               decoration: const InputDecoration(
//                 labelText: 'Téléphone',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             if (userType == 'donneur') ...[
//               DropdownButtonFormField<String>(
//                 value: groupeSanguin,
//                 decoration: const InputDecoration(
//                   labelText: 'Groupe sanguin',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: groupes
//                     .map((g) => DropdownMenuItem(value: g, child: Text(g)))
//                     .toList(),
//                 onChanged: (val) => setState(() => groupeSanguin = val!),
//               ),
//             ],
//             if (userType == 'hopital') ...[
//               TextField(
//                 controller: adresseController,
//                 decoration: const InputDecoration(
//                   labelText: 'Adresse',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: isLoading ? null : register,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   padding: const EdgeInsets.all(16),
//                 ),
//                 child: isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text(
//                         "S'inscrire",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final telephoneController = TextEditingController();
  final adresseController = TextEditingController();
  String userType = 'donneur';
  String? groupeSanguin;
  String? ville;
  bool isLoading = false;
  bool obscurePassword = true;

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
  final List<String> villes = [
    'Cotonou',
    'Porto-Novo',
    'Parakou',
    'Abomey-Calavi',
    'Natitingou',
    'Bohicon',
  ];

  void register() async {
    if (nomController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() => isLoading = true);
    try {
      Map<String, dynamic> result;
      if (userType == 'donneur') {
        result = await ApiService.registerUser({
          'nom': nomController.text,
          'prenom': prenomController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'telephone': telephoneController.text,
          'groupe_sanguin': groupeSanguin ?? 'A+',
        });
      } else {
        result = await ApiService.registerHopital({
          'nom': nomController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'telephone': telephoneController.text,
          'adresse': ville ?? '',
        });
      }

      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inscription réussie !'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de l\'inscription'),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() => isLoading = false);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscurePassword : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: Colors.grey),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () =>
                      setState(() => obscurePassword = !obscurePassword),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required IconData icon,
    required List<String> items,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Row(
            children: [
              Icon(icon, color: Colors.grey, size: 22),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hint,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Text(
                    'Sélectionner',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              const Text(
                'Créer un compte',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Remplissez vos informations',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),
              // Toggle Donneur / Hôpital
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => userType = 'donneur'),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: userType == 'donneur'
                                ? Colors.red
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Donneur',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: userType == 'donneur'
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => userType = 'hopital'),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: userType == 'hopital'
                                ? Colors.red
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Hôpital',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: userType == 'hopital'
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Champs communs
              _buildTextField(
                controller: nomController,
                hint: 'Nom complet',
                icon: Icons.person_outline,
              ),
              if (userType == 'donneur')
                _buildTextField(
                  controller: prenomController,
                  hint: 'Prénom',
                  icon: Icons.person_outline,
                ),
              _buildTextField(
                controller: telephoneController,
                hint: 'Téléphone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                controller: emailController,
                hint: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                controller: passwordController,
                hint: 'Mot de passe',
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              if (userType == 'donneur') ...[
                _buildDropdown(
                  hint: 'Groupe sanguin',
                  icon: Icons.water_drop_outlined,
                  items: groupes,
                  value: groupeSanguin,
                  onChanged: (val) => setState(() => groupeSanguin = val),
                ),
                _buildDropdown(
                  hint: 'Ville',
                  icon: Icons.location_on_outlined,
                  items: villes,
                  value: ville,
                  onChanged: (val) => setState(() => ville = val),
                ),
              ],
              if (userType == 'hopital')
                _buildTextField(
                  controller: adresseController,
                  hint: 'Adresse',
                  icon: Icons.location_on_outlined,
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "S'inscrire",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Vous avez déjà un compte ? ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: 'Se connecter',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
