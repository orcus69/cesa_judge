class ParticipantsField{
  static final id   = 'id';
  static final name = 'name';
  static final note = 'note';

  static List<String> getFields() => [id, name, note];
}
class Partipants{

  const Partipants({this.id, required this.name, required this.note});

  Map<String, dynamic> toJson()=>{
    ParticipantsField.id  : id,
    ParticipantsField.name: name,
    ParticipantsField.note: note
  };

  Partipants clone({
    int? id,
    String? name,
    String? note,
  })=>Partipants(id: id ?? this.id, name: name ?? this.name, note: note ?? this.note);


  final int? id;
  final String name;
  final String note;

}