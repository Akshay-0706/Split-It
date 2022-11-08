import 'dart:convert';

class BillDecoder {
  final List<Map<String, dynamic>> data;

  BillDecoder(this.data);

  factory BillDecoder.fromStringList(List<String> bills) {
    List<Map<String, dynamic>> data = [];

    for (var element in bills) {
      data.add(const JsonDecoder().convert(element));
    }

    return BillDecoder(data);
  }
}
