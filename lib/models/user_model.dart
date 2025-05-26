class User {
  final int? id;
  final int? patientId; // Add this line
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? matricule;
  final String? category;
  String? profileImage; // Remove `late` to allow reassignment
  final bool? isActive;
  final String? birthDate;

  User({
    this.id,
    this.patientId, // Add this line
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.matricule,
    this.category,
    this.profileImage,
    this.isActive,
    this.birthDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      patientId: json['patient_id'], // Add this line
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      matricule: json['matricule'],
      category: json['categorie'],
      profileImage: json['profile_image'] ?? json['photo'], // Accept both
      isActive: json['is_active'],
      birthDate: json['date_naissance'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId, // Add this line
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'matricule': matricule,
      'categorie': category,
      'profile_image': profileImage, // Include this field
      'is_active': isActive,
      'birth_date': birthDate,
    };
  }

  User copyWith({
    int? id,
    int? patientId, // Add this line
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? matricule,
    String? category,
    String? profileImage,
    bool? isActive,
    String? birthDate,
  }) {
    return User(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId, // Add this line
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      matricule: matricule ?? this.matricule,
      category: category ?? this.category,
      profileImage: profileImage ?? this.profileImage,
      isActive: isActive ?? this.isActive,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
