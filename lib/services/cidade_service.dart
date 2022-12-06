



import 'dart:convert';
import 'dart:io';

import 'package:api/model/cidade.dart';
import 'package:http/http.dart';

class CidadeService{
  static const _base_url = 'http://cloud.colegiomaterdei.com.br:8090/cidades';

  Future<List<Cidade>> findCidades() async {
    final uri = Uri.parse(_base_url);
    Response respose = await get(uri);
    if(respose.statusCode != 200 || respose.body.isEmpty){
      throw Exception();
    }
    final decodedBody = json.decode(respose.body) as List;
    return decodedBody
        .map((e) => Cidade.fromJson(Map<String, dynamic>.from(e))).toList();
  }
  Future<void> saveCidade(Cidade cidade) async{
    final uri = Uri.parse(_base_url);
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final body = cidade.toJson();
    final Response response = await post(uri, body: json.encode(body), headers: headers);
    if(response.statusCode != 200 || response.body.isEmpty){
      throw Exception();
    }
  }

  Future<void> deleteCidade(Cidade cidade) async{
    final uri = Uri.parse('$_base_url/${cidade.codigo}');
    final Response responde = await delete(uri);
    if(responde.statusCode != 200){
      throw Exception();
    }

  }

}