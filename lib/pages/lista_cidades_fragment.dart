




import 'package:api/pages/form_cidade_page.dart';
import 'package:api/services/cidade_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/cidade.dart';

class ListaCidadesFragment extends StatefulWidget{
  static const title = 'Cidades';

  const ListaCidadesFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListaCidadesFragmentState();
}
class ListaCidadesFragmentState extends State<ListaCidadesFragment> {
  final _service = CidadeService();
  final List<Cidade> _cidade = [];
  final _refreshIndicatorkey = GlobalKey<RefreshIndicatorState>();

  @override
  void initiState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _refreshIndicatorkey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (_, constraints) {
          Widget content;
          if (_cidade.isEmpty) {
            content = SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: const Center(
                  child: Text('Nenhuma cidade cadastrada'),
                ),
              ),
            );
          } else {
            content = ListView.separated(
              itemCount: _cidade.length,
              itemBuilder: (_, index) {
                final cidade = _cidade[index];
                return ListTile(
                  title: Text('${cidade.nome} - ${cidade.uf}'),
                  onTap: () => _montrarDialogActions(cidade),
                );
              },
              separatorBuilder: (_, __) => Divider(),
            );
          }
          return RefreshIndicator(
            key: _refreshIndicatorkey,
            child: content,
            onRefresh: _findCidades,
          );
        },
      ),
    );
  }

  Future<void> _findCidades() async {
    await Future.delayed(const Duration(seconds: 2));
    final cidades = await _service.findCidades();
    setState(() {
      _cidade.clear();
      if (cidades.isNotEmpty) {
        _cidade.addAll(cidades);
      }
    });
  }

  void _montrarDialogActions(Cidade cidade) {
    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text('${cidade.nome} - ${cidade.uf}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Editar'),
                    onTap: () {
                      Navigator.pop(context);
                      abrirForm(cidade: cidade);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.delete,
                        color: Colors.red),
                    title: const Text('Excluir'),
                    onTap: () {
                      Navigator.pop(context);
                      _excluirCidade(cidade);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
              ],
            )
    );
  }

  void abrirForm({Cidade? cidade}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => FormCidadePage(cidade: cidade)
    )).then((changed) {
      if (changed == true) {
        _refreshIndicatorkey.currentState?.show();
      }
    });
  }
  void _excluirCidade(Cidade cidade){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Atenção'),
          content: Text('O registro "${cidade.nome} - ${cidade.uf}" será deletado definitivamente'),
          actions: [
            TextButton(
                onPressed:() => Navigator.pop(context),
                child: Text('Cancelar')
            ),
            TextButton(
                onPressed:(){
                   Navigator.pop(context);
                    _service.deleteCidade(cidade).then((_) {
                      _refreshIndicatorkey.currentState?.show();
               }).catchError((error, StackTrace){
                 debugPrint(StackTrace ?? error);
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                   content: Text('Não foi possível remover a cidade, tente novamente')));
                  });
                  },
                child: Text('OK')
            )
          ],
        ));
  }
}