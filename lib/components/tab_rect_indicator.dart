import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RectTabIndicator extends Decoration{
  final BoxPainter _painter;
  RectTabIndicator({@required Color color,@required double radius}):_painter= _RectPainter(color,radius);
  @override
  BoxPainter createBoxPainter([onchanged]) => _painter;

}
class _RectPainter extends BoxPainter{
  final Paint _paint;
  final double radius;

  _RectPainter(Color color,this.radius):_paint = Paint()
  ..color = color
  ..isAntiAlias = true;

  @override
  void paint(Canvas canvas,Offset offset,ImageConfiguration cfg){
    final Offset circleOffset = offset + Offset(cfg.size.width / 2, cfg.size.height/ 2);
    var rect = Rect.fromCenter(center:circleOffset,width: cfg.size.width,height: cfg.size.height);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(8)),_paint);
  }

}