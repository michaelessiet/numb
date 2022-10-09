import 'dart:math';

import 'package:dart_numerics/dart_numerics.dart';
import 'package:powers/powers.dart';

Map functions = {
  'fact': (num n) {
    return gamma(n.toDouble()) * n;
  },
  'root': (num factor, num n) {
    return n.root(factor);
  },
  'logn': (num base, num n) {
    return log(n) / log(base);
  }
};

// void main(List<String> args) {
//   print(functions['logn'](2, 4));
// }
