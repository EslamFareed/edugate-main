class Major {
  final String score;
  final String fees;
  final String name;

  Major({required this.score, required this.fees, required this.name});

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(score: json['score'], fees: json['fees'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'score': score, 'fees': fees, 'name': name};
  }
}
