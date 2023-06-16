import 'package:flutter/material.dart';

class UsafiScreen extends StatefulWidget {
  const UsafiScreen({super.key});

  @override
  State<UsafiScreen> createState() => _UsafiScreenState();
}

class _UsafiScreenState extends State<UsafiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vifaa vya Usafi'),),
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
                          child: Text('Sabuni',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
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