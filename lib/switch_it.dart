library switch_it;

/// A Calculator.
import 'package:flutter/material.dart';

class SwitchIt extends StatefulWidget {
  /// Color for the toggle circle when the switch is on
  final Color activeColor;

  /// Color for the toggle circle when the switch is off
  final Color inActiveColor;

  /// background Color of the Switch
  final Color backgroundColor;

  /// The call back returning the status of the switch
  final Function(bool) onChanged;

  /// Text Color for the status of the switch
  final Color color;

  /// The current Status of the switch,defaults to false if not specified
  bool isEnabled;

  /// The size for the switch should be greater than or equal to 40.0
  final double size;

  /// The child to show instead of the circle
  final EdgeInsetsGeometry padding;

  SwitchIt(
      {Key key,
      this.activeColor,
      this.onChanged,
      this.isEnabled = false,
      this.inActiveColor,
      this.padding,
      this.color,
      this.backgroundColor = Colors.white,
      this.size = 60.0})
      : assert(size >= 40.0),
        super(key: key);

  @override
  _SwitchItState createState() => _SwitchItState();
}

class _SwitchItState extends State<SwitchIt> with TickerProviderStateMixin {
  Widget _circleWidget() {
    return Container(
      width: _circleRadius(widget.size),
      height: _circleRadius(widget.size),
      decoration: BoxDecoration(
          color: widget.isEnabled
              ? widget.activeColor ?? Colors.green
              : widget.inActiveColor ?? Colors.grey,
          borderRadius: BorderRadius.circular(_circleRadius(widget.size))),
    );
  }

  /// the Radius of the circle inside the switch
  double _circleRadius(double size) {
    return size * 40 / 100;
  }

  double _iconSize(double size) => 24.0 / 100 * size;

  double _fontSize(double size) => 28.0 / 100 * size;

  double _hPadding(double size) => 5 / 100 * size;

  MainAxisAlignment _mainAxisAlignment;
  double _dragStart;
  double _dragEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        _dragStart = details.globalPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        _dragEnd = details.globalPosition.dx;
      },
      onHorizontalDragEnd: (details) {
        double difference = _dragEnd - _dragStart;

        if (difference.abs() > widget.size / 3.0) {
          if (!widget.isEnabled) {
            _mainAxisAlignment = MainAxisAlignment.start;
          } else {
            _mainAxisAlignment = MainAxisAlignment.end;
          }
          if (widget.onChanged != null) widget.onChanged(widget.isEnabled);
        }
      },
      child: Container(
          width: widget.size,
          height: widget.size / 2.0,
          padding: widget.padding ??
              EdgeInsets.symmetric(vertical: 2, horizontal: 3),
          decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(widget.size / 3)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Row(
                mainAxisAlignment: widget.isEnabled
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [_circleWidget()],
              ),
              widget.isEnabled
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                          horizontal: _hPadding(widget.size)),
                      child: Text(
                        'On',
                        style: TextStyle(
                            color: widget.color,
                            fontSize: _fontSize(widget.size)),
                      ),
                    )
                  : Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(
                          horizontal: _hPadding(widget.size)),
                      child: Text(
                        'Off',
                        style: TextStyle(
                            color: widget.color,
                            fontSize: _fontSize(widget.size)),
                      ),
                    )
            ],
          )),
    );
  }
}
