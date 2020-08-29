import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

Future<Color> prominentColor(String url) async {
  var value = await http.get(url);
  var image = img.decodeImage(value.bodyBytes);

  Map<int,int> colorVariation = Map();
  var wStep = image.width ~/ 100;
  var hStep = image.height ~/ 100;
  for (int x = 0; x < image.width; x+=wStep) {
    for (int y = 0; y < image.height; y+=hStep) {
      int colorInt = image.getPixelSafe(x, y);
      if (colorInt == 0) continue;
      if (img.getAlpha(colorInt) < 0xFF) continue;
      colorVariation[colorInt] = (colorVariation[colorInt]??1) + 1;
    }
  }

  List<int> vars = colorVariation.values.toList();
  vars.sort((x,y) => y.compareTo(x));
  for (var x in colorVariation.entries) {
    if (x.value == vars[0]) {
      return new Color.fromARGB(255, img.getRed(x.key), img.getGreen(x.key), img.getBlue(x.key));
    }
  }

  return Colors.black;
}

Color prominentColorData(Uint8List byteData)  {
  var image = img.decodeImage(byteData);

  Map<int,int> colorVariation = Map();
  var wStep = image.width ~/ 100;
  var hStep = image.height ~/ 100;
  for (int x = 0; x < image.width; x+=wStep) {
    for (int y = 0; y < image.height; y+=hStep) {
      int colorInt = image.getPixelSafe(x, y);
      if (colorInt == 0) continue;
      if (img.getAlpha(colorInt) < 0xFF) continue;
      colorVariation[colorInt] = (colorVariation[colorInt]??1) + 1;
    }
  }

  List<int> vars = colorVariation.values.toList();
  vars.sort((x,y) => y.compareTo(x));
  for (var x in colorVariation.entries) {
    if (x.value == vars[0]) {
      return new Color.fromARGB(255, img.getRed(x.key), img.getGreen(x.key), img.getBlue(x.key));
    }
  }

  return Colors.black;
}