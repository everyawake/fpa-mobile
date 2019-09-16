class PushNotification {
  final String socketId;
  final String page;
  final String thirdPartyName;

  PushNotification({
    this.page,
    this.socketId,
    this.thirdPartyName,
  });

  factory PushNotification.fromJson(Map<String, dynamic> json) {
    print("@@@ ${json}");
    return PushNotification(
      page: json["page"],
      socketId: json["socketId"],
      thirdPartyName: json["thirdPartyName"],
    );
  }
}
