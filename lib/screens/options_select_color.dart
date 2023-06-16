import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preschool_app/screens/paka_rangi.dart';

class OptionSelectColorScreen extends StatefulWidget {
  const OptionSelectColorScreen({super.key});

  @override
  State<OptionSelectColorScreen> createState() => _OptionSelectColorScreenState();
}

class _OptionSelectColorScreenState extends State<OptionSelectColorScreen> {
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
          iconTheme: const IconThemeData(color: Colors.white),
          actions: const [
            
          ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
            ),
           ListView(
            padding:const EdgeInsets.only(top: 280),
            children: const <Widget>[
              OptionSelectColor(
                title: "Kupaka Rangi",
              ),
              OptionSelectColor(
                title: "Jifunze aina za Rangi",
              ),
            ],
           )
        ],
      ),
    );
  }
}

class OptionSelectColor extends StatelessWidget {
  final String title;
  const OptionSelectColor({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.all(16),
      // padding: const EdgeInsets.all(80),
      height: 50,
      width: MediaQuery.of(context).size.width/2,
      child: Card(
        color: Colors.purple,
        
         elevation: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          onTap: () {
            if (title == "Kupaka Rangi") {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const PaintingScreen()));
            }else if(title == "Jifunze aina za Rangi"){
              
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