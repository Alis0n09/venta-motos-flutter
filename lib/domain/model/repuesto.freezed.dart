// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repuesto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Repuesto _$RepuestoFromJson(Map<String, dynamic> json) {
  return _Repuesto.fromJson(json);
}

/// @nodoc
mixin _$Repuesto {
  int get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  int? get marcaCompatible => throw _privateConstructorUsedError;
  String? get marcaCompatibleNombre => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  double get precio => throw _privateConstructorUsedError;

  /// Serializes this Repuesto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Repuesto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepuestoCopyWith<Repuesto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepuestoCopyWith<$Res> {
  factory $RepuestoCopyWith(Repuesto value, $Res Function(Repuesto) then) =
      _$RepuestoCopyWithImpl<$Res, Repuesto>;
  @useResult
  $Res call(
      {int id,
      String nombre,
      int? marcaCompatible,
      String? marcaCompatibleNombre,
      int stock,
      double precio});
}

/// @nodoc
class _$RepuestoCopyWithImpl<$Res, $Val extends Repuesto>
    implements $RepuestoCopyWith<$Res> {
  _$RepuestoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Repuesto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? marcaCompatible = freezed,
    Object? marcaCompatibleNombre = freezed,
    Object? stock = null,
    Object? precio = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      marcaCompatible: freezed == marcaCompatible
          ? _value.marcaCompatible
          : marcaCompatible // ignore: cast_nullable_to_non_nullable
              as int?,
      marcaCompatibleNombre: freezed == marcaCompatibleNombre
          ? _value.marcaCompatibleNombre
          : marcaCompatibleNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      precio: null == precio
          ? _value.precio
          : precio // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepuestoImplCopyWith<$Res>
    implements $RepuestoCopyWith<$Res> {
  factory _$$RepuestoImplCopyWith(
          _$RepuestoImpl value, $Res Function(_$RepuestoImpl) then) =
      __$$RepuestoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String nombre,
      int? marcaCompatible,
      String? marcaCompatibleNombre,
      int stock,
      double precio});
}

/// @nodoc
class __$$RepuestoImplCopyWithImpl<$Res>
    extends _$RepuestoCopyWithImpl<$Res, _$RepuestoImpl>
    implements _$$RepuestoImplCopyWith<$Res> {
  __$$RepuestoImplCopyWithImpl(
      _$RepuestoImpl _value, $Res Function(_$RepuestoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Repuesto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? marcaCompatible = freezed,
    Object? marcaCompatibleNombre = freezed,
    Object? stock = null,
    Object? precio = null,
  }) {
    return _then(_$RepuestoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      marcaCompatible: freezed == marcaCompatible
          ? _value.marcaCompatible
          : marcaCompatible // ignore: cast_nullable_to_non_nullable
              as int?,
      marcaCompatibleNombre: freezed == marcaCompatibleNombre
          ? _value.marcaCompatibleNombre
          : marcaCompatibleNombre // ignore: cast_nullable_to_non_nullable
              as String?,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      precio: null == precio
          ? _value.precio
          : precio // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepuestoImpl implements _Repuesto {
  const _$RepuestoImpl(
      {required this.id,
      required this.nombre,
      this.marcaCompatible,
      this.marcaCompatibleNombre,
      required this.stock,
      required this.precio});

  factory _$RepuestoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepuestoImplFromJson(json);

  @override
  final int id;
  @override
  final String nombre;
  @override
  final int? marcaCompatible;
  @override
  final String? marcaCompatibleNombre;
  @override
  final int stock;
  @override
  final double precio;

  @override
  String toString() {
    return 'Repuesto(id: $id, nombre: $nombre, marcaCompatible: $marcaCompatible, marcaCompatibleNombre: $marcaCompatibleNombre, stock: $stock, precio: $precio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepuestoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.marcaCompatible, marcaCompatible) ||
                other.marcaCompatible == marcaCompatible) &&
            (identical(other.marcaCompatibleNombre, marcaCompatibleNombre) ||
                other.marcaCompatibleNombre == marcaCompatibleNombre) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.precio, precio) || other.precio == precio));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nombre, marcaCompatible,
      marcaCompatibleNombre, stock, precio);

  /// Create a copy of Repuesto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepuestoImplCopyWith<_$RepuestoImpl> get copyWith =>
      __$$RepuestoImplCopyWithImpl<_$RepuestoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepuestoImplToJson(
      this,
    );
  }
}

abstract class _Repuesto implements Repuesto {
  const factory _Repuesto(
      {required final int id,
      required final String nombre,
      final int? marcaCompatible,
      final String? marcaCompatibleNombre,
      required final int stock,
      required final double precio}) = _$RepuestoImpl;

  factory _Repuesto.fromJson(Map<String, dynamic> json) =
      _$RepuestoImpl.fromJson;

  @override
  int get id;
  @override
  String get nombre;
  @override
  int? get marcaCompatible;
  @override
  String? get marcaCompatibleNombre;
  @override
  int get stock;
  @override
  double get precio;

  /// Create a copy of Repuesto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepuestoImplCopyWith<_$RepuestoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
