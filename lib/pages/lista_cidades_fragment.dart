




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaCidadesFragment extends StatefulWidget{
  static const title = 'Cidades';

  const ListaCidadesFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListaCidadesFragmentState();
}
class _ListaCidadesFragmentState extends State<ListaCidadesFragment>{
  final _refreshIndicatorkey =GlobalKey<RefreshIndicatorState>();

  Widget build(BuildContext context){
    return Container();
  }
}