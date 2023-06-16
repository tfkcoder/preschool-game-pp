import 'package:flutter/material.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wanyama wa porini'),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget> [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    child: const Row(
                      children: [
                        Icon(Icons.pets_outlined,color: Colors.white,size: 90,),
                       
                        Padding(
                          padding: EdgeInsets.only(left:80.0),
                          child: Text('Simba',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              
          ],
        ),
      ),
    );
  }
}