import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ai_result_model.dart';
import '../models/api_response_model.dart';
import '../../core/constants/api_constants.dart';

class AiService {
  AiService({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;

  Future<ApiResponse<PlantAiResult>> generatePlantDescription(String nama) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.aiPlant}');
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nama': nama}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;
        return ApiResponse(
          success: true,
          message: body['message'] as String? ?? 'Berhasil.',
          data: PlantAiResult.fromJson(data),
        );
      }
      return ApiResponse(
        success: false,
        message: _parseError(response),
      );
    } catch (e) {
      return ApiResponse(success: false, message: 'Kesalahan jaringan: $e');
    }
  }

  Future<ApiResponse<SpaceAiResult>> generateSpaceDescription({
    required String nama,
    required String tipe,
  }) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.aiSpace}');
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nama': nama, 'tipe': tipe}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;
        return ApiResponse(
          success: true,
          message: body['message'] as String? ?? 'Berhasil.',
          data: SpaceAiResult.fromJson(data),
        );
      }
      return ApiResponse(
        success: false,
        message: _parseError(response),
      );
    } catch (e) {
      return ApiResponse(success: false, message: 'Kesalahan jaringan: $e');
    }
  }

  String _parseError(http.Response response) {
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['message'] as String? ?? 'Gagal. Kode: ${response.statusCode}';
    } catch (_) {
      return 'Gagal. Kode: ${response.statusCode}';
    }
  }

  void dispose() => _client.close();
}