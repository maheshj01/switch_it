library switch_it;

/// A Calculator.
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomSwitch extends StatefulWidget {
  /// Color for the toggle circle when the switch is on
  final Color activeColor;

  // Color for the toggle circle when the switch is off
  final Color inActiveColor;

  /// The call back returning the status of the switch
  final Function(bool) onChanged;

  /// The current Status of the switch,defaults to false if not specified
  bool isEnabled;

  /// The size for the switch should be greater than or equal to 40.0
  final double size;

  /// The child to show instead of the circle
  final EdgeInsetsGeometry padding;

  final Icon child;

  CustomSwitch(
      {Key key,
      this.activeColor = Colors.green,
      this.onChanged,
      this.isEnabled = false,
      this.inActiveColor = Colors.grey,
      this.padding,
      this.child,
      this.size = 60.0})
      : assert(size >= 40.0),
        super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with TickerProviderStateMixin {
  Widget _circleWidget() {
    return Container(
      width: _circleRadius(widget.size),
      height: _circleRadius(widget.size),
      decoration: BoxDecoration(
          color: widget.isEnabled ? widget.activeColor : widget.inActiveColor,
          borderRadius: BorderRadius.circular(_circleRadius(widget.size))),
      // child: child(),
    );
  }

  Widget child() {
    return Container(
      child: Icon(
        Icons.desktop_mac,
        size: _iconSize(widget.size),
      ),
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
  Animation<double> _animation;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: _circleRadius(widget.size),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // print('completed');
      }
    });
    // _controller.forward();
  }

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

        /// if drag is > 33% then toggle the switch
        if (difference.abs() > widget.size / 3.0) {
          widget.isEnabled = !widget.isEnabled;
          if (!widget.isEnabled) {
            _animationController.forward();
            setState(() {
              _mainAxisAlignment = MainAxisAlignment.start;
            });
          } else {
            _animationController.reverse();
            setState(() {
              _mainAxisAlignment = MainAxisAlignment.end;
            });
          }
          widget.onChanged(widget.isEnabled);
        }
      },
      //(x/d-1)*2*pi;
      child: Container(
          width: widget.size,
          height: widget.size / 2.0,
          padding: widget.padding ??
              EdgeInsets.symmetric(vertical: 2, horizontal: 3),
          decoration: BoxDecoration(
              color: Colors.white,
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
                        style: TextStyle(fontSize: _fontSize(widget.size)),
                      ),
                    )
                  : Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(
                          horizontal: _hPadding(widget.size)),
                      child: Text(
                        'Off',
                        style: TextStyle(fontSize: _fontSize(widget.size)),
                      ),
                    )
            ],
          )),
    );
  }
}
