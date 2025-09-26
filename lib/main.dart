import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech Helper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: const Color(0xFFF5F5F7), // Light gray background
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const SpeechHelperPage(),
    );
  }
}

class SpeechHelperPage extends StatefulWidget {
  const SpeechHelperPage({super.key});

  @override
  State<SpeechHelperPage> createState() => _SpeechHelperPageState();
}

class _SpeechHelperPageState extends State<SpeechHelperPage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  void playSound(String soundName) async {
    try {
      final player = AudioPlayer();
      await player.play(AssetSource('sounds/$soundName.mp3'));
      
      // Add listener for completion to dispose the player
      player.onPlayerComplete.listen((event) {
        player.dispose();
      });
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Widget buildSoundButton(String text, String soundName, {
    bool isLarge = false, 
    Color? color, 
    IconData? icon
  }) {
    return Expanded(
      flex: isLarge ? 2 : 1, // Larger buttons take more space
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          elevation: 0,
          minimumSize: Size.infinite,
        ),
        onPressed: () => playSound(soundName),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) 
              Stack(
                children: [
                  // Outline effect for icon
                  Icon(
                    icon,
                    size: isLarge ? 65 : 50, // Larger icons for large buttons
                    color: Colors.black,
                  ),
                ],
              ),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: isLarge ? 65 : 50, // Larger text for large buttons
                color: Colors.black,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
                shadows: [
                  // Text outline effect
                  Shadow(
                    offset: const Offset(-1.5, -1.5),
                    color: Colors.white,
                    blurRadius: 0,
                  ),
                  Shadow(
                    offset: const Offset(1.5, -1.5),
                    color: Colors.white,
                    blurRadius: 0,
                  ),
                  Shadow(
                    offset: const Offset(1.5, 1.5),
                    color: Colors.white,
                    blurRadius: 0,
                  ),
                  Shadow(
                    offset: const Offset(-1.5, 1.5),
                    color: Colors.white,
                    blurRadius: 0,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3, // Larger space for first row
            child: Row(
              children: [
                buildSoundButton(
                  'YA', 
                  'ya',
                  color: const Color(0xFF00FF77),
                  icon: Icons.check_circle_outline,
                  isLarge: true, // Mark as large button
                ),
                buildSoundButton(
                  'NGAKK', 
                  'gak',
                  color: const Color(0xFFFF4444),
                  icon: Icons.cancel_outlined,
                  isLarge: true, // Mark as large button
                ),
                buildSoundButton(
                  'GAK PAHAM',
                  'gak_paham', 
                  color: const Color(0xFF00FFFF), // Pure bright orange
                  icon: Icons.psychology_outlined,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2, // Smaller space for second row
            child: Row(
              children: [
                buildSoundButton(
                  'GAK TAHU',
                  'gak_tahu', 
                  color: const Color(0xFFFF00FF),
                  icon: Icons.question_mark_rounded,
                ),
                buildSoundButton(
                  'TUNGGU', 
                  'tunggu', 
                  color: const Color(0xFFFFFF00),
                  icon: Icons.timer,
                ),
                buildSoundButton(
                  'STOP', 
                  'berhenti', 
                  color: const Color.fromARGB(255, 153, 138, 138),
                  icon: Icons.stop_circle_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}