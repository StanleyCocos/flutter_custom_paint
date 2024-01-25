import 'package:flutter/material.dart';

class GoCanvasPage extends StatefulWidget {
  const GoCanvasPage({Key? key}) : super(key: key);

  @override
  State<GoCanvasPage> createState() => _State();
}

class _State extends State<GoCanvasPage> {

  final List<Flag> flags  = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("绘制围棋"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (detail) {
              print(detail.globalPosition);
              print(detail.localPosition);
              flags.add(Flag(onTapOffset: detail.localPosition, isBlack: flags.length % 2 == 0),);
              setState(() {});
            },
            child: CustomPaint(
              size: const Size(320, 320),
              painter: MyPainter(
                count: 13,
                flags: flags,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  int count = 13;
  final List<Flag>? flags;

  MyPainter({this.count = 13, this.flags});

  @override
  void paint(Canvas canvas, Size size) {
    _drawHorizontalLine(canvas, size);
    _drawVerticalLine(canvas, size);
    _drawTianyuanPoint(canvas, size);
    _drawStarPoint(canvas, size);
    if(flags != null && flags!.isNotEmpty){
      _drawFlagPoint(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  /// 画13路横向白色棋盘线
  void _drawHorizontalLine(Canvas canvas, Size size) {
    for (int index = 0; index < count; index++) {
      Offset p1 = Offset(0, size.height / (count - 1) * index);
      Offset p2 = Offset(size.width, size.height / (count - 1) * index);
      Paint p = Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.white
        ..strokeWidth = 2;
      canvas.drawLine(p1, p2, p);
    }
  }

  /// 画13路纵向白色棋盘线
  void _drawVerticalLine(Canvas canvas, Size size) {
    for (int index = 0; index < count; index++) {
      Offset p1 = Offset(size.width / (count - 1) * index, 0);
      Offset p2 = Offset(size.width / (count - 1) * index, size.height);
      Paint p = Paint();
      p
        ..style = PaintingStyle.stroke
        ..color = Colors.white
        ..strokeWidth = 2;
      canvas.drawLine(p1, p2, p);
    }
  }

  /// 画天元点
  void _drawTianyuanPoint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    int index = ((count - 1) / 2).toInt();
    canvas.drawCircle(
        Offset(_getPointX(index, size), _getPointY(index, size)), 4, p);
  }

  /// 画星位点
  void _drawStarPoint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    canvas.drawCircle(Offset(_getPointX(3, size), _getPointY(3, size)), 4, p);
    canvas.drawCircle(Offset(_getPointX(3, size), _getPointY(9, size)), 4, p);
    canvas.drawCircle(Offset(_getPointX(9, size), _getPointY(3, size)), 4, p);
    canvas.drawCircle(Offset(_getPointX(9, size), _getPointY(9, size)), 4, p);
  }


  /// 画黑白棋子
  void _drawFlagPoint(Canvas canvas, Size size){
    Paint p = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    for(int index = 0; index < flags!.length; index ++){
      var flag = flags![index];
      p.color = flag.isBlack ? Colors.black : Colors.white;
      Path path = Path();
      path.addRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: _convertGoOffset(flag, size), width: 10, height: 10), const Radius.circular(10)));
      canvas.drawShadow(path, Colors.black, 10.0, false);
      canvas.drawCircle(_convertGoOffset(flag, size), 10, p);
    }
  }

  double _getPointX(int index, Size size) {
    double width = size.width / (count - 1);
    return index * width;
  }

  double _getPointY(int index, Size size) {
    double height = size.height / (count - 1);
    return index * height;
  }


  Offset _convertGoOffset(Flag flag, Size size){
    double dx = flag.onTapOffset.dx;
    double dy = flag.onTapOffset.dy;
    for(int index = 0; index < 13; index ++){
      double w = _getPointX(index, size);
      if(dx < w) {
        if (index == 0) {
          dx = w;
        } else {
          double cw = _getPointX(index - 1, size);
          dx = dx - cw < w - dx ? cw : w;
        }
        break;
      }
    }
    for(int index = 0; index < 13; index ++){
      double h = _getPointY(index, size);
      if(dy < h) {
        if (index == 0) {
          dy = h;
        } else {
          double ch = _getPointY(index - 1, size);
          dy = dy - ch < h - dx ? ch : h;
        }
        break;
      }
    }
    return Offset(dx, dy);
  }
}

class Flag {

  Offset onTapOffset;
  Offset goOffset;
  bool isBlack;
  Flag({this.onTapOffset = Offset.zero, this.goOffset = Offset.zero, this.isBlack = true,});
}