



import 'dart:convert';

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

}