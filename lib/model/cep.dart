



import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Cep{
  final String? cep;
  final String? logradouro;
  final String? complemento;
  final String? bairro;
  final String? localidade;
  final String? uf;
  final String? igbe;
  final String? gia;
  @JsonKey(name: 'ddd')
  final String? codiaDeArea;
  final String? siafi;

  Cep({this.cep, this.logradouro, this. complemento, this.bairro, this.localidade,
  this.uf, this.igbe, this.gia, this.codiaDeArea, this.siafi});
  factory Cep.fromJson(Map<String, dynamic> json) =>_$CepFromJson(json);
  Map<String, dynamic> toJson() => _$CepToJson(this);


}
