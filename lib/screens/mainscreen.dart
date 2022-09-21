import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:numb/services/db/db.dart';
import 'package:numb/services/idgen.dart';
import 'package:numb/widgets/container.dart';
import 'package:numb/widgets/expressionrow.dart';
import 'package:velocity_x/velocity_x.dart';

class MainCalcScreen extends StatefulWidget {
  const MainCalcScreen({super.key});

  @override
  State<MainCalcScreen> createState() => _MainCalcScreenState();
}

class _MainCalcScreenState extends State<MainCalcScreen> {
  List<Map> expressionList = [];

  Future<void> getDatabaseData() async {
    List<Map> data = await db.getData();
    setState(() {
      expressionList = data;
    });
  }

  Future<void> handleAdd() async {
    await db.add('', '--');
    getDatabaseData();
  }

  @override
  void initState() {
    getDatabaseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NumbContainer(
        child: Container(
      color: Theme.of(context).backgroundColor,
      child: Column(children: [
        Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: expressionList.length,
              itemBuilder: (context, index) {
                int id = expressionList[index]['id'];
                String key = expressionList[index]['key'];
                return Dismissible(
                    key: Key(key),
                    onDismissed: ((direction) async {
                      await db.delete(id);
                    }),
                    child: ExpressionRow(index: id));
              }),
        ),
        Align(
            alignment: Alignment.topRight,
            child: CupertinoButton(
                onPressed: handleAdd,
                child: Icon(Icons.add,
                    color: Theme.of(context).primaryIconTheme.color)))
      ]).px20().py8(),
    ));
  }
}
