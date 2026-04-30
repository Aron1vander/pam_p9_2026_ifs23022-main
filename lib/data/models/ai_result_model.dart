/// Model hasil generate AI untuk tumbuhan
class PlantAiResult {
  const PlantAiResult({
    required this.deskripsi,
    required this.manfaat,
    required this.efekSamping,
  });

  final String deskripsi;
  final String manfaat;
  final String efekSamping;

  factory PlantAiResult.fromJson(Map<String, dynamic> json) {
    return PlantAiResult(
      deskripsi:   json['deskripsi']   as String? ?? '',
      manfaat:     json['manfaat']     as String? ?? '',
      efekSamping: json['efekSamping'] as String? ?? '',
    );
  }
}

/// Model hasil generate AI untuk objek luar angkasa
class SpaceAiResult {
  const SpaceAiResult({
    required this.deskripsi,
    required this.fakta,
    required this.jarakDariBumi,
  });

  final String deskripsi;
  final String fakta;
  final String jarakDariBumi;

  factory SpaceAiResult.fromJson(Map<String, dynamic> json) {
    return SpaceAiResult(
      deskripsi:     json['deskripsi']     as String? ?? '',
      fakta:         json['fakta']         as String? ?? '',
      jarakDariBumi: json['jarakDariBumi'] as String? ?? '',
    );
  }
}