import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';

class DropMenuManager {
  static DropMenuManager instance = DropMenuManager._internal();

  factory DropMenuManager() => instance;

  DropMenuManager._internal();

  OverlayEntry _entry;
  int _entryId = -1;
  Function _onRemove;

  /// 显示一个下拉菜单
  /// [id] 弹窗菜单唯一id
  /// [menu] 菜单widget
  /// [marginTop] 菜单显示的位置，距离顶部
  /// [menuBarHeight] 菜单栏的高度，在此区域内，点击事件由菜单栏自行处理
  /// [onRemove] 菜单被移除相应事件
  void showDropDownMenu(
    BuildContext context, {
    int id,
    Widget menu,
    double marginTop = 0,
    double menuBarHeight = 0,
    Function onRemove,
    bool isShowShadow = true,
  }) {
    if (_entry != null && id == _entryId) {
      hide();
      return;
    }

    hide();

    _onRemove = onRemove;
    _entryId = id;

    _entry = OverlayEntry(builder: (context) {
      return DropMenu(
        onRemove: hide,
        marginTop: marginTop,
        menuBarHeight: menuBarHeight,
        menu: menu,
        isShowShadow: isShowShadow,
      );
    });
    Overlay.of(context).insert(_entry);
  }

  /// 隐藏当前的下拉菜单
  void hide() {
    if (_entry == null) {
      return;
    }

    _entry.remove();
    _entry = null;
    _onRemove?.call();
    _entryId = -1;
  }

  /// 下拉菜单是否正在显示
  bool isShowing() => _entry != null;

  /// 获取 Widget 距离屏幕顶部的距离，用于设置下拉弹窗的显示位置
  /// [context] 被检测的 Widget 需配置 GlobalKey,再传入 key.currentContext
  double getWeightMarginTop(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    Offset offset = renderBox.localToGlobal(Offset.zero);
    return offset.dy;
  }
}

class DropMenu extends StatefulWidget {
  final Function onRemove;
  final double marginTop;
  final Widget menu;
  final double menuBarHeight;
  final bool isShowShadow;

  const DropMenu({
    Key key,
    this.onRemove,
    this.marginTop,
    this.menu,
    this.menuBarHeight,
    this.isShowShadow = true,
  }) : super(key: key);

  @override
  _DropMenuState createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: widget.marginTop - widget.menuBarHeight,
            ),
            onTap: widget.onRemove,
          ),
          Container(
            height: widget.menuBarHeight,
          ),
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: widget.isShowShadow
                        ? Color.fromRGBO(0, 0, 0, 0.5)
                        : null,
                  ),
                  onTap: widget.onRemove,
                ),
                SizeTransition(
                  sizeFactor: controller,
                  child: widget.menu,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
