class ProfileData {
  final String id;
  final String email;
  final String username;
  final String deviceUuid;
  final int role;
  final bool confirmed;

  ProfileData({
    this.id,
    this.email,
    this.username,
    this.deviceUuid,
    this.role,
    this.confirmed,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    var parsedConfirmed = json["result"]["confirmed"] == 0 ? true : false;

    return ProfileData(
      id: json["result"]["id"],
      email: json["result"]["email"],
      username: json["result"]["username"],
      deviceUuid: json["result"]["device_uuid"],
      role: json["result"]["role"],
      confirmed: parsedConfirmed,
    );
  }
}
