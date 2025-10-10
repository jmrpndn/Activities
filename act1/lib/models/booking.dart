class Booking {
  final String id;
  final String serviceId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final DateTime dateTime;
  final String status; // 'pending', 'confirmed', 'completed', 'cancelled'
  final String notes;
  final double totalPrice;

  const Booking({
    required this.id,
    required this.serviceId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.dateTime,
    required this.status,
    required this.notes,
    required this.totalPrice,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      serviceId: json['serviceId'],
      customerName: json['customerName'],
      customerEmail: json['customerEmail'],
      customerPhone: json['customerPhone'],
      dateTime: DateTime.parse(json['dateTime']),
      status: json['status'],
      notes: json['notes'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceId': serviceId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
      'notes': notes,
      'totalPrice': totalPrice,
    };
  }

  Booking copyWith({
    String? id,
    String? serviceId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    DateTime? dateTime,
    String? status,
    String? notes,
    double? totalPrice,
  }) {
    return Booking(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
