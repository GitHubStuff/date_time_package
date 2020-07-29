import 'dart:ui';

import 'package:date_time_package/date_time_package.dart';
import 'package:date_time_package/picker/constants.dart' as Constant;
import 'package:date_time_package/picker/models/widgets/triangle_painter.dart';
import 'package:flutter/material.dart';
import 'package:tracers/tracers.dart' as Log;

enum PopoverDirection { above, below }

class DateTimePopoverWidget {
  static BuildContext _context;

  PopoverDirection _direction;
  Offset _offset;
  OverlayEntry _overlayEntry;
  Size _screenSize;
  Rect _showRect; //The rectangle of the widget the popover will display to.

  //Creates rectangle of the widget the popover will display above/below/left/right of.
  static Rect _getWidgetRectangle(GlobalKey globalKey) {
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  DateTimePopoverWidget({BuildContext context}) {
    if (context != null) DateTimePopoverWidget._context = context;
  }

  void show({@required GlobalKey widgetKey}) {
    if (widgetKey == null) throw FlutterError('Cannot have null widget key');
    _screenSize = window.physicalSize / window.devicePixelRatio;
    _showRect = DateTimePopoverWidget._getWidgetRectangle(widgetKey);
    _offset = _calculateOffset(DateTimePopoverWidget._context);
    _overlayEntry = OverlayEntry(builder: (context) {
      return buildPopoverLayout(_offset);
    });
    Overlay.of(DateTimePopoverWidget._context).insert(_overlayEntry);
  }

  Offset _calculateOffset(BuildContext context) {
    double dx = _showRect.left + _showRect.width / 2.0 - Constant.pickerWidth / 2.0;
    if (dx < 10.0) {
      dx = 10.0;
    }

    if (dx + Constant.pickerWidth > _screenSize.width && dx > 10.0) {
      double tempDx = _screenSize.width - Constant.pickerWidth - 10;
      if (tempDx > 10) dx = tempDx;
    }

    double dy = _showRect.top - Constant.totalPickerHeight;
    if (dy <= MediaQuery.of(context).padding.top + 10) {
      // The have not enough space above, show menu under the widget.
      dy = Constant.arrowHeight + _showRect.height + _showRect.top;
      _direction = PopoverDirection.above;
    } else {
      dy -= Constant.arrowHeight;
      _direction = PopoverDirection.below;
    }

    return Offset(dx, dy);
  }

  LayoutBuilder buildPopoverLayout(Offset offset) {
    return LayoutBuilder(builder: (context, constraints) {
      final Color _arrowColor =
          (Theme.of(context).brightness == Brightness.light) ? Constant.primaryColor.dark : Constant.primaryColor.light;
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          dismiss();
        },
        onVerticalDragStart: (DragStartDetails details) {
          Log.v('onVerticalDragStart');
          dismiss();
        },
        onHorizontalDragStart: (DragStartDetails details) {
          Log.v('onHorizontalDragStart');
          dismiss();
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              // triangle arrow
              Positioned(
                left: _showRect.left + _showRect.width / 2.0 - 7.5,
                top: _direction == PopoverDirection.below
                    ? offset.dy + Constant.totalPickerHeight
                    : offset.dy - Constant.arrowHeight,
                child: CustomPaint(
                  size: Size(15.0, Constant.arrowHeight),
                  painter: TrianglePainter(direction: _direction, color: _arrowColor),
                ),
              ),
              // menu content
              Positioned(
                left: offset.dx,
                top: offset.dy,
                child: Container(
                  width: Constant.pickerWidth,
                  height: Constant.totalPickerHeight,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: Constant.pickerWidth,
                            height: Constant.totalPickerHeight,
                            decoration: BoxDecoration(color: _arrowColor, borderRadius: BorderRadius.circular(10.0)),
                            child: _dialogWrapper(context),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _dialogWrapper(BuildContext context) {
    // Wrap in a dialog to make sure Theme propagates
    return Dialog(
      insetPadding: EdgeInsets.all(0.0),
      child: DateTimePickerWidget(),
    );
  }

  void dismiss() {
    if (_direction == null) {
      // Remove method should only be called once
      return;
    }

    _overlayEntry.remove();
    _direction = null;
    // if (dismissCallback != null) {
    //   dismissCallback();
    // }

    // if (this.stateChanged != null) {
    //   this.stateChanged(false);
    // }
  }
}
