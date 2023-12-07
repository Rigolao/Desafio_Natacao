class TempoVolta {
  int tempo;
  int tempoVolta;
  int volta;
  bool isMelhorVolta;
  bool isPiorVolta;

  TempoVolta(
      {required this.tempo,
      required this.tempoVolta,
      required this.volta,
      required this.isMelhorVolta,
      required this.isPiorVolta});

  TempoVolta.fromJson(Map<String, dynamic> json)
      : tempo = json['tempo']  ?? 0,
        tempoVolta = json['tempoVolta'] ?? 0,
        volta = json['volta'] ?? 0,
        isMelhorVolta = json['isMelhorVolta'] ?? false,
        isPiorVolta = json['isPiorVolta'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'tempo': tempo,
      'tempoVolta': tempoVolta,
      'volta': volta,
      'isMelhorVolta': isMelhorVolta,
      'isPiorVolta': isPiorVolta,
    };
  }
}
