import 'dart:convert';

class BillEncoder {
  final List<String> data;

  BillEncoder(this.data);

  factory BillEncoder.fromJsonList(List<Map<String, dynamic>> bills) {
    List<String> data = [];

    for (var element in bills) {
      data.add(const JsonEncoder().convert(element));
    }

    return BillEncoder(data);
  }
}
