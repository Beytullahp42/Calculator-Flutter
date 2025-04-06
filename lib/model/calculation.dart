import 'dart:convert';

class Calculation {
  final int? id;
  final String calculation;
  final DateTime date;

  const Calculation({
    this.id,
    required this.calculation,
    required this.date,
  });



  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'calculation': calculation,
      'date': date.toIso8601String(),
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map){
    return Calculation(
      id: map['id'],
      calculation: map['calculation'],
      date: DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Calculation.fromJson(String source) => Calculation.fromMap(json.decode(source));


}
