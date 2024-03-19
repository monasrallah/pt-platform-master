class PurchaseIapSuccessPrams {
  int id;
  String? promotionCode;
  String coachId;
  String txnId;

  PurchaseIapSuccessPrams({
    required this.id,
    required this.coachId,
    required this.txnId,
    this.promotionCode,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": promotionCode,
        "coach_id": coachId,
        "txn_id": txnId,
      };
}
