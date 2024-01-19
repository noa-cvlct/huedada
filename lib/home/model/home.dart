class Home {
  const Home({
    required this.name,
    this.isOn = false,
  });

  factory Home.fromFirebase(String id, Map<String, dynamic> data) {
    return Home(
      name: data['name'] as String,
      isOn: data['isOn'] as bool,
    );
  }

  final String name;
  final bool isOn;

  Home copyWith({
    String? name,
    bool? isOn,
  }) {
    return Home(
      name: name ?? this.name,
      isOn: isOn ?? this.isOn,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'isOn': isOn,
    };
  }
}
