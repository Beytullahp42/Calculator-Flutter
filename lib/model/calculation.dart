import 'dart:convert';

class Calculation {
  final int? id;
  final String calculation;
  final String result;
  final DateTime date;

  const Calculation({
    this.id,
    required this.calculation,
    required this.result,
    required this.date,
  });



  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'calculation': calculation,
      'result': result,
      'date': date.toIso8601String(),
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map){
    return Calculation(
      id: map['id'],
      calculation: map['calculation'],
      result: map['result'],
      date: DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Calculation.fromJson(String source) => Calculation.fromMap(json.decode(source));


}
