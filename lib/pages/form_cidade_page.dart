




import 'package:api/services/cidade_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/cidade.dart';

class FormCidadePage extends StatefulWidget{
  final Cidade? cidade;

  const FormCidadePage({this.cidade});


  @override
  State<StatefulWidget> createState() => _FormCidadeState();
}
class _FormCidadeState extends State<FormCidadePage> {
  final _service = CidadeService();
  var _saving = false;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  String? _currentUf;

  @override
  void initilState(){
    super.initState();
    if(widget.cidade != null){
      _nomeController.text = widget.cidade!.nome;
      _currentUf = widget.cidade!.uf;
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _buildAppBar(),
      body: null//_buildBody(),
    );
  }

  AppBar _buildAppBar(){
    final String title;
    if(widget.cidade == null){
      title = 'Nova Cidade';
    }else{
      title = 'Alterar Cidade';
    }
    final Widget  titleWidget;
    if(_saving){
      titleWidget = Row(
        children: [
          Expanded(
              child: Text(title)),
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        ],
      );
    }else{
      titleWidget = Text(title);
    }
    return AppBar(
      title: titleWidget,
      actions: [
        if (!_saving)
        IconButton(
          icon: Icon(Icons.check),
          onPressed: null//_save,
        ),
      ],
    );
  }

}