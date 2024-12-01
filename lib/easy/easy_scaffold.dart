import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stardeweather/main.dart';
import 'package:get/get.dart';
import 'package:stardeweather/easy/easy_button.dart';

class EasyScaffold extends StatefulWidget {

  final Widget? fixBody;

  final List<Widget>? fixBodyList;

  final Widget? resizeBody;

  final Widget? floatingRightBottomButton;

  final Widget? fixFloatingRightBottomButton;

  final Widget? fixFloatingBottomButton;

  final Widget? appBar;

  final Widget? fixBottomBar;

  final Widget? resizeBottomBar;

  final List<Positioned>? afterBodyPositionedList;

  const EasyScaffold({
    this.floatingRightBottomButton, 
    this.fixFloatingRightBottomButton, 
    this.fixFloatingBottomButton, 
    this.appBar,
    this.fixBody,
    this.fixBodyList,
    this.fixBottomBar,
    this.resizeBody,
    this.resizeBottomBar,
    this.afterBodyPositionedList,
    super.key
  });

  @override
  State<EasyScaffold> createState() => EasyScaffoldState();
}

class EasyScaffoldState extends State<EasyScaffold> with WidgetsBindingObserver {

  double bottomPadding = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment:Alignment.center,
      fit: StackFit.expand,
      children: stackChileren(context)
    );
  }

  List<Widget> stackChileren(BuildContext context) {
    List<Widget> stackChileren = [];
    MediaQueryData contextMediaQuery = MediaQueryData.fromView(View.of(context));
    double contextHeight = contextMediaQuery.size.height;
    double contextWidth  = contextMediaQuery.size.width;
    // child
    if (widget.fixBody!=null) {
      stackChileren.add(fixBody(contextWidth, contextHeight));
    }
    // children
    if (widget.fixBodyList!=null) {
      stackChileren.add(fixBodyList(contextWidth, contextHeight));
    }
    // child
    if (widget.resizeBody!=null) {
      stackChileren.add(resizeBody(contextWidth, contextHeight));
    }
    // after body
    if (widget.afterBodyPositionedList!=null && widget.afterBodyPositionedList!.isNotEmpty) {
      for (var positioned in widget.afterBodyPositionedList!) {
        stackChileren.add(positioned);
      }
    }
    // head
    if (widget.appBar!=null) {
      stackChileren.add(appBar(contextWidth));
    }
    // floatingRightBottomButton
    if (widget.floatingRightBottomButton!=null) {
      stackChileren.add(
        Positioned(
          right: 10,
          bottom: bottomPadding + (widget.resizeBottomBar!=null && widget.fixBottomBar!=null ? ui.footHeight : 0) + 10,
          child: widget.floatingRightBottomButton!
        )
      );
    }
    // fixFloatingBottomButton
    if (widget.fixFloatingBottomButton!=null) {
      stackChileren.add(
        Positioned(
          bottom: 10,
          child: widget.fixFloatingBottomButton!
        )
      );
    }
    // fixFloatingRightBottomButton
    if (widget.fixFloatingRightBottomButton!=null) {
      stackChileren.add(
        Positioned(
          right: 10,
          bottom: 10,
          child: widget.fixFloatingRightBottomButton!
        )
      );
    }
    // fixBottomBar
    if (widget.fixBottomBar!=null) {
      stackChileren.add(fixBottomBar(contextWidth));
    }
    // resizeBottomBar
    if (widget.resizeBottomBar!=null) {
      stackChileren.add(resizeBottomBar(contextWidth));
    }
    return stackChileren;
  }

  Widget fixBody(double contextWidth, double contextHeight) {
    return Positioned(
      width: contextWidth,
      height: contextHeight,
      top: 0,
      child: widget.fixBody!
    );
  }

  Widget fixBodyList(double contextWidth, double contextHeight) {
    return Positioned(
      width: contextWidth,
      height: contextHeight,
      top: 0,
      child: ListView(
        children:widget.fixBodyList!
      )
    );
  }

  Widget resizeBody(double contextWidth, double contextHeight) {
    return Positioned(
      width: contextWidth,
      height: contextHeight - bottomPadding,
      top:0,
      child: widget.resizeBody!
    );
  }

  Widget appBar(double contextWidth) {
    return Positioned(
      width: contextWidth,
      top  : 0,
      child : widget.appBar!
    );
  }

  Widget fixBottomBar(double contextWidth) {
    return Positioned(
      width: contextWidth,
      bottom: 0,
      child: widget.fixBottomBar!
    );
  }

  Widget resizeBottomBar(double contextWidth) {
    return Positioned(
      width: contextWidth,
      bottom: bottomPadding,
      child: widget.resizeBottomBar!
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 监听
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (widget.resizeBottomBar!=null || widget.resizeBody!=null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(mounted){
          setState(() {
            bottomPadding = MediaQuery.of(context).viewInsets.bottom;
          });
        }
      });
    }
  }
}

class EasyScaffoldAppBar extends StatefulWidget {

  final Color? backgroundColor;

  final double? radius;

  final Widget? title;

  final Widget? logo;

  final IconData? closeIconData;
      
  final List<Widget>? actions;

  final Function? onBack;

  final Color? closeIconColor;

  const EasyScaffoldAppBar({
    super.key,
    this.backgroundColor,
    this.radius,
    this.title,
    this.logo,
    this.closeIconData,
    this.closeIconColor,
    this.actions,
    this.onBack,
  });

  @override
  State<EasyScaffoldAppBar> createState() => _EasyScaffoldAppBarState();
}

class _EasyScaffoldAppBarState extends State<EasyScaffoldAppBar> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData contextMediaQuery = MediaQueryData.fromView(View.of(context));
    double contextWidth  = contextMediaQuery.size.width;

    List<Widget> children = [];

    // logo
    if (widget.logo!=null) {
      children.add(
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: widget.logo
        )
      );
    }
    // go back
    else {
      children.add(
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: EasyButton.custom(
            iconData: widget.closeIconData??Icons.arrow_back_ios,
            iconColor: widget.closeIconColor??Colors.black,
            iconSize: 20,
            width: 30,
            height: 30,
            borderRadius: 5,
            onPressed: (){
              widget.onBack==null ? Get.back() : widget.onBack!();
            }
          )
        )
      );
    }

    // title
    children.add(
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(0, 0, (widget.logo!=null) ?0 : 52, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              widget.title??const SizedBox()
            ]
          )
        )
      )
    );

    // actions
    if (widget.actions!=null) {
      for (var element in widget.actions!) {
        children.add(
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 3),
            child: element
          )
        );
      }
    }

    return ClipRect(
      child  : BackdropFilter(
        filter : ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child  : Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.fromLTRB(0, ui.topHeight, 0, 0),
          color  : widget.backgroundColor,
          height : ui.headHeight,
          width  : contextWidth,
          child  : Row(
            children: children,
          )
        )
      )
    );
  }
}


enum EasyScaffoldNavigationBarType {
  choice,
  click
}

class EasyScaffoldNavigationBar extends StatefulWidget {

  final Color? backgroundColor;

  final double? radius;

  final int? defaultIndex;

  final Function(int)? onTap;

  final EasyScaffoldNavigationBarType? type;

  final List<Widget> items;

  const EasyScaffoldNavigationBar({
    super.key,
    this.backgroundColor,
    this.radius,
    this.defaultIndex,
    this.onTap,

    this.type = EasyScaffoldNavigationBarType.choice,
    required this.items
  }) : assert(items.length >= 2);

  @override
  State<EasyScaffoldNavigationBar> createState() => _EasyScaffoldNavigationBarState();
}

class _EasyScaffoldNavigationBarState extends State<EasyScaffoldNavigationBar> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    MediaQueryData contextMediaQuery = MediaQueryData.fromView(View.of(context));
    double contextWidth  = contextMediaQuery.size.width;

    List<Widget> buttonList = [];
    for (int ii=0; ii<widget.items.length; ii++) {
      buttonList.add(
        SizedBox(
          width: contextWidth/(widget.items.length),
          child: (widget.items[ii] is !EasyScaffoldNavigationBarItem)
            ? widget.items[ii]
            : easyScaffoldNavigationBarItem(widget.items[ii], ii)
          )
      );
    }

    double zz = ui.windowWidth / buttonList.length / 2 - 20 + (ui.windowWidth / buttonList.length) * currentIndex;

    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(widget.radius??0), topRight: Radius.circular(widget.radius??0)),
      child: ClipRect(
        // child: BackdropFilter(
        //  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            height: 56,
            width: contextWidth,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment:Alignment.center,
              fit: StackFit.loose,
              children: [
                // const SizedBox(height:3),
                Positioned(
                  top:0,
                  bottom:0,
                  child:Row(
                    children: buttonList
                  )
                ),
                Positioned(
                  top:0,
                  left:0,
                  width: ui.windowWidth,
                  child: const Divider(height: 1, color: Color(0x17000000))
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 100),
                  height:2,
                  width: 40,
                  top:0,
                  left: zz,
                  child: Container(
                    height: 2, 
                    width: 40, 
                    color: (widget.type==EasyScaffoldNavigationBarType.choice) ? Colors.red : Colors.transparent
                  )
                ),
              ]
            )
          ),
        )
    //  )
    );
  }

  Widget easyScaffoldNavigationBarItem(dynamic barItem, int ii) {
    return EasyScaffoldNavigationBarItem(
      iconData: barItem.iconData,
      label: barItem.label,
      borderRadius: barItem.borderRadius,
      onTap: (context){
        if (widget.onTap!=null) {
          widget.onTap!(ii);
        }
        if (barItem.onTap!=null) {
          barItem.onTap!(context);
        }
        if (widget.type==EasyScaffoldNavigationBarType.choice) {
          setState(() {
            currentIndex = ii;
          });
        }
      },
      fillColor: barItem.fillColor,
      textColor: barItem.textColor,
      iconColor: barItem.iconColor,
      icon: barItem.icon,
    );
  }
}

class EasyScaffoldNavigationBarItem extends StatefulWidget {

  final Widget? icon;

  final IconData? iconData;

  final String? label;

  final Function(BuildContext)? onTap;

  final Color? fillColor;

  final Color textColor;

  final Color iconColor;

  final double borderRadius;
  
  const EasyScaffoldNavigationBarItem({
    super.key,
    this.iconData,
    this.icon,
    this.fillColor,
    this.iconColor=Colors.black54,
    this.textColor=Colors.black54,
    this.label,
    this.borderRadius=0,
    this.onTap
  });

  @override
  State<EasyScaffoldNavigationBarItem> createState() => EasyScaffoldNavigationBarItemState();
}

class EasyScaffoldNavigationBarItemState extends State<EasyScaffoldNavigationBarItem> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return EasyButton.custom(
      onPressed: widget.onTap==null?null:(){widget.onTap!(context);},
      borderRadius: widget.borderRadius,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      height:56,
      fillColor: widget.fillColor??Colors.transparent,
      axis: Axis.vertical, 
      icon: widget.icon,
      iconData: widget.iconData, 
      iconColor: widget.iconColor,
      iconSize: 22, 
      text: widget.label,
      textColor: widget.textColor,
      textSize: 12
    );
  }
}