import 'dart:convert';


class ParticipantsField{

  static final id   = 'id';
  static final name = 'name';
  static final note = 'note';

  static List<String> getFields() => [id, name, note];
}
class Participants{
  

  const Participants({this.id, required this.name, required this.note});

  

  Map<String, dynamic> toJson()=>{
    ParticipantsField.id  : id,
    ParticipantsField.name: name,
    ParticipantsField.note: note
  };

  Participants clone({
    int? id,
    String? name,
    num? note,
  })=>Participants(id: id ?? this.id, name: name ?? this.name, note: note ?? this.note);

  static Participants fromJson(Map<String, dynamic> json) => Participants(
    id: jsonDecode(json[ParticipantsField.id]),
    name:json[ParticipantsField.name],
    note: jsonDecode(json[ParticipantsField.note]),
  );


  final int? id;
  final String name;
  final num? note;

}