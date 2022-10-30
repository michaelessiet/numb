Map searchForStringInMap(List objects, String target) {
  int leftcursor = 0;
  int rightcursor = objects.length - 1;
  int center = (objects.length / 2).ceil();
  bool done = false;

  if (objects.isEmpty) {
    throw Exception('empty array');
  }

  while (done == false) {
    if (objects[leftcursor + 1] == objects[rightcursor]) {
      Map finalMatch = [objects[leftcursor], objects[rightcursor]] 
          .where((element) => element['city'].toString().toLowerCase().contains(target))
          .toList()[0];
      return finalMatch;
    }

    if (objects[center] == target) {
      return objects[center];
    }

    if (target
        .compareTo(objects[center]['city'].toString().toLowerCase())
        .isNegative) {
      rightcursor = center;
      center = ((leftcursor + rightcursor) / 2).floor();
    }

    if (!target
        .compareTo(objects[center]['city'].toString().toLowerCase())
        .isNegative) {
      leftcursor = center;
      center = ((leftcursor + rightcursor) / 2).floor();
    }
  }

  return {};
}
