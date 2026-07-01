import 'dart:async';
import 'package:flutter/material.dart';

/// Types out [text] character-by-character on first load with an optional cursor.
class TypewriterText extends StatefulWidget {
  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.speed = const Duration(milliseconds: 42),
    this.delay = Duration.zero,
    this.showCursor = true,
    this.cursorColor,
    this.onFinished,
  });

  final String text;
  final TextStyle style;
  final Duration speed;
  final Duration delay;
  final bool showCursor;
  final Color? cursorColor;
  final VoidCallback? onFinished;

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _visibleChars = 0;
  bool _finished = false;
  bool _cursorVisible = true;
  Timer? _typeTimer;
  Timer? _cursorTimer;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _delayTimer = Timer(widget.delay, _startTyping);
    if (widget.showCursor) {
      _cursorTimer = Timer.periodic(const Duration(milliseconds: 530), (_) {
        if (mounted && !_finished) {
          setState(() => _cursorVisible = !_cursorVisible);
        }
      });
    }
  }

  void _startTyping() {
    if (widget.text.isEmpty) {
      _complete();
      return;
    }
    _typeTimer = Timer.periodic(widget.speed, (timer) {
      if (!mounted) return;
      if (_visibleChars >= widget.text.length) {
        timer.cancel();
        _complete();
        return;
      }
      setState(() => _visibleChars++);
    });
  }

  void _complete() {
    if (_finished) return;
    _finished = true;
    _cursorTimer?.cancel();
    setState(() => _cursorVisible = false);
    widget.onFinished?.call();
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _typeTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visible = widget.text.substring(0, _visibleChars);
    final cursorColor = widget.cursorColor ?? widget.style.color ?? Colors.white;

    return RichText(
      text: TextSpan(
        style: widget.style,
        children: [
          TextSpan(text: visible),
          if (widget.showCursor && !_finished && _cursorVisible)
            TextSpan(
              text: '|',
              style: widget.style.copyWith(
                color: cursorColor,
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      ),
    );
  }
}
