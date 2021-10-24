import 'package:flutter/material.dart';
import 'package:myapp/ModifiedPackages/Glow/Glow.dart';

class BaseIndicator extends StatelessWidget {
  /// Whether this indicator is selected or not.
  final bool isSelected;

  /// The child to be placed within the indicator.
  final Widget? child;

  final bool isDone;

  final int? index;

  final int? activeStep;

  final int? selectedBorder;

  /// Action to be taken when this indictor is pressed.
  final Function? onPressed;

  /// Color of this indicator when it is not selected.
  final Color? color;

  /// Color of this indicator when it is selected.
  final Color? activeColor;

  /// Border color of this indicator when it is selected.
  final Color? activeBorderColor;

  /// The border width of this indicator when it is selected.
  final activeBorderWidth;

  /// Radius of this indicator.
  final double radius;

  /// The amount of padding around each side of the child.
  final double padding;

  /// The amount of margin around each side of the indicator.
  final double margin;

  BaseIndicator({
    this.isSelected = false,
    this.child,
    this.index,
    this.selectedBorder,
    this.activeStep,
    this.isDone = false,
    this.onPressed,
    this.color,
    this.activeColor,
    this.activeBorderColor,
    this.radius = 24.0,
    this.padding = 5.0,
    this.margin = 1.0,
    this.activeBorderWidth = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return GlowCircle(
        bline: BaseIndicator(
      isSelected: isSelected,
      child: child,
      index: index,
      activeStep: activeStep,
      onPressed: onPressed,
      color: color,
      isDone: isDone,
      activeColor: activeColor,
      activeBorderColor: activeBorderColor,
      radius: radius,
      padding: padding,
      margin: margin,
      selectedBorder: selectedBorder,
      activeBorderWidth: activeBorderWidth,
    ));
  }
}

class GlowCircle extends StatefulWidget {
  late BaseIndicator bline;

  GlowCircle({required this.bline});
  @override
  _GlowCircle createState() => new _GlowCircle();
}

class _GlowCircle extends State<GlowCircle>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationcontroller;

  @override
  void initState() {
    animationcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    animationcontroller.repeat();

    animation = Tween<double>(begin: 0, end: 350).animate(animationcontroller);

    animation.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Text(
        'Please complete previous Lessons',
        textAlign: TextAlign.center,
      ),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
        },
      ),
    );

    return Container(
      //width: 60,
      padding: widget.bline.isSelected
          ? EdgeInsets.all(widget.bline.margin)
          : EdgeInsets.zero,
      child: InkWell(
        onTap: widget.bline.index! > widget.bline.activeStep!
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            : widget.bline.onPressed as void Function()?,
        child: AvatarGlow(
          endRadius: 35,
          glowColor: Colors.green,
          showTwoGlows: true,
          repeat: true,
          duration: Duration(seconds: 2),
          animate: widget.bline.isSelected,
          child: Material(
            elevation: 6.0,
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: widget.bline.isSelected
                  ? widget.bline.activeColor ?? Colors.green
                  : widget.bline.isDone
                      ? widget.bline.color ?? Colors.grey.shade100
                      : widget.bline.index! > widget.bline.activeStep!
                          ? Colors.lightBlue.shade50
                          : Colors.redAccent,
              child: widget.bline.child,
              radius: 24,
            ),
          ),
        ),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //       title: Text("Simple Concept of Animation"),
    //       backgroundColor: Colors.redAccent),
    //   body: Container(
    //     padding: EdgeInsets.all(20),
    //     alignment: Alignment.center,
    //     height: 300,
    //     child: Container(
    //       decoration: BoxDecoration(
    //           shape: BoxShape.circle, //making box to circle
    //           color: Colors.deepOrangeAccent //background of container
    //           ),
    //       height: animation.value, //value from animation controller
    //       width: animation.value, //value from animation controller
    //     ),
    //   ),
    // );
  }
}




// Container(
//       padding: widget.bline.isSelected
//           ? EdgeInsets.all(widget.bline.margin)
//           : EdgeInsets.zero,
//       decoration: BoxDecoration(
//         border: widget.bline.selectedBorder == widget.bline.index
//             ? Border.all(
//                 color: widget.bline.activeBorderColor ?? Colors.blue,
//                 width: widget.bline.activeBorderWidth,
//               )
//             : null,
//         shape: BoxShape.circle,
//       ),
//       child: InkWell(
//         onTap: widget.bline.onPressed as void Function()?,
//         child: Container(
//           height: widget.bline.radius * 2,
//           alignment: Alignment.center,
//           width: widget.bline.radius * 2,
//           padding: EdgeInsets.all(widget.bline.padding),
//           child: Container(
//             //value from animation controller
//             decoration: BoxDecoration(
//               color: widget.bline.isSelected
//                   ? widget.bline.activeColor ?? Colors.green
//                   : widget.bline.isDone
//                       ? widget.bline.color ?? Colors.grey
//                       : widget.bline.index! > widget.bline.activeStep!
//                           ? Colors.grey.shade400
//                           : Colors.redAccent,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: widget.bline.child,
//             ),
//           ),
//         ),
//       ),
//     );