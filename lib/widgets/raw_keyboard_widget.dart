import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slservers/widgets/snackbars.dart';

class RawKeyboardWidget extends StatefulWidget {
  final Widget child;
  RawKeyboardWidget({@required this.child});

  @override
  _RawKeyboardWidgetState createState() => _RawKeyboardWidgetState();
}

class _RawKeyboardWidgetState extends State<RawKeyboardWidget> {
  final FocusNode _focusNode = FocusNode();
  RawKeyEvent _event;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String _getEnumName(dynamic enumItem) {
    final String name = '$enumItem';
    final int index = name.indexOf('.');
    return index == -1 ? name : name.substring(index + 1);
  }

  void _handleKeyEvent(RawKeyEvent event) {
    setState(() => _event = event);
    final RawKeyEventData data = _event.data;
    final String modifierList = data.modifiersPressed.keys
        .map<String>(_getEnumName)
        .join(', ')
        .replaceAll('Modifier', '');
    final List<Widget> dataText = <Widget>[
      TextField(),
      Text('${_event.runtimeType}'),
      Text('modifiers set: $modifierList'),
    ];

    var unknownKey = '';
    for (ModifierKey modifier in data.modifiersPressed.keys) {
      for (KeyboardSide side in KeyboardSide.values) {
        if (data.isModifierPressed(modifier, side: side)) {
          var alienKey =
              '${_getEnumName(side)}${_getEnumName(modifier).replaceAll('Modifier', '')}';
          unknownKey = '$unknownKey$alienKey';
          dataText.add(
            Text('$alienKey pressed'),
          );
        }
      }
    }

    //start keyboard keymap
    var focus = FocusScope.of(context).focusedChild;

    if (focus != null) {
      var widget = focus.context.widget;
      if (widget is EditableText) {
        var controller = widget.controller;
        var shiftPressed =
            _event.isShiftPressed || unknownKey.contains('shift');
        var ctrlPressed = _event.isKeyPressed(LogicalKeyboardKey.control) ||
            unknownKey.contains(RegExp(r'(control|meta)'));
        var isA = _event.logicalKey == LogicalKeyboardKey.keyA;
        var isC = _event.logicalKey == LogicalKeyboardKey.keyC;
        var isV = _event.logicalKey == LogicalKeyboardKey.keyV;
        var isX = _event.logicalKey == LogicalKeyboardKey.keyX;
        var isLeft = _event.logicalKey == LogicalKeyboardKey.arrowLeft ||
            _event.logicalKey.keyId == 0x0000f702;
        var isRight = _event.logicalKey == LogicalKeyboardKey.arrowRight ||
            _event.logicalKey.keyId == 0x0000f703;
        //select all
        if (ctrlPressed && isA) {
          controller.selection = TextSelection(
              baseOffset: 0, extentOffset: controller.text.length);
        }

        //copy
        if (ctrlPressed && isC) {
          var selectedText = controller.text.substring(
              controller.selection.baseOffset,
              controller.selection.extentOffset);
          Clipboard.setData(ClipboardData(text: selectedText));
          info(context, "Copied selected text to clipboard");
        }

        //paste
        if (ctrlPressed && isV) {
          Clipboard.getData("text/plain").then((data) {
            if (controller.selection.end > controller.selection.start) {
              var selectedText =
              controller.selection.textInside(controller.text);
              controller.text = controller.text.replaceFirst(
                  selectedText, data.text, controller.selection.start);
            } else if (controller.selection.start == 0 &&
                controller.selection.end == 0) {
              controller.text = '${data.text}${controller.text}';
              controller.selection = TextSelection(
                  baseOffset: controller.text.length,
                  extentOffset: controller.text.length);
            } else if (controller.selection.start == controller.selection.end) {
              var firstWord =
              controller.text.substring(0, controller.selection.end);
              var secondWord = controller.text
                  .substring(controller.selection.end, controller.text.length);
              var firstPaste = '$firstWord${data.text}';
              controller.text = '$firstPaste$secondWord';
              controller.selection = TextSelection(
                  baseOffset: firstPaste.length,
                  extentOffset: firstPaste.length);
            }
          });
        }

        ///cut
        if (ctrlPressed &&
            isX &&
            controller.selection.start != controller.selection.end) {
          var selectedText = controller.selection.textInside(controller.text);
          controller.text = controller.text
              .replaceFirst(selectedText, '', controller.selection.start);
          Clipboard.setData(ClipboardData(text: selectedText));
        }

        //shift
        if (shiftPressed) {
          var start = controller.selection.start;
          var end = controller.selection.end;
          var maxLen = controller.text.length;
          if (isLeft) {
            --start;
            start = max(0, start);
            controller.selection =
                TextSelection(baseOffset: start, extentOffset: end);
          } else if (isRight) {
            ++end;
            end = min(end, maxLen);
            controller.selection =
                TextSelection(baseOffset: start, extentOffset: end);
          }
        }
      }
    }
    //end keyboard keymap
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: widget.child,
    );
  }
}