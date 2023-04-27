import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<Uint8List> getBytesFromAsset(String path, int width, String text, Color color) async {
  
  ByteData bytes = (await NetworkAssetBundle(Uri.parse(path)).load(path));

  ui.Codec codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List());

  ui.FrameInfo fi = await codec.getNextFrame();

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  final double radius = width / 2;

  final Paint paint = Paint();

  final Path clipPath = Path();
  clipPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width.toDouble(), width.toDouble()),
      Radius.circular(100)));

  clipPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, width * 8 / 10, width.toDouble(), width * 3 / 10),
      Radius.circular(100)));

  canvas.clipPath(clipPath);
  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, width.toDouble(), width.toDouble()),
      image: fi.image
  );
      
  paint.color = color;
  paint.style = PaintingStyle.stroke;
  paint.strokeWidth = 15;
  canvas.drawCircle(Offset(radius, radius), radius, paint);

  //draw Title background
  paint.color = color;
  paint.style = PaintingStyle.fill;

  canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(0, width * 8 / 10, width.toDouble(), width * 3 / 10),
          Radius.circular(100)
      ),
      paint
  );

  
  text = text.substring(0,7);

  textPainter.text = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: radius / 2.5,
        fontWeight: FontWeight.bold,
        color: Colors.white,
  ));

  textPainter.layout();
  textPainter.paint(
      canvas,
      Offset(radius - textPainter.width / 2, width * 9.5 / 10 - textPainter.height / 2)
  );

  final image = await pictureRecorder
      .endRecording()
      .toImage(width, (width * 1.1).toInt());
  final data = await image.toByteData(format: ui.ImageByteFormat.png);

  return data!.buffer.asUint8List();
}
