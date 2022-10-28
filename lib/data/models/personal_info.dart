class PersonalInfo {
  String firstName;
  String lastName;
  String phoneNumber;
  String profileImageUrl;
  String userId;

  PersonalInfo({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userId,
    this.profileImageUrl = "",
  });
  static PersonalInfo fromDocSnap(Map<String, dynamic>? snap) {
    return PersonalInfo(
      firstName: snap?["firstName"] ?? "",
      lastName: snap?["lastName"] ?? "",
      phoneNumber: snap?["phoneNumber"] ?? "",
      profileImageUrl: snap?["profileImageUrl"] ?? "",
      userId: snap?["userId"] ?? "",
    );
  }

  Map<String, dynamic> toMap() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'profileImageUrl': profileImageUrl,
        'uid': userId,
      };
}
