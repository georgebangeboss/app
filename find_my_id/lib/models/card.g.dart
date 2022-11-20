// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltCard> _$builtCardSerializer = new _$BuiltCardSerializer();

class _$BuiltCardSerializer implements StructuredSerializer<BuiltCard> {
  @override
  final Iterable<Type> types = const [BuiltCard, _$BuiltCard];
  @override
  final String wireName = 'BuiltCard';

  @override
  Iterable<Object?> serialize(Serializers serializers, BuiltCard object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.idString;
    if (value != null) {
      result
        ..add('idString')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.owner;
    if (value != null) {
      result
        ..add('owner')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.college_name;
    if (value != null) {
      result
        ..add('college_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.regNumber;
    if (value != null) {
      result
        ..add('regNumber')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.department;
    if (value != null) {
      result
        ..add('department')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.locationFound;
    if (value != null) {
      result
        ..add('locationFound')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  BuiltCard deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltCardBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'idString':
          result.idString = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'owner':
          result.owner = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'college_name':
          result.college_name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'regNumber':
          result.regNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'department':
          result.department = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'locationFound':
          result.locationFound = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltCard extends BuiltCard {
  @override
  final String? idString;
  @override
  final String? owner;
  @override
  final String? name;
  @override
  final String? status;
  @override
  final String? college_name;
  @override
  final String? regNumber;
  @override
  final String? department;
  @override
  final String? locationFound;

  factory _$BuiltCard([void Function(BuiltCardBuilder)? updates]) =>
      (new BuiltCardBuilder()..update(updates))._build();

  _$BuiltCard._(
      {this.idString,
      this.owner,
      this.name,
      this.status,
      this.college_name,
      this.regNumber,
      this.department,
      this.locationFound})
      : super._();

  @override
  BuiltCard rebuild(void Function(BuiltCardBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltCardBuilder toBuilder() => new BuiltCardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltCard &&
        idString == other.idString &&
        owner == other.owner &&
        name == other.name &&
        status == other.status &&
        college_name == other.college_name &&
        regNumber == other.regNumber &&
        department == other.department &&
        locationFound == other.locationFound;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, idString.hashCode), owner.hashCode),
                            name.hashCode),
                        status.hashCode),
                    college_name.hashCode),
                regNumber.hashCode),
            department.hashCode),
        locationFound.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BuiltCard')
          ..add('idString', idString)
          ..add('owner', owner)
          ..add('name', name)
          ..add('status', status)
          ..add('college_name', college_name)
          ..add('regNumber', regNumber)
          ..add('department', department)
          ..add('locationFound', locationFound))
        .toString();
  }
}

class BuiltCardBuilder implements Builder<BuiltCard, BuiltCardBuilder> {
  _$BuiltCard? _$v;

  String? _idString;
  String? get idString => _$this._idString;
  set idString(String? idString) => _$this._idString = idString;

  String? _owner;
  String? get owner => _$this._owner;
  set owner(String? owner) => _$this._owner = owner;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _college_name;
  String? get college_name => _$this._college_name;
  set college_name(String? college_name) => _$this._college_name = college_name;

  String? _regNumber;
  String? get regNumber => _$this._regNumber;
  set regNumber(String? regNumber) => _$this._regNumber = regNumber;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  String? _locationFound;
  String? get locationFound => _$this._locationFound;
  set locationFound(String? locationFound) =>
      _$this._locationFound = locationFound;

  BuiltCardBuilder();

  BuiltCardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idString = $v.idString;
      _owner = $v.owner;
      _name = $v.name;
      _status = $v.status;
      _college_name = $v.college_name;
      _regNumber = $v.regNumber;
      _department = $v.department;
      _locationFound = $v.locationFound;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltCard other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BuiltCard;
  }

  @override
  void update(void Function(BuiltCardBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BuiltCard build() => _build();

  _$BuiltCard _build() {
    final _$result = _$v ??
        new _$BuiltCard._(
            idString: idString,
            owner: owner,
            name: name,
            status: status,
            college_name: college_name,
            regNumber: regNumber,
            department: department,
            locationFound: locationFound);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
