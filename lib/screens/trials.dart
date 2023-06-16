import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorSelector extends StatefulWidget {
  final Function(Color) onColorChanged;

  const ColorSelector({Key? key, required this.onColorChanged}) : super(key: key);

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color _selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ColorDot(color: Colors.red, isSelected: _selectedColor == Colors.red, onTap: () => _selectColor(Colors.red)),
        ColorDot(color: Colors.blue, isSelected: _selectedColor == Colors.blue, onTap: () => _selectColor(Colors.blue)),
        ColorDot(color: Colors.green, isSelected: _selectedColor == Colors.green, onTap: () => _selectColor(Colors.green)),
        // Add more color options here
      ],
    );
  }

  void _selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
    widget.onColorChanged(color);
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorDot({required this.color, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 2.0),
        ),
      ),
    );
  }
}

class SvgImageColorChange extends StatefulWidget {
  @override
  _SvgImageColorChangeState createState() => _SvgImageColorChangeState();
}

class _SvgImageColorChangeState extends State<SvgImageColorChange> {
  Color _selectedColor = Colors.black;

  void _handleColorChanged(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/cat.svg',
          color: _selectedColor,
          semanticsLabel: 'A circle',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 20),
        ColorSelector(onColorChanged: _handleColorChanged),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVG Image Color Change',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('SVG Image Color Change'),
        ),
        body: Center(
          child: SvgImageColorChange(),
        ),
      ),
    );
  }
}
