import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:numb/widgets/container.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NumbContainer(
      child: Container(
        width: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Instructions',
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),
          Text(
            'Here’s how you can format your commands and expressions to ensure you get accurate results\n',
            style: Theme.of(context).primaryTextTheme.bodyLarge,
          ),
          Text(
            'Calculations',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          Text(
            """  1. 1 plus 1
  2. -1 plus 1
  3. 12 + 23 divided-by 6
  4. log(39) plus log(4)
  5. pi times pi
  6. pi times log(30)
  7. log(40) + 3
  8. (1+89)/90
  9. 3141e-3 \n""",
            style: Theme.of(context).primaryTextTheme.bodyLarge,
          ),
          Text(
            'Conversions',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          Text(
            """  1. 1cm in inches
  2. 2inches in cm
  3. 1kb to kib
  4. 2gb to kb
  6. 5USD to CAD
  7. 90eur to gbp
  8. 20000jpy in usd
  9. 299792458m/s in feet/s
  10. 1kg in grams
  11. 30ml in litres""",
            style: Theme.of(context).primaryTextTheme.bodyLarge,
          )
        ]).p16(),
      ),
    );
  }
}
