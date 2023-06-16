import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preschool_app/screens/options_select_color.dart';
import 'package:preschool_app/screens/trials.dart';

import 'home_animal.dart';
import 'matunda.dart';
import 'ndege.dart';
import 'usafi.dart';
import 'wanyama.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   Future<bool> _showExitConfirmationDialog() async {
  bool? shouldQuit = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Unataka Kutoka ?'),
        content: const Text('Una uhakika unataka kuacha programu?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Hapana'),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false when cancel is pressed
            },
          ),
          TextButton(
            child: const Text('Ndio'),
            onPressed: () {
              Navigator.of(context).pop(true); // Return true when quit is pressed
            },
          ),
        ],
      );
    },
  );

  return shouldQuit ?? false;
}
  @override
  Widget build(BuildContext context) {
    // Set the status bar color to transparent with translucent background
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));

    return WillPopScope(
      onWillPop: _showExitConfirmationDialog,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
      icon: const Icon(Icons.cancel),
      onPressed: () async {
        bool? shouldQuit = await _showExitConfirmationDialog();
        if (shouldQuit == true) {
          if (Platform.isAndroid || Platform.isIOS) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop'); // Quit the app for Android and iOS
          } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
            exit(0); // Quit the app for macOS, Windows, and Linux
          }
        }
      },
    ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Handle settings button pressed
                // You can navigate to the settings screen or show a settings dialog
              },
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
            ),
            GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.only(top: 25),
              children: const <Widget>[
                FloatingDashboardCard(
                  color: Colors.purple,
               
                  title: 'Matunda',
                ),
                FloatingDashboardCard(
                  color: Colors.purple,
                  title: 'Rangi',
                ),
                FloatingDashboardCard(
                  color: Colors.purple,
                  
                  title: 'Wanyama wa porini',
                ),
                FloatingDashboardCard(
                  color: Colors.purple,
              
                  title: 'Wanyama wa nyumbani',
                ),
                FloatingDashboardCard(
                  color: Colors.purple,
                  
                  title: 'Vifaa vya usafi',
                ),
                FloatingDashboardCard(
                  color: Colors.purple,
                
                  title: 'Ndege',
                ),
                FloatingDashboardCard(
                  color: Colors.purple,
                  title: 'Vifaa vya ndani',
                ),
                FloatingDashboardCard(
                  color: Colors.purple,
                  title: 'Vyombo vya ndani',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FloatingDashboardCard extends StatelessWidget {
  final Color color;
  final String title;

  const FloatingDashboardCard({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(0),
      child: Card(
        color: color,
        elevation: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () {
            if (title == "Rangi") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OptionSelectColorScreen()),
              );
            } else if (title == "Matunda") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MatundaScreen()),
              );
            } else if (title == "Wanyama wa porini") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ColorSelector(onColorChanged: (Color ) {  },)),
              );
            } else if (title == "Wanyama wa nyumbani") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomeAnimal()),
              );
            } else if (title == "Vifaa vya usafi") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UsafiScreen()),
              );
            } else if (title == "Ndege") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NdegeScreen()),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
