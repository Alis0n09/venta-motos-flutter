import 'package:freezed_annotation/freezed_annotation.dart';

part 'direccion.freezed.dart';
part 'direccion.g.dart';

@freezed
class Direccion with _$Direccion {
  const factory Direccion({
    required int id,
    required int cliente,
    required String calle,
    required String ciudad,
    required String provincia,
    @Default(false) bool principal,
  }) = _Direccion;

  factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        id: json['id'] as int,
        cliente: json['cliente'] as int,
        calle: json['calle'] as String,
        ciudad: json['ciudad'] as String,
        provincia: json['provincia'] as String,
        principal: json['principal'] as bool? ?? false,
      );
}
