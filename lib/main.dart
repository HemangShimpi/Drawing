import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedEmoji = 'Smiley';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emojis"),
      ),
      body: Column(
          children: [
            DropdownButton<String>(
              value: selectedEmoji,
              items: ['Smiley', 'Party Face'].map((String emoji) {
                return DropdownMenuItem<String>(
                  value: emoji,
                  child: Text(emoji),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedEmoji = newValue!;
                });
              },
            ),
            Expanded(
              child: CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: SmileyPainter(selectedEmoji),
              ),
            ),
          ],
        ),
      );
  }
}

class SmileyPainter extends CustomPainter {
  final String emojiType;
  SmileyPainter(this.emojiType);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = 100;

    // Draw face
    canvas.drawCircle(center, radius, paint);

    // Draw eyes
    final Paint eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(center.dx - 30, center.dy - 30), 10, eyePaint);
    canvas.drawCircle(Offset(center.dx + 30, center.dy - 30), 10, eyePaint);

    // Draw smile (arc)
    final Paint smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final Rect smileRect = Rect.fromCircle(center: center, radius: 60);
    canvas.drawArc(smileRect, 0.2 * 3.14, 0.6 * 3.14, false, smilePaint);

    if (emojiType == 'Party Face') {
      // Draw party hat
      final Paint hatPaint = Paint()..color = Colors.blue;
      final Path hatPath = Path()
        ..moveTo(center.dx, center.dy - 110)
        ..lineTo(center.dx - 50, center.dy - 40)
        ..lineTo(center.dx + 50, center.dy - 40)
        ..close();
      canvas.drawPath(hatPath, hatPaint);

      // Draw confetti
      final Paint confettiPaint = Paint()..color = Colors.red;
      canvas.drawCircle(Offset(center.dx - 40, center.dy - 80), 5, confettiPaint);
      canvas.drawCircle(Offset(center.dx + 40, center.dy - 90), 5, confettiPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

