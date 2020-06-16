import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CircleTabIndicator extends Decoration{
  final BoxPainter _painter;
  CircleTabIndicator({@required Color color, @required double radius}):_painter= _CirclePainter(color,radius);
  @override
  BoxPainter createBoxPainter([onchanged]) => _painter;

}
class _CirclePainter extends BoxPainter{
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color,this.radius):_paint = Paint()
  ..color = color
  ..isAntiAlias = true;

  @override
  void paint(Canvas canvas,Offset offset,ImageConfiguration cfg){
    final Offset circleOffset = offset + Offset(cfg.size.width / 2, cfg.size.height - radius -5);
    var rect = Rect.fromCenter(center:circleOffset,width: cfg.size.width*0.2,height: cfg.size.height*0.07);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)),_paint);
  }

}