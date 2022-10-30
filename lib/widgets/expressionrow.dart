import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:numb/engines/main.dart';
import 'package:numb/services/db/db.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpressionRow extends StatefulWidget {
  final int index;
  const ExpressionRow({super.key, required this.index});

  @override
  State<ExpressionRow> createState() => _ExpressionRowState();
}

class _ExpressionRowState extends State<ExpressionRow> {
  String result = '--';
  TextEditingController textEditingController = TextEditingController();
  List<String> hints = [
    '1 plus 1',
    'log(2) times 20',
    '60 * pi',
    '5usd in gbp',
    '80km/hr to miles/hr',
    '4miles in meters',
    '(pi * 120) / log(32)',
    '89+30-82*78/5',
    '1/2 + 2/3',
    '59 divided-by 8'
  ];
  late String hint;

  Future<void> handleInput(String text) async {
    String res = await numbEngine(text);
    setState(() {
      result = res;
    });
    await db.modify(widget.index, text, result);
  }

  Future<void> replaceData() async {
    Map data = (await db.getIdData(widget.index));
    setState(() {
      result = data['result'];
      textEditingController.text = data['calculation'];
    });
  }

  @override
  void initState() {
    super.initState();
    hint = hints[Random().nextInt(10).toInt()];
    replaceData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: TextField(
              keyboardAppearance: Theme.of(context).brightness,
              controller: textEditingController,
              autocorrect: false,
              maxLines: 5,
              minLines: 1,
              style: Theme.of(context).primaryTextTheme.bodyLarge,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
              ),
              onChanged: (value) => handleInput(value.toLowerCase()),
            ).wTwoThird(context)),
            CupertinoButton(
                child: Text(
                  result,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: result)).then((value) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Result Copied',
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                        ),
                        backgroundColor: Theme.of(context).backgroundColor,
                      )));
                }).w40(context)
          ],
        ),
        TweenAnimationBuilder(
            tween: Tween(begin: 0, end: MediaQuery.of(context).size.width - 60),
            duration: const Duration(milliseconds: 1500),
            curve: const ElasticOutCurve(),
            builder: (context, num value, _) => Divider(
                  thickness: 1,
                  color: Theme.of(context).primaryIconTheme.color,
                ).w(value.toDouble()))
      ],
    );
  }
}
