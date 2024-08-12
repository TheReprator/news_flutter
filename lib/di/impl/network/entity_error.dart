import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entity_error.g.dart';

abstract class EntityError implements Built<EntityError, EntityErrorBuilder> {
  EntityError._();

  String? get code;
  String? get message;

  factory EntityError([void Function(EntityErrorBuilder)? updates]) =
      _$EntityError;

  static Serializer<EntityError> get serializer => _$entityErrorSerializer;
}
