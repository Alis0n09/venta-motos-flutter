// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resena.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Resena _$ResenaFromJson(Map<String, dynamic> json) {
  return _Resena.fromJson(json);
}

/// @nodoc
mixin _$Resena {
  int get id => throw _privateConstructorUsedError;
  int get moto => throw _privateConstructorUsedError;
  String? get motoNombre => throw _privateConstructorUsedError;
  int? get cliente => throw _privateConstructorUsedError;
  String? get clienteNombre => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String get comentario => throw _privateConstructorUsedError;
  DateTime get fecha => throw _privateConstructorUsedError;

  /// Serializes this Resena to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Resena
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResenaCopyWith<Resena> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResenaCopyWith<$Res> {
  factory $ResenaCopyWith(Resena value, $Res Function(Resena) then) =
      _$ResenaCopyWithImpl<$Res, Resena>;
  @useResult
  $Res call(
      {int id,
      int moto,
      String? motoNombre,
      int? cliente,
      String? clienteNombre,
      int rating,
      String comentario,
      DateTime fecha});
}

/// @nodoc
class _$ResenaCopyWithImpl<$Res, $Val extends Resena>
    implements $ResenaCopyWith<$Res> {
  _$ResenaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Resena
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moto = null,
    Object? motoNombre = freezed,
    Object? cliente = freezed,
    Object? clienteNombre = freezed,
    Object? rating = null,
    Object? comentario = null,
    Object? fecha = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      moto: null == moto
          ? _value.moto
          : moto // ignore: cast_nullable_to_non_nullable
              as int,
      motoNombre: freezed == motoNombre
          ? _value.motoNombre
          : motoNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      cliente: freezed == cliente
          ? _value.cliente
          : cliente // ignore: cast_nullable_to_non_nullable
              as int?,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      comentario: null == comentario
          ? _value.comentario
          : comentario // ignore: cast_nullable_to_non_nullable
              as String,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResenaImplCopyWith<$Res> implements $ResenaCopyWith<$Res> {
  factory _$$ResenaImplCopyWith(
          _$ResenaImpl value, $Res Function(_$ResenaImpl) then) =
      __$$ResenaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int moto,
      String? motoNombre,
      int? cliente,
      String? clienteNombre,
      int rating,
      String comentario,
      DateTime fecha});
}

/// @nodoc
class __$$ResenaImplCopyWithImpl<$Res>
    extends _$ResenaCopyWithImpl<$Res, _$ResenaImpl>
    implements _$$ResenaImplCopyWith<$Res> {
  __$$ResenaImplCopyWithImpl(
      _$ResenaImpl _value, $Res Function(_$ResenaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Resena
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moto = null,
    Object? motoNombre = freezed,
    Object? cliente = freezed,
    Object? clienteNombre = freezed,
    Object? rating = null,
    Object? comentario = null,
    Object? fecha = null,
  }) {
    return _then(_$ResenaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      moto: null == moto
          ? _value.moto
          : moto // ignore: cast_nullable_to_non_nullable
              as int,
      motoNombre: freezed == motoNombre
          ? _value.motoNombre
          : motoNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      cliente: freezed == cliente
          ? _value.cliente
          : cliente // ignore: cast_nullable_to_non_nullable
              as int?,
      clienteNombre: freezed == clienteNombre
          ? _value.clienteNombre
          : clienteNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      comentario: null == comentario
          ? _value.comentario
          : comentario // ignore: cast_nullable_to_non_nullable
              as String,
      fecha: null == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResenaImpl implements _Resena {
  const _$ResenaImpl(
      {required this.id,
      required this.moto,
      this.motoNombre,
      this.cliente,
      this.clienteNombre,
      required this.rating,
      required this.comentario,
      required this.fecha});

  factory _$ResenaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResenaImplFromJson(json);

  @override
  final int id;
  @override
  final int moto;
  @override
  final String? motoNombre;
  @override
  final int? cliente;
  @override
  final String? clienteNombre;
  @override
  final int rating;
  @override
  final String comentario;
  @override
  final DateTime fecha;

  @override
  String toString() {
    return 'Resena(id: $id, moto: $moto, motoNombre: $motoNombre, cliente: $cliente, clienteNombre: $clienteNombre, rating: $rating, comentario: $comentario, fecha: $fecha)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResenaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.moto, moto) || other.moto == moto) &&
            (identical(other.motoNombre, motoNombre) ||
                other.motoNombre == motoNombre) &&
            (identical(other.cliente, cliente) || other.cliente == cliente) &&
            (identical(other.clienteNombre, clienteNombre) ||
                other.clienteNombre == clienteNombre) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comentario, comentario) ||
                other.comentario == comentario) &&
            (identical(other.fecha, fecha) || other.fecha == fecha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, moto, motoNombre, cliente,
      clienteNombre, rating, comentario, fecha);

  /// Create a copy of Resena
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResenaImplCopyWith<_$ResenaImpl> get copyWith =>
      __$$ResenaImplCopyWithImpl<_$ResenaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResenaImplToJson(
      this,
    );
  }
}

abstract class _Resena implements Resena {
  const factory _Resena(
      {required final int id,
      required final int moto,
      final String? motoNombre,
      final int? cliente,
      final String? clienteNombre,
      required final int rating,
      required final String comentario,
      required final DateTime fecha}) = _$ResenaImpl;

  factory _Resena.fromJson(Map<String, dynamic> json) = _$ResenaImpl.fromJson;

  @override
  int get id;
  @override
  int get moto;
  @override
  String? get motoNombre;
  @override
  int? get cliente;
  @override
  String? get clienteNombre;
  @override
  int get rating;
  @override
  String get comentario;
  @override
  DateTime get fecha;

  /// Create a copy of Resena
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResenaImplCopyWith<_$ResenaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
