// import 'package:crm/utils/app_widget_constant.dart';
// import 'package:crm/view/login/login.dart';
// import 'package:flutter/material.dart';

// import '../../utils/app_theme_constant.dart';

// class SignUp2 extends StatefulWidget {
//   const SignUp2({Key? key, required this.title, required this.subtitle, required this.iconText, this.isShow = false}) : super(key: key);
  
//   final String title;
//   final String subtitle;
//   final String iconText;
//   final bool isShow;

//   @override
//   State<SignUp2> createState() => _SignUp2State();
// }

// class _SignUp2State extends State<SignUp2> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.grey,
//       appBar: AppBar(
//         backgroundColor: AppTheme.redMaroon,
//         elevation: 0.0,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(0),
//             child: widget.isShow ? backButton(context) : null,
//           ),
//           Center(
//             heightFactor: 2,
//             child: Padding(
//               padding: AppTheme.padding20,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.title,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
//                   ),
//                   Text(widget.subtitle),
//                   Padding(
//                     padding: AppTheme.padding10,
//                     child: widget.isShow ? inputField('Email Address') : null,
//                   ),
//                   Padding(
//                     padding: AppTheme.padding8,
//                     child: Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment.end, 
//                       children: [
//                         FilledButton(
//                           onPressed: () {
//                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(Colors.black),
//                             shape: MaterialStateProperty.all(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(widget.iconText),
//                               const SizedBox(width: 8),
//                               const Icon(Icons.arrow_forward),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
