import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:ticket/core/utils/extensions/datetime_format_extension.dart';
import 'package:ticket/features/main/presentation/cubits/delete_ticket_cubit.dart';
import 'package:ticket/features/scanner/data/model/ticket_item_model.dart';
import 'package:ticket/features/scanner/data/model/ticket_model.dart';
import 'package:ticket/features/scanner/presentation/bloc/scan_bloc.dart';
import 'package:ticket/widgets/dialogs/app_dialog.dart';

class TicketDetailItem extends StatelessWidget {
  final TicketItemModel ticket;

  const TicketDetailItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 55),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              padding: const EdgeInsetsDirectional.only(
                top: 8,
                bottom: 8,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF0069F7)
              ),
              child: Column(
                children: [
                  Text(
                    ticket.titlePackage,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'IranSans',
                    ),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    DateTime.parse(ticket.createDate).toJalali().toPersianDateTimeFormat().toPersianDigit(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(237, 242, 244, 0.6),
                      fontFamily: 'IranSans',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: size.width*0.92,
                padding: const EdgeInsetsDirectional.only(
                  start: 15,
                  end: 15,
                  top: 20,
                  bottom: 20
                ),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: WeirdBorder(radius: 32, pathWidth: size.height),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'شماره بلیط',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF272C42),
                                  fontFamily: 'IranSans',
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Container(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 15,
                                    end: 15,
                                    top: 3,
                                    bottom: 3
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color.fromRGBO(237, 242, 244, 0.9)
                                ),
                                child: Text(
                                  '${ticket.id}'.toPersianDigit(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF272C42),
                                    fontFamily: 'IranSans',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'هزینه بلیط',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF272C42),
                                  fontFamily: 'IranSans',
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Container(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 15,
                                    end: 15,
                                    top: 3,
                                    bottom: 3
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color.fromRGBO(237, 242, 244, 0.9)
                                ),
                                child: Text(
                                  double.parse(ticket.price).toInt().toString().toPersianDigit().seRagham(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF272C42),
                                    fontFamily: 'IranSans',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 50,
              child: Center(
                child:CustomPaint(painter: DrawDottedhorizontalline(), size: Size(0, 2)),
                //drawing horizontal dotted/dash line
              ),
            ),
            RotationTransition(
              turns: const AlwaysStoppedAnimation(0.5),
              child: Container(
                width: size.width*0.92,
                height: size.height*0.3,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: WeirdBorder(radius: 32, pathWidth: size.height),
                ),
                child: Center(
                  child: QrImageView(
                    data: ticket.qrText,
                    version: QrVersions.auto,
                    size: 150,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeirdBorder extends ShapeBorder {
  final double radius;
  final double pathWidth;

  WeirdBorder({required this.radius, this.pathWidth = 1});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect, textDirection: textDirection!), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => _createPath(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => WeirdBorder(radius: radius);

  Path _createPath(Rect rect) {
    final innerRadius = radius + pathWidth;
    final innerRect = Rect.fromLTRB(rect.left + pathWidth, rect.top + pathWidth, rect.right - pathWidth, rect.bottom - pathWidth);

    final outer = Path.combine(PathOperation.difference, Path()..addRect(rect), _createBevels(rect, radius));
    final inner = Path.combine(PathOperation.difference, Path()..addRect(innerRect), _createBevels(rect, innerRadius));
    return Path.combine(PathOperation.difference, outer, inner);
  }

  Path _createBevels(Rect rect, double radius) {
    return Path()
      // ..addOval(Rect.fromCircle(center: Offset(rect.left, rect.top), radius: radius))
      // ..addOval(Rect.fromCircle(center: Offset(rect.left + rect.width, rect.top), radius: radius))
      ..addOval(Rect.fromCircle(center: Offset(rect.left, rect.top + rect.height), radius: radius))
      ..addOval(Rect.fromCircle(center: Offset(rect.left + rect.width, rect.top + rect.height), radius: radius));
  }
}

class DrawDottedhorizontalline extends CustomPainter {
  Paint _paint = Paint();

  DrawDottedhorizontalline() {
    _paint.color = Colors.black; //dots color
    _paint.strokeWidth = 2; //dots thickness
    _paint.strokeCap = StrokeCap.square; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -120; i < 120; i = i + 15) {
      // 15 is space between dots
      if (i % 3 == 0)
        canvas.drawLine(Offset(i, 0.0), Offset(i + 10, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}