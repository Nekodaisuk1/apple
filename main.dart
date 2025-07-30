import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MyFruitApp(),
    ),
  );
}

class MyFruitApp extends StatelessWidget {
  const MyFruitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Rainbow Mango🥭')),
      body: const SafeArea(
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: RainbowText(),   // ★ 差し替え
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => debugPrint('Like button pressed'),
        icon: const Icon(Icons.thumb_up),
        label: const Text('Like'),
      ),
    );
  }
}

/// テキストが虹色に変化しつづけるウィジェット
class RainbowText extends StatefulWidget {
  const RainbowText({super.key});

  @override
  State<RainbowText> createState() => _RainbowTextState();
}

class _RainbowTextState extends State<RainbowText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6), // 6秒で一周
    )..repeat();                             // ループ
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        // HSVの色相を回転させてレインボーを作る
        final color = HSVColor.fromAHSV(1, _ctrl.value * 360, 0.8, 1).toColor();

        return Text(
          'マンゴー🥭',
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            color: color,
            shadows: [
              // 光彩を付ける
              Shadow(
                blurRadius: 16,
                color: color.withOpacity(0.8),
                offset: const Offset(0, 0),
              ),
            ],
          ),
        );
      },
    );
  }
}
