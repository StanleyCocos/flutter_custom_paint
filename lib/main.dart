import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_custom_paint/go_canvas_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: CustomPaint(
              // 中间画布
              painter: MyCustomPainter(),
              // 前景画布
              // foregroundPainter: ,
              // 背景画布
              // backgroundPainter: ,
              size: const Size(400, 400),
              isComplex: true,
              willChange: false,
              // child: ,
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => const GoCanvasPage()));
            },
            child: Container(
              width: 200,
              height: 40,
              color: Colors.lightBlue,
              alignment: Alignment.center,
              child: Text("案例一(围棋)"),
            ),
          ),

          SizedBox(height: 30),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              width: 200,
              height: 40,
              color: Colors.lightBlue,
              alignment: Alignment.center,
              child: Text("案例二(仪表盘"),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              width: 200,
              height: 40,
              color: Colors.lightBlue,
              alignment: Alignment.center,
              child: Text("案例二(柱状图)"),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyCustomPainter extends CustomPainter {
  Paint p = Paint()
    // PaintingStyle.fill 填充
    // PaintingStyle.stroke 描边
    ..style = PaintingStyle.fill
    // 颜色 默认为不透明黑色Colors.black
    ..color = Colors.red
    // 绘制形状或合成图层时应用的颜色过滤器，绘制形状时， colorFilter会覆盖color和shader
    // ..colorFilter = const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
    // 绘制时图像的颜色是否反转。 反转图像的颜色会应用一个新的滤色器，该滤色器将与任何用户提供的滤色器组成
    ..invertColors = false
    // 是否对画布上绘制的线条和图像应用抗锯齿，使用了抗锯齿边缘更平滑
    ..isAntiAlias = true
    // 以平坦边缘开始和结束轮廓，没有延伸
    // paint.strokeCap = StrokeCap.butt;
    // 以半圆形延伸开始和结束轮廓
    // paint.strokeCap = StrokeCap.round;
    // 以半方形扩展开始和结束轮廓。这类似于将每个轮廓扩展一半笔画宽度（由Paint.strokeWidth绘制）
    // paint.strokeCap = StrokeCap.square;
    ..strokeCap = StrokeCap.butt
    // 线段之间的连接将线段对接端的角连接起来，以提供斜切外观
    // paint.strokeJoin = StrokeJoin.bevel;
    // 线段之间的连接形成尖角
    // paint.strokeJoin = StrokeJoin.miter;
    // 线段之间的连接是半圆形的
    // paint.strokeJoin = StrokeJoin.round;
    ..strokeJoin = StrokeJoin.miter
    //当连接设置为StrokeJoin.miter且style设置为PaintingStyle.stroke时，
    // 在线段上绘制斜接的限制。如果超出此限制，则会改为绘制StrokeJoin.bevel连接
    ..strokeMiterLimit = 2
    // 当style设置为PaintingStyle.stroke时绘制边缘的宽度
    ..strokeWidth = 5
    // 用来描边或填充形状时使用的着色器。当它为空时，将使用color
    ..shader = null
    // 在画布上绘画时使用的算法。在画布上绘制形状或图像时，可以使用不同的算法来混合像素
    ..blendMode = BlendMode.srcOver
    //  用于对图像进行采样的ImageFilter和Shader对象中的图像采样以及用于渲染图像的Canvas操作的质量级别。
    //  当按比例放大时，质量通常是最低的， low和medium的质量none ，而对于非常大的比例因子（超过 10 倍），质量最高的是high 。
    //  缩小时， medium提供最佳质量，尤其是在将图像缩小到小于其大小的一半或在此类缩小之间为比例因子设置动画时。否则， low和high在 50% 和 100% 之间的减少提供类似的效果，但图像可能会丢失细节并具有低于 50% 的丢失。
    //  为了在放大和缩小图像或比例未知时获得高质量， medium通常是一个很好的平衡选择
    ..filterQuality = FilterQuality.medium;

  // ..imageFilter =
  // ..maskFilter =

  @override
  void paint(Canvas canvas, Size size) {
    // _drawCircle(canvas, size);
    // _drawRect(canvas, size);
    // _drawRRect(canvas, size);
    // _drawArc(canvas, size);
    // _drawColor(canvas, size);
    // _drawShadow(canvas, size);
    // _drawDRRect(canvas, size);
    // _drawLine(canvas, size);
    // _drawOval(canvas, size);
    // _drawPaint(canvas, size);
    _drawPath(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  /// 绘制圆形
  void _drawCircle(Canvas canvas, Size size) {
    // Offset c 圆心的位置坐标
    // double radius 圆的半径
    // Paint paint 画笔
    // void drawCircle(Offset c, double radius, Paint paint);
    canvas.drawCircle(Offset(1, 1), 100, p);
  }

  /// 绘制矩形
  void _drawRect(Canvas canvas, Size size) {
    // Rect rect Rect对象
    // Paint paint 画笔
    // void drawRect(Rect rect, Paint paint);

    // 创建Rect 有7种方式
    Rect rect;
    // 1. 绘制一个左、上、右和下边缘都为零的矩形
    rect = Rect.zero;
    // 2. 绘制一个覆盖整个坐标空间的矩形
    rect = Rect.largest;
    // 3. 确定一个矩形的中心点坐标来绘制。
    rect = Rect.fromCenter(center: const Offset(0, 0), width: 100, height: 100);
    // 4. 从左、上、右、下 边缘构造一个矩形
    rect = Rect.fromLTRB(10, 0, 100, 100);
    // 5. 构造一个以给定圆为边界的矩形
    rect = Rect.fromCircle(center: Offset(100, 100), radius: 50);
    // 6. 通过左上角点的坐标和宽度、高度来构造一个矩形
    rect = Rect.fromLTWH(10, 20, 100, 100);
    // 7. 通过两个坐标点来绘制矩形
    rect = Rect.fromPoints(Offset(50, 50), Offset(100, 100));
    canvas.drawRect(rect, p);
  }

  /// 绘制圆角矩形
  void _drawRRect(Canvas canvas, Size size) {
    RRect rRect;
    // 1. 绘制一个左、上、右和下边缘都为零的圆角矩形，和Rect.zero效果一样
    rRect = RRect.zero;
    // 2. 通过绘制一个矩形再设置圆角半径来绘制圆角矩形
    rRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(10, 10, 100, 100), Radius.circular(10));
    // 3. 5个参数，前4个参数和Rect.fromLTRB一样, 最后一个是圆角大小
    rRect = RRect.fromLTRBR(0, 20, 100, 100, Radius.circular(20));
    // 4. 6个参数，4个参数和Rect.fromLTRB 一样，最后两个是x轴和y轴的圆角大小
    rRect = RRect.fromLTRBXY(20, 20, 100, 100, 30, 10);
    // 5. 从其左、上、右和下边缘以及 topLeft、topRight、bottomRight 和 bottomLeft 半径构造一个圆角矩形
    rRect = RRect.fromLTRBAndCorners(
      10,
      10,
      100,
      100,
      topLeft: Radius.circular(30),
      topRight: Radius.circular(10),
      bottomLeft: Radius.circular(50),
      bottomRight: Radius.circular(50),
    );
    // 6. 需要依据一个矩形来绘制radiusX: x方向的半径长度 radiusY: y方向的半径长度
    rRect = RRect.fromRectXY(Rect.fromLTWH(10, 10, 100, 100), 50, 10);
    // 7. 可以传递5个参数，1个必要的，4个可选的
    rRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(10, 10, 100, 100),
      topLeft: Radius.circular(30),
      topRight: Radius.circular(10),
      bottomLeft: Radius.circular(50),
      bottomRight: Radius.circular(50),
    );
    canvas.drawRRect(rRect, p);
  }

  /// 绘制圆弧
  void _drawArc(Canvas canvas, Size size) {
    // Rect rect 矩形的位置和大小
    // double startAngle 圆弧开始的角度
    // double sweepAngle 圆弧开始到结束的角度大小
    // bool useCenter 是否向中心闭合
    // Paint paint 绘画对象
    canvas.drawArc(Rect.fromLTRB(0, 0, 100, 100), 0, 3.14, true, p);
  }

  /// 绘制颜色
  void _drawColor(Canvas canvas, Size size) {
    // drawColor绘制的颜色会沾满子整个屏幕
    // Color color 要绘制的颜色
    // BlendMode blendMode 颜色的混合模式 https://api.flutter.dev/flutter/dart-ui/BlendMode.html
    canvas.drawColor(Colors.black12, BlendMode.colorBurn);
  }

  /// 绘制阴影
  void _drawShadow(Canvas canvas, Size size) {
    // 为绘制的图形添加阴影
    // Path path 需要绘制阴影的路径
    // Color color 阴影颜色
    // double elevation 阴影的高度
    // bool transparentOccluder 是否透明
    Path path = Path();
    path.moveTo(80, 200);
    path.lineTo(320, 400);
    path.lineTo(200, 340);
    path.lineTo(100, 460);
    path.close();
    canvas.drawShadow(path, Colors.black, 8.0, false);
  }

  /// 绘制嵌套圆角矩形
  void _drawDRRect(Canvas canvas, Size size) {
    // RRect outer 绘制外围圆角矩形
    // RRect inner 绘制内部圆角矩形
    // Paint paint 绘画对象
    // 外围圆角矩形
    Rect rectOuter = Rect.fromCenter(
        center: size.center(Offset.zero), width: 300, height: 300);
    RRect outer = RRect.fromRectAndRadius(rectOuter, const Radius.circular(80));
// 内部圆角矩形
    Rect rectInner = Rect.fromCenter(
        center: size.center(Offset.zero), width: 200, height: 100);
    RRect inner = RRect.fromRectAndRadius(rectInner, const Radius.circular(60));
    canvas.drawDRRect(outer, inner, p);
  }

  /// 绘制线条
  void _drawLine(Canvas canvas, Size size) {
    // Offset p1 第一个点的位置
    // Offset p2 第二个点的位置
    // Paint paint 绘制对象
    Offset p1 = const Offset(100, 50);
    Offset p2 = const Offset(300, 200);
    canvas.drawLine(p1, p2, p);
  }

  /// 绘制椭圆
  void _drawOval(Canvas canvas, Size size) {
    // Rect rect 获取椭圆的原点和宽高
    // Paint paint 绘制对象
    Rect rect;

    // 宽高不相等为椭圆
    // Rect rect = Rect.fromCenter(center: size.center(Offset.zero), width: 300, height: 200);
    rect = Rect.fromCenter(
        center: size.center(Offset.zero), width: 400, height: 300);
    // canvas.drawOval(rect, p);
    // 宽高相等为正圆

    rect = Rect.fromLTWH(0, 0, 100, 200);
    canvas.drawOval(rect, p);
  }

  /// 绘制点
  void _drawPaint(Canvas canvas, Size size) {
    // PointMode pointMode 点的绘制模式
    // List points 点的坐标
    // Paint paint 绘制对象
    List<Offset> points = const [
      Offset(100, 100),
      Offset(200, 200),
      Offset(100, 300),
      Offset(300, 400),
      Offset(200, 500),
      Offset(300, 400),
    ];
    // 绘制多条线段，两个点一组
    canvas.drawPoints(PointMode.lines, points, p);
    // 绘制点，由strokeCap控制点的样式
    canvas.drawPoints(PointMode.points, points, p);
    // 将每一个点连接起来
    canvas.drawPoints(PointMode.polygon, points, p);
  }

  /// 绘制路径
  void _drawPath(Canvas canvas, Size size){
    // Path path 路径对象
    // Paint paint 绘制对象

    // Path
    // moveTo(double x, double y) 移动到坐标
    // path.relativeMoveTo 和moveTo的区别是相对于上一个点的位置
    // lineTo(double x, double y) 添加坐标
    // relativeLineTofiType 和lineTo的区别是相对于上一个点的位置
    // fillType 路径的填充类型
    // addArc 通过路径绘制圆弧
    // addOval、
    // addRect、
    // addRRect
    // addPolygon 添加一条新路径

//     Path path = Path()..moveTo(100, 100);
//     path.lineTo(250, 250);
//     path.lineTo(350, 180);
//     path.lineTo(200, 500);
// // 控制路径是否闭合，可不写
// //     path.close();
//     canvas.drawPath(path, p);


    Path path = Path()..moveTo(size.width / 2, 0);
    path.lineTo(size.width / 4, 200);
    path.lineTo(size.width / 7 * 6, 320);
    // path.lineTo(size.width / 7, 320);
    // path.lineTo(size.width / 4 * 3, 500);
    // path.close();
// 默认值
    path.fillType = PathFillType.nonZero;
    // path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, p);
  }
}
