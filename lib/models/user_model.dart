class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? matricule;
  final String? category;
  final String? profileImage;
  final bool? isActive;
  final String? birthDate;

  User({
    this.id,
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
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      matricule: json['matricule'],
      category: json['categorie'],
      profileImage: json['profile_image'],
      isActive: json['is_active'],
      birthDate: json['birth_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'matricule': matricule,
      'categorie': category,
      'profile_image': profileImage,
      'is_active': isActive,
      'birth_date': birthDate,
    };
  }
}
