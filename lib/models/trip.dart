class Trip {
  const Trip({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.pickup,
    required this.drop,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as int,
      title: json['title'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
      pickup: json['pickup'] as String,
      drop: json['drop'] as String,
    );
  }

  final int id;
  final String title;
  final String date;
  final String status;
  final String pickup;
  final String drop;

  Trip copyWith({
    int? id,
    String? title,
    String? date,
    String? status,
    String? pickup,
    String? drop,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      status: status ?? this.status,
      pickup: pickup ?? this.pickup,
      drop: drop ?? this.drop,
    );
  }
}
