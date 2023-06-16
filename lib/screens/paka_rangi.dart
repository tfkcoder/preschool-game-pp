import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class PaintingScreen extends StatefulWidget {
  const PaintingScreen({super.key,});

  @override
  State<PaintingScreen> createState() => _PaintingScreenState();
}

class _PaintingScreenState extends State<PaintingScreen> {
  DecorationImage? containerImage;

  Color selectedColor = Colors.black;
  double strokeWidth = 5;
  List<DrawingPoint> drawingPoints = [];
  List<Color> colors = [
    Colors.pink,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.amberAccent,
    Colors.purple,
    Colors.green,
    Colors.blue,
  ];

  Offset? currentPoint;
  Offset? brushPosition;

  List<String> imageList = [
    'assets/reading.png',
    'assets/reading2.png',
    'assets/reading3.png',
  ];

  Future<void> _showEditDialog() async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Badilisha picha ya kupaka'),
          content: const Text('Chagua picha ya kupaka kwenye machaguo ya picha zako'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('GHAIRI'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('CHAGUA'),
            ),
          ],
        );
      },
    );

    if (confirmation == true) {
      // ignore: use_build_context_synchronously
      final selectedImage = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('chagua picha moja'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  final imageUrl = imageList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(imageUrl);
                    },
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          );
        },
      );

      if (selectedImage != null) {
        setState(() {
          containerImage = DecorationImage(
            image: AssetImage(selectedImage),
            fit: BoxFit.cover,
          );
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme:const IconThemeData(color: Colors.blue,size: 40),
        elevation: 0,
      ),
      body: Stack(
          children: [
            Center(
              child: Container(
                height: 490,
                width: 320,
                decoration: BoxDecoration(
                  image: containerImage,
                ),
                child: Image(
                  image:
                      containerImage?.image ?? const AssetImage('assets/reading.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
              onPanDown: (details) {
                setState(() {
                  currentPoint = details.localPosition;
                  drawingPoints.add(
                    DrawingPoint(
                      currentPoint!,
                      Paint()
                        ..color = selectedColor
                        ..isAntiAlias = true
                        ..strokeWidth = strokeWidth
                        ..strokeCap = StrokeCap.round,
                    ),
                  );
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  currentPoint = details.localPosition;
                  drawingPoints.add(
                    DrawingPoint(
                      currentPoint!,
                      Paint()
                        ..color = selectedColor
                        ..isAntiAlias = true
                        ..strokeWidth = strokeWidth
                        ..strokeCap = StrokeCap.round,
                    ),
                  );
                });
              },
              onPanEnd: (details) {
                setState(() {
                  currentPoint = null;
                });
              },
              child: CustomPaint(
                painter: _DrawingPainter(drawingPoints),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            if (brushPosition != null)
              Positioned(
                left: brushPosition!.dx - 25,
                top: brushPosition!.dy - 25,
                child: Icon(
                  Icons.brush,
                  size: 50,
                  color: selectedColor.withOpacity(0.5),
                ),
              ),
            Positioned(
              top: 150,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Draggable<Color>(
                    data: selectedColor,
                    feedback: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: selectedColor.withOpacity(0.5),
                      child: const Icon(Icons.brush),
                    ),
                    childWhenDragging: Container(),
                    onDragStarted: () {
                      setState(() {
                        brushPosition = Offset.zero;
                      });
                    },
                    onDragEnd: (details) {
                      setState(() {
                        brushPosition = null;
                      });
                    },
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.brush),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    onPressed: () => setState(() => drawingPoints = []),
                    child: const Icon(Icons.delete),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(Icons.save),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    onPressed: _showEditDialog,
                    child: const Icon(Icons.edit),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(Icons.share),
                  ),
                ],
              ),
            ),
          ],
        ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              colors.length,
              (index) => _buildColorChose(colors[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorChose(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
        ),
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint> pointsList;

  _DrawingPainter(this.pointsList);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      // ignore: unnecessary_null_comparison
      if (pointsList[i + 1] != null) {
        canvas.drawLine(
            pointsList[i].point, pointsList[i + 1].point, pointsList[i].paint);
      // ignore: unnecessary_null_comparison
      } else if (pointsList[i + 1] == null) {
        canvas.drawPoints(
            ui.PointMode.points, [pointsList[i].point], pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawingPoint {
  Offset point;
  Paint paint;

  DrawingPoint(this.point, this.paint);
}


