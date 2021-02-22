import 'package:flutter/material.dart';


enum LayoutOrientation { horizontal, vertical }

class LinearLayout extends StatefulWidget {
  final LayoutOrientation orientation;
  final bool isVisible;
  final Decoration background;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final List<Widget> children;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  LinearLayout({
    Key key,
    this.orientation,
    this.isVisible = true,
    this.background,
    this.padding,
    this.margin,
    this.children = const <Widget>[],
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  LinearLayoutState createState() {
    return LinearLayoutState();
  }
}

class LinearLayoutState extends State<LinearLayout> {
  bool _isVisible = true;

  @override
  void initState() {
    _isVisible = widget.isVisible;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isNotNull(_isVisible)
        ? Offstage(
      offstage: !_isVisible,
      child: _buildLayoutWidget(),
    )
        : _buildLayoutWidget();
  }

  Widget _buildLayoutWidget() {
    if (_isNeedContainerWidget()) {
      return _buildContainerWidget();
    } else {
      return _buildOrientationWidget();
    }
  }

  bool _isNeedContainerWidget() {
    return isNotNull(widget.background) ||
        isNotNull(widget.padding) ||
        isNotNull(widget.margin);
  }

  Widget _buildContainerWidget() {
    return Container(
      decoration: widget.background,
      padding: widget.padding,
      margin: widget.margin,
      child: _buildOrientationWidget(),
    );
  }

  Widget _buildOrientationWidget() {
    if (widget.orientation == LayoutOrientation.horizontal) {
      return _buildHorizontalWidget();
    } else {
      return _buildVerticalWidget();
    }
  }

  Widget _buildVerticalWidget() {
    return Column(
      mainAxisSize: widget.mainAxisSize,
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: widget.children,
    );
  }

  Widget _buildHorizontalWidget() {
    return Row(
      mainAxisSize: widget.mainAxisSize,
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: widget.children,
    );
  }

  bool isVisible() {
    return _isVisible;
  }

  void setVisible(bool isVisible) {
    setState(() {
      _isVisible = isVisible;
    });
  }
  bool isNull(dynamic obj) {
    return obj == null;
  }

  bool isNotNull(dynamic obj) {
    return obj != null;
  }

}
