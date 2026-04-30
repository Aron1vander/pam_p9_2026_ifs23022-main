import 'package:flutter/foundation.dart';
import '../data/models/ai_result_model.dart';
import '../data/services/ai_service.dart';

enum AiStatus { idle, loading, success, error }

class AiProvider extends ChangeNotifier {
  AiProvider({AiService? service}) : _service = service ?? AiService();
  final AiService _service;

  AiStatus _status = AiStatus.idle;
  String _errorMessage = '';
  PlantAiResult? _plantResult;
  SpaceAiResult? _spaceResult;

  AiStatus get status       => _status;
  String get errorMessage   => _errorMessage;
  PlantAiResult? get plantResult => _plantResult;
  SpaceAiResult? get spaceResult => _spaceResult;
  bool get isLoading        => _status == AiStatus.loading;

  Future<PlantAiResult?> generateForPlant(String nama) async {
    if (nama.trim().isEmpty) {
      _errorMessage = 'Nama tanaman harus diisi terlebih dahulu.';
      _status = AiStatus.error;
      notifyListeners();
      return null;
    }

    _status = AiStatus.loading;
    _plantResult = null;
    notifyListeners();

    final result = await _service.generatePlantDescription(nama);

    if (result.success && result.data != null) {
      _plantResult = result.data;
      _status = AiStatus.success;
      notifyListeners();
      return _plantResult;
    }

    _errorMessage = result.message;
    _status = AiStatus.error;
    notifyListeners();
    return null;
  }

  Future<SpaceAiResult?> generateForSpace({
    required String nama,
    required String tipe,
  }) async {
    if (nama.trim().isEmpty) {
      _errorMessage = 'Nama objek harus diisi terlebih dahulu.';
      _status = AiStatus.error;
      notifyListeners();
      return null;
    }

    _status = AiStatus.loading;
    _spaceResult = null;
    notifyListeners();

    final result = await _service.generateSpaceDescription(nama: nama, tipe: tipe);

    if (result.success && result.data != null) {
      _spaceResult = result.data;
      _status = AiStatus.success;
      notifyListeners();
      return _spaceResult;
    }

    _errorMessage = result.message;
    _status = AiStatus.error;
    notifyListeners();
    return null;
  }

  void reset() {
    _status = AiStatus.idle;
    _plantResult = null;
    _spaceResult = null;
    _errorMessage = '';
    notifyListeners();
  }
}