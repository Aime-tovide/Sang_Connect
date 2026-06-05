// import 'package:flutter/material.dart';
// import 'login_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.bloodtype, size: 100, color: Colors.white),
//             const SizedBox(height: 20),
//             const Text(
//               'Blood App',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 36,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Connecter les donneurs aux hôpitaux',
//               style: TextStyle(color: Colors.white70, fontSize: 14),
//             ),
//             const SizedBox(height: 40),
//             const CircularProgressIndicator(color: Colors.white),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 9), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ECG line en bas
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: const Size(double.infinity, 100),
              painter: ECGPainter(),
            ),
          ),
          // Contenu principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo coeur avec goutte
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.favorite, size: 120, color: Colors.red[400]),
                    const Positioned(
                      bottom: 22,
                      child: Icon(
                        Icons.water_drop,
                        size: 38,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'SangConnect',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Donnez votre sang, sauvez des vies',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 40),
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: Colors.red,
                    strokeWidth: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ECGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.35)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final path = Path();
    double y = size.height * 0.5;

    // Segment 1
    path.moveTo(0, y);
    path.lineTo(size.width * 0.05, y);

    // Pic ECG 1
    path.lineTo(size.width * 0.08, y - 30);
    path.lineTo(size.width * 0.10, y + 40);
    path.lineTo(size.width * 0.12, y - 20);
    path.lineTo(size.width * 0.14, y);

    // Coeur 1
    path.lineTo(size.width * 0.22, y);
    _drawHeart(canvas, paint, size.width * 0.27, y);
    path.moveTo(size.width * 0.32, y);

    // Pic ECG 2
    path.lineTo(size.width * 0.38, y);
    path.lineTo(size.width * 0.41, y - 30);
    path.lineTo(size.width * 0.43, y + 40);
    path.lineTo(size.width * 0.45, y - 20);
    path.lineTo(size.width * 0.47, y);

    // Pic ECG 3
    path.lineTo(size.width * 0.52, y);
    path.lineTo(size.width * 0.55, y - 30);
    path.lineTo(size.width * 0.57, y + 40);
    path.lineTo(size.width * 0.59, y - 20);
    path.lineTo(size.width * 0.61, y);

    // Coeur 2
    path.lineTo(size.width * 0.68, y);
    _drawHeart(canvas, paint, size.width * 0.73, y);
    path.moveTo(size.width * 0.78, y);

    // Fin
    path.lineTo(size.width * 0.82, y);
    path.lineTo(size.width * 0.85, y - 30);
    path.lineTo(size.width * 0.87, y + 40);
    path.lineTo(size.width * 0.89, y - 20);
    path.lineTo(size.width * 0.91, y);
    path.lineTo(size.width, y);

    canvas.drawPath(path, paint);
  }

  void _drawHeart(Canvas canvas, Paint paint, double cx, double cy) {
    final heartPath = Path();
    double s = 12;
    heartPath.moveTo(cx, cy + s * 0.3);
    heartPath.cubicTo(
      cx,
      cy - s * 0.3,
      cx - s,
      cy - s * 0.3,
      cx - s,
      cy - s * 0.7,
    );
    heartPath.cubicTo(cx - s, cy - s * 1.4, cx, cy - s * 1.1, cx, cy - s * 0.7);
    heartPath.cubicTo(
      cx,
      cy - s * 1.1,
      cx + s,
      cy - s * 1.4,
      cx + s,
      cy - s * 0.7,
    );
    heartPath.cubicTo(cx + s, cy - s * 0.3, cx, cy - s * 0.3, cx, cy + s * 0.3);
    canvas.drawPath(heartPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
