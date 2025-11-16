import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedMatrixText extends StatefulWidget {
  final List<String> texts;
  final int currentIndex;
  final TextStyle? style;
  final Duration duration;

  const AnimatedMatrixText({
    Key? key,
    required this.texts,
    required this.currentIndex,
    this.style,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _AnimatedMatrixTextState createState() => _AnimatedMatrixTextState();
}

class _AnimatedMatrixTextState extends State<AnimatedMatrixText> {
  Timer? _timer;
  late String _currentText;
  late String _targetText;

  static const _chars =
      'абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';

  @override
  void initState() {
    super.initState();
    _targetText = widget.texts[widget.currentIndex];
    _currentText = _initializeCurrentText(_targetText.length);
    _startAnimation();
  }

  @override
  void didUpdateWidget(AnimatedMatrixText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex ||
        widget.texts != oldWidget.texts) {
      _targetText = widget.texts[widget.currentIndex];
      _adjustCurrentTextLength();
      _startAnimation();
    }
  }

  String _initializeCurrentText(int length) {
    return List.generate(length, (_) => _randomChar()).join();
  }

  void _adjustCurrentTextLength() {
    final targetLength = _targetText.length;
    final currentLength = _currentText.length;
    if (currentLength < targetLength) {
      _currentText += _initializeCurrentText(targetLength - currentLength);
    } else if (currentLength > targetLength) {
      _currentText = _currentText.substring(0, targetLength);
    }
  }

  void _startAnimation() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 20), (_) {
      StringBuffer newText = StringBuffer();

      for (int i = 0; i < _targetText.length; i++) {
        if (i >= _currentText.length) {
          newText.write(_targetText[i]);
          continue;
        }

        String currentChar = _currentText[i];
        String targetChar = _targetText[i];

        if (currentChar == targetChar) {
          newText.write(targetChar);
        } else {
          int currentIndex = _chars.indexOf(currentChar);
          int targetIndex = _chars.indexOf(targetChar);

          if (currentIndex == -1 || targetIndex == -1) {
            newText.write(targetChar);
            continue;
          }

          int distance = (targetIndex - currentIndex).abs();
          int direction = (targetIndex > currentIndex) ? 1 : -1;

          // Если далеко — шагаем сразу на 3 символа
          int stepSize = distance > 3 ? 3 : 1;

          int nextIndex = currentIndex + stepSize * direction;

          // Корректируем границы массива
          if (nextIndex < 0) nextIndex = 0;
          if (nextIndex >= _chars.length) nextIndex = _chars.length - 1;

          newText.write(_chars[nextIndex]);
        }
      }

      setState(() {
        _currentText = newText.toString();
      });

      if (_currentText == _targetText) {
        _timer?.cancel();
      }
    });
  }


  String _randomChar() {
    return String.fromCharCode(_chars.codeUnitAt(
        DateTime.now().microsecond % _chars.length));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentText,
      style: widget.style ?? const TextStyle(letterSpacing: 2, fontFamily: 'Courier'),
      textAlign: TextAlign.center,
    );
  }
}
