import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'card.g.dart';

abstract class BuiltCard implements Built<BuiltCard, BuiltCardBuilder> {
  String? get idString;
  String? get owner;
  String? get name;
  String? get status;
  String? get college_name;
  String? get regNumber;
  String? get department;
  String? get locationFound;
  
  BuiltCard._();

  factory BuiltCard([Function(BuiltCardBuilder b) updates]) = _$BuiltCard;

  static Serializer<BuiltCard> get serializer => _$builtCardSerializer;
}
