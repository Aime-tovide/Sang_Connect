import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost/blood_app/api';

  static Future<Map<String, dynamic>> registerUser(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register_user.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login_user.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> registerHopital(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register_hopital.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> loginHopital(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login_hopital.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // static Future<List<dynamic>> getDemandes({String? groupeSanguin}) async {
  //   try {
  //     String url = '$baseUrl/demandes/get_demandes.php';
  //     if (groupeSanguin != null) url += '?groupe_sanguin=$groupeSanguin';
  //     final response = await http.get(Uri.parse(url));
  //     final data = jsonDecode(response.body);
  //     return data['data'] ?? [];
  //   } catch (e) {
  //     return [];
  //   }
  // }
  static Future<List<dynamic>> getDemandes({String? groupeSanguin}) async {
    String url = '$baseUrl/demandes/get_demandes.php';
    if (groupeSanguin != null) {
      url += '?groupe_sanguin=${Uri.encodeComponent(groupeSanguin)}';
    }
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    return data['data'] ?? [];
  }

  static Future<Map<String, dynamic>> createDemande(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/demandes/create_demande.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> getStats(int hopitalId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/stats/get_stats.php?hopital_id=$hopitalId'),
    );
    final data = jsonDecode(response.body);
    return data['data'] ?? {};
  }

  static Future<List<dynamic>> getDonneursCompatibles({
    String? groupeSanguin,
  }) async {
    String url = '$baseUrl/users/get_donneurs_compatibles.php';
    if (groupeSanguin != null) {
      url += '?groupe_sanguin=${Uri.encodeComponent(groupeSanguin)}';
    }
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    return data['data'] ?? [];
  }

  static Future<Map<String, dynamic>> confirmerDon(
    int donneurId,
    int hopitalId,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/dons/confirmer_don.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'donneur_id': donneurId, 'hopital_id': hopitalId}),
    );
    return jsonDecode(response.body);
  }
}
