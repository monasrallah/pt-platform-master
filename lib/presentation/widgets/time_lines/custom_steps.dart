// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:helpco_captin/resources/extensions/size_extension.dart';
// import 'package:helpco_captin/view/shared_controllers/steps_controller.dart';
//
// class CustomSteps extends GetView<StepsController> {
//   double? lineWidth = 22.h;
//   double? lineHeight = 0.8.w;
//   final double? circleWidth;
//
//   CustomSteps({this.lineWidth, this.lineHeight, this.circleWidth,Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Column(
//           children: [
//             Container(
//               height: circleWidth ?? 4.w,
//               width: circleWidth ?? 4.w,
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       color: controller.currentIndex.value >= 2
//                           ? Colors.transparent
//                           : theme.unselectedWidgetColor,
//                       width: 1.5),
//                   shape: BoxShape.circle,
//                   color: controller.currentIndex.value >= 2
//                       ? theme.primaryColor
//                       : Colors.transparent),
//             ),
//             SizedBox(height: 1.h,),
//             Text("3", style: theme.textTheme.bodyMedium, textScaleFactor: 1.2)
//           ],
//         ),
//         Padding(
//           padding:  EdgeInsets.only(bottom: 3.5.h),
//           child: Container(
//             height: lineHeight ?? 0.8.w,
//             width: lineWidth ?? 22.w,
//             decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 color: controller.currentIndex.value == 2
//                     ? theme.primaryColor
//                     : theme.unselectedWidgetColor),
//           ),
//         ),
//         Column(children: [
//           Container(
//             height: circleWidth ?? 4.w,
//             width: circleWidth ?? 4.w,
//             decoration: BoxDecoration(
//                 border: Border.all(
//                     color: controller.currentIndex.value >= 1
//                         ? Colors.transparent
//                         : theme.unselectedWidgetColor,
//                     width: 1.5),
//                 shape: BoxShape.circle,
//                 color: controller.currentIndex.value >= 1
//                     ? theme.primaryColor
//                     : Colors.transparent),
//           ),SizedBox(height: 1.h,),
//           Text(
//             "2",
//             style: theme.textTheme.bodyMedium,
//             textScaleFactor: 1.2,
//           )
//         ]),
//         Padding(
//           padding:  EdgeInsets.only(bottom: 3.5.h),
//           child: Container(
//             height: lineHeight ?? 0.8.w,
//             width: lineWidth ?? 22.w,
//             decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 color: controller.currentIndex.value >= 1
//                     ? theme.primaryColor
//                     : theme.unselectedWidgetColor),
//           ),
//         ),
//         Column(children: [
//           Container(
//             height: circleWidth ?? 4.w,
//             width: circleWidth ?? 4.w,
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle, color: theme.primaryColor),
//           ),SizedBox(height: 1.h,),
//           Text("1", style: theme.textTheme.bodyMedium, textScaleFactor: 1.2)
//         ])
//       ],
//     );
//   }
// }
