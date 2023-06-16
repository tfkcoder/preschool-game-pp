// import 'package:animate_do/animate_do.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'dart:async';

import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

///
// import '../model/items_model.dart';
// import '../utils/colors.dart';
// import '../components.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   PageController pageController = PageController(initialPage: 0);
//   int currentIndex = 0;

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }

//   Widget animation(
//     int index,
//     int delay,
//     Widget child,
//   ) {
//     if (index == 1) {
//       return FadeInDown(
//         delay: Duration(milliseconds: delay),
//         child: child,
//       );
//     }
//     return FadeInUp(
//       delay: Duration(milliseconds: delay),
//       child: child,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var textTheme = Theme.of(context).textTheme;
//     return SafeArea(
//       child: Scaffold(
//           body: SizedBox(
//         width: size.width,
//         height: size.height,
//         child: Column(
//           children: [
//             /// ---------------------------
//             Expanded(
//               flex: 3,
//               child: PageView.builder(
//                 controller: pageController,
//                 itemCount: listOfItems.length,
//                 onPageChanged: (newIndex) {
//                   setState(() {
//                     currentIndex = newIndex;
//                   });
//                 },
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: ((context, index) {
//                   return SizedBox(
//                     width: size.width,
//                     height: size.height,
//                     child: Column(
//                       children: [
//                         /// IMG
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(15, 40, 15, 10),
//                           width: size.width,
//                           height: size.height / 2.5,
//                           child: animation(
//                             index,
//                             100,
//                             Image.asset(listOfItems[index].img),
//                           ),
//                         ),

//                         /// TITLE TEXT
//                         Padding(
//                             padding: const EdgeInsets.only(top: 25, bottom: 15),
//                             child: animation(
//                               index,
//                               300,
//                               Text(
//                                 listOfItems[index].title,
//                                 textAlign: TextAlign.center,
//                                 style: textTheme.displayLarge,
//                               ),
//                             )),

//                         /// SUBTITLE TEXT
//                         animation(
//                           index,
//                           500,
//                           Text(
//                             listOfItems[index].subTitle,
//                             textAlign: TextAlign.center,
//                             style: textTheme.displayMedium,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             ),

//             /// ---------------------------
//             Expanded(
//               flex: 1,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   /// PAGE INDICATOR
//                   SmoothPageIndicator(
//                     controller: pageController,
//                     count: listOfItems.length,
//                     effect: const ExpandingDotsEffect(
//                       spacing: 6.0,
//                       radius: 10.0,
//                       dotWidth: 10.0,
//                       dotHeight: 10.0,
//                       expansionFactor: 3.8,
//                       dotColor: Colors.grey,
//                       activeDotColor: MyColors.btnColor,
//                     ),
//                     onDotClicked: (newIndex) {
//                       setState(() {
//                         currentIndex = newIndex;
//                         pageController.animateToPage(newIndex,
//                             duration: const Duration(milliseconds: 500),
//                             curve: Curves.ease);
//                       });
//                     },
//                   ),
//                   currentIndex == 2

//                       /// GET STARTED BTN
//                       ? GetStartBtn(size: size, textTheme: textTheme)

//                       /// SKIP BTN
//                       : SkipBtn(
//                           size: size,
//                           textTheme: textTheme,
//                           onTap: () {
//                             setState(() {
//                               pageController.animateToPage(2,
//                                   duration: const Duration(milliseconds: 1000),
//                                   curve: Curves.fastOutSlowIn);
//                             });
//                           },
//                         )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Color?> _backgroundAnimation;

  final List<Color> backgroundColors = [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
  ];
  int backgroundColorIndex = 0;

  bool isLoadingComplete = false;
  bool isBackgroundTransitionComplete = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _backgroundAnimation = ColorTween(
      begin: backgroundColors[0],
      end: backgroundColors[1],
    ).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          backgroundColorIndex++;
          if (backgroundColorIndex >= backgroundColors.length) {
            backgroundColorIndex = 0;
          }

          _backgroundAnimation = ColorTween(
            begin: backgroundColors[backgroundColorIndex],
            end: backgroundColors[(backgroundColorIndex + 1) % backgroundColors.length],
          ).animate(_animationController);
        });
        if (backgroundColorIndex == backgroundColors.length - 1) {
          isBackgroundTransitionComplete = true;
        }
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    _animationController.forward().whenComplete(() {
      setState(() {
        isLoadingComplete = true;
      });
      Timer(const Duration(seconds: 10), () {
        if (isLoadingComplete ) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            color: _backgroundAnimation.value,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _animation,
                    child: const Text(
                      'Karibu Pre school app',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 50),
                    child: LinearProgressIndicator(
                      minHeight: 20,
                      value: isBackgroundTransitionComplete ? _animation.value * 100 : 0,
                      backgroundColor: Colors.blue,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                 const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${(isBackgroundTransitionComplete ? _animation.value * 100 : 0).toStringAsFixed(0)}%',
                        style:const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}