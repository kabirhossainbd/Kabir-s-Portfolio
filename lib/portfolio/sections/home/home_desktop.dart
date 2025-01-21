import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/configs/app_dimensions.dart';
import 'package:portpolio/portfolio/configs/app_typography.dart';
import 'package:portpolio/portfolio/configs/space.dart';
import 'package:portpolio/portfolio/provider/app_provider.dart';
import 'package:portpolio/portfolio/utils/utils.dart';
import 'package:portpolio/portfolio/widget/social_links.dart';
import 'package:provider/provider.dart';

import '../../configs/app_theme.dart';

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appProvider = Provider.of<AppProvider>(context);
    return Container(
      height: size.height * 1.025,
      padding: Space.h,
      child: Row(
        children: [

          EntranceFader(
            offset: const Offset(0, 0),
            delay: const Duration(seconds: 1),
            duration: const Duration(milliseconds: 200),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    size: const Size(400, 300), // Set the size of the shape
                    painter: BlobPainter(),
                  ),
                ),

                CustomPaint(
                  size: const Size(400, 300), // Set the size of the shape
                  painter: ReversedBlobPainter(),
                ),
                Positioned(
                  left: 0, right: 0,
                  top: -20,
                  child: Image.asset(
                    StaticUtils.profileCasual,
                    height: size.width < 1200
                        ? size.height * 0.5
                        : size.height * 0.56,
                  ),
                ),
              ],
            ),
          ),




          Flexible(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                AppDimensions.normalize(30),
                AppDimensions.normalize(80),
                AppDimensions.normalize(30),
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'The only way to do great work is to love what you do.',
                          style: AppText.b1!.copyWith(
                            fontFamily: 'Montserrat',
                            color: appProvider.isDark ? Colors.white : Colors.black
                          ),
                        ),
                      ),
                      EntranceFader(
                        offset: const Offset(0, 0),
                        delay: const Duration(seconds: 2),
                        duration: const Duration(milliseconds: 800),
                        child: Image.asset(
                          StaticUtils.hi,
                          height: AppDimensions.normalize(12),
                        ),
                      ),
                    ],
                  ),
                  Space.y1!,
                  Text(
                    "Md.Kabir Hossain",
                    style: AppText.h1!.copyWith(
                      fontFamily: 'Montserrat',
                      fontSize: AppDimensions.normalize(20),
                      fontWeight: FontWeight.w100,
                        color: appProvider.isDark ? Colors.white : Colors.black
                    ),
                  ),
                  EntranceFader(
                    offset: const Offset(-10, 0),
                    delay: const Duration(seconds: 1),
                    duration: const Duration(milliseconds: 800),
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: AppTheme.c!.primary!,
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              ' Flutter Developer',
                              speed: const Duration(milliseconds: 50),
                              textStyle: AppText.b1!.copyWith( color: appProvider.isDark ? Colors.white : Colors.black),
                            ),
                            TyperAnimatedText(
                              ' Android Developer',
                              speed: const Duration(milliseconds: 50),
                              textStyle: AppText.b1!.copyWith( color: appProvider.isDark ? Colors.white : Colors.black),
                            ),
                            TyperAnimatedText(
                              ' Additional Leader',
                              speed: const Duration(milliseconds: 50),
                              textStyle: AppText.b1!.copyWith( color: appProvider.isDark ? Colors.white : Colors.black),
                            ),
                            TyperAnimatedText(
                              ' A friend :)',
                              speed: const Duration(milliseconds: 50),
                              textStyle: AppText.b1!.copyWith( color: appProvider.isDark ? Colors.white : Colors.black),
                            ),
                          ],
                          isRepeatingAnimation: true,
                        ),
                      ],
                    ),
                  ),
                  Space.y2!,
                  const SocialLinks(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class BlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader =  LinearGradient(
        colors: [Colors.blue.withOpacity(0.6), Colors.blueAccent.withOpacity(0.5), Colors.blueGrey.withOpacity(0.4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.1);
    path.cubicTo(size.width * 0.7, size.height * 0.0, size.width, size.height * 0.4, size.width * 0.8, size.height * 0.8);
    path.cubicTo(size.width * 0.5, size.height, size.width * 0.2, size.height * 0.8, size.width * 0.0, size.height * 0.4);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



class ReversedBlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.blueAccent, Colors.blueAccent],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();
    // Start at the top left
    path.moveTo(size.width * 0.4, 0);
    path.cubicTo(
      size.width * 0.1, size.height * 0.3,
      size.width * 0.2, size.height * 0.7,
      size.width * 0.5, size.height * 0.8,
    );
    path.cubicTo(
      size.width * 0.8, size.height * 0.9,
      size.width, size.height * 0.6,
      size.width * 0.9, size.height * 0.3,
    );
    path.cubicTo(
      size.width * 0.8, size.height * 0.0,
      size.width * 0.5, size.height * 0.1,
      size.width * 0.4, 0,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}