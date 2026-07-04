class SubscriptionModel {
  final String id;
  final String name;
  final String addon;
  final int cost;
  final String currency;
  final String paymentCycle;
  final int startDate;
  final String category;
  final bool isFreeTrial;

  SubscriptionModel({
    required this.id,
    required this.name,
    required this.addon,
    required this.cost,
    required this.currency,
    required this.paymentCycle,
    required this.startDate,
    required this.category,
    required this.isFreeTrial,
  });

  /// Convert JSON to SubscriptionModel
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      addon: json['addon'] ?? '',
      cost: json['cost'] ?? 0,
      currency: json['currency'] ?? '',
      paymentCycle: json['paymentcycle'] ?? '',
      startDate: json['startDate'] ?? 0,
      category: json['category'] ?? '',
      isFreeTrial: json['isFreeTrial'] ?? false,
    );
  }

  /// Convert SubscriptionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'addon': addon,
      'cost': cost,
      'currency': currency,
      'paymentcycle': paymentCycle,
      'startDate': startDate,
      'category': category,
      'isFreeTrial': isFreeTrial,
    };
  }
}