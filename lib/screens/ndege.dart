import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NdegeScreen extends StatefulWidget {
  const NdegeScreen({Key? key}) : super(key: key);

  @override
  State<NdegeScreen> createState() => _NdegeScreenState();
}

class _NdegeScreenState extends State<NdegeScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _fruits = ['Ndizi', 'Nyanya', 'Parachichi', 'Embe', 'Nanasi'];

  late AnimationController _animationController;
  late List<Animation<double>> _shakeAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimations = List<Animation<double>>.generate(
      _fruits.length,
      (index) => Tween<double>(begin: -5.0, end: 5.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _playShakeAnimation(int index) {
    _animationController.reset();
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg.jpg',
            fit: BoxFit.cover,
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: _fruits.length,
            itemBuilder: (context, index) {
              final fruit = _fruits[index];
              return GestureDetector(
                onTap: () {
                  _playShakeAnimation(index);
                  // Handle fruit item tap
                },
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        _shakeAnimations[index].value,
                        0.0,
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.pets_outlined,
                                color: Colors.blue,
                                size: 60,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              fruit,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
