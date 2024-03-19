import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_platform/resources/color_manager.dart';

class CustomExpansionTileWidget extends StatelessWidget {
  final Widget title;
  final Widget children;
  final Color? expansionColor;

  const CustomExpansionTileWidget(
      {Key? key,
      required this.title,
      required this.children,
      this.expansionColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(),
        tilePadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 13.w),
        collapsedBackgroundColor:
            theme.scaffoldBackgroundColor.withOpacity(0.7),
        backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.7),
        collapsedIconColor: theme.primaryColor,
        collapsedShape: const RoundedRectangleBorder(),
        title: Row(children: [
          title,
        ]),
        children: [
          Container(
              width: 1.sw,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: expansionColor ?? theme.scaffoldBackgroundColor,
              ),
              child: children)
        ],
      ),
    );
  }
}

const Duration _kExpand = Duration(milliseconds: 400);

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    required Key key,
    this.leading = const SizedBox.shrink(),
    required this.title,
    this.backgroundColor = Colors.white24,
    this.children = const <Widget>[],
    required this.trailing,
    required this.expandedItem,
  }) : super(key: key);

  /// A widget to display before the title.
  ///
  /// Typically a [CircleAvatar] widget.
  final Widget leading;

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// The widgets that are displayed when the tile expands.
  ///
  /// Typically [ListTile] widgets.
  final List<Widget> children;

  /// The color to display behind the sublist when expanded.
  final Color backgroundColor;

  /// A widget to display instead of a rotating arrow icon.
  final Widget trailing;

  final ValueNotifier<Key> expandedItem;

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _borderColor;
  late Animation<Color?> _headerColor;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = widget.expandedItem.value == widget.key;
    if (_isExpanded) _controller.value = 1.0;

    widget.expandedItem.addListener(listener);
  }

  void listener() {
    setState(() {
      _changeState(widget.expandedItem.value == widget.key);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.expandedItem.removeListener(listener);
    super.dispose();
  }

  void _changeState(bool isExpanded) {
    setState(() {
      _isExpanded = isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });
  }

  void _handleTap() {
    _changeState(!_isExpanded);
    widget.expandedItem.value = (_isExpanded ? widget.key : null)!;
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color borderSideColor = _borderColor.value ?? Colors.transparent;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          border: Border(
            top: BorderSide(color: borderSideColor),
            bottom: BorderSide(color: borderSideColor),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTileTheme.merge(
              iconColor: _iconColor.value,
              textColor: _headerColor.value,
              child: ListTile(
                onTap: _handleTap,
                // leading: widget.leading,
                title: widget.title,
                trailing: widget.trailing ??
                    RotationTransition(
                      turns: _iconTurns,
                      child: const Icon(Icons.expand_more),
                    ),
              ),
            ),
            ClipRect(
              child: Align(
                heightFactor: _heightFactor.value,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    // _headerColorTween
    //   ..begin = theme.textTheme.subhead.color
    //   ..end = theme.accentColor;
    // _iconColorTween
    //   ..begin = theme.unselectedWidgetColor
    //   ..end = theme.accentColor;
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Container(
              color: ColorManager.darkGrey,
              padding: EdgeInsetsDirectional.only(start: 8.w, bottom: 10.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.children),
            ),
    );
  }
}
