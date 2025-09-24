import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
    await audioPlayer.play(AssetSource('sounds/$soundName.mp3'));
  }

  Widget buildSoundButton(String text, String soundName, {
    bool isLarge = false, 
    Color? color, 
    IconData? icon
  }) {
    return Expanded(
      flex: isLarge ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Increased roundness
              side: BorderSide(color: Colors.white.withValues()), // Subtle border
            ),
            elevation: 4, // Added shadow
          ),
          onPressed: () => playSound(soundName),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) 
                Icon(
                  icon,
                  size: isLarge ? 32 : 24,
                  color: Colors.white,
                ),
              if (icon != null) 
                const SizedBox(height: 8),
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: isLarge ? 24 : 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0, // Removes shadow
        title: Text(
          'SPEECH HELPER',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 22,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top row with main action buttons
            Expanded(
              flex: 3, // Increased flex for more height
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    buildSoundButton(
                      'Ya', 
                      'ya', 
                      isLarge: true, 
                      color: Colors.green[600],
                      icon: Icons.check_circle_outline,
                    ),
                    const SizedBox(width: 16.0), // Add spacing between buttons
                    buildSoundButton(
                      'Ngakk', 
                      'gak', 
                      isLarge: true, 
                      color: Colors.red[600],
                      icon: Icons.cancel_outlined,
                    ),
                  ],
                ),
              ),
            ),
            // Bottom row with other buttons
            Expanded(
              flex: 2, // Adjusted flex ratio
              child: Row(
                children: [
                  buildSoundButton(
                    'Tunggu', 
                    'tunggu', 
                    color: Colors.orange[700],
                    icon: Icons.timer,
                  ),
                  const SizedBox(width: 8.0),
                  buildSoundButton(
                    'Berhenti', 
                    'berhenti', 
                    color: Colors.purple[600],
                    icon: Icons.stop_circle_outlined,
                  ),
                  const SizedBox(width: 8.0),
                  buildSoundButton(
                    'Tidak Tahu', 
                    'gak_tahu', 
                    color: Colors.blue[600],
                    icon: Icons.question_mark_rounded,
                  ),
                  const SizedBox(width: 8.0),
                  buildSoundButton(
                    'Tidak Paham', 
                    'gak_paham', 
                    color: Colors.brown[600],
                    icon: Icons.psychology_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
