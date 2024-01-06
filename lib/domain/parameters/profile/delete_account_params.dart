class DeleteAccountParams {
  String devicePlayerId;
  String password;

  Map<String, dynamic> toJson() => {
        "device_player_id": devicePlayerId,
        "password": password,
      };

  DeleteAccountParams({required this.devicePlayerId, required this.password});
}
