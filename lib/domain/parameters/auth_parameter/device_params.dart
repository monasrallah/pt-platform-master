class DeviceParams {
  String playerId;
  String platform;
  String timezone;
  String appVersion;

  DeviceParams(
      {required this.playerId,
        required this.platform,
        required this.timezone,
        required this.appVersion});

  Map<String, dynamic> toJson() => {
    "player_id": playerId,
    "platform": platform,
    "timezone": timezone,
    "app_version": appVersion,
  };
}