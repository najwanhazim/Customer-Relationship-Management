import 'package:flutter/material.dart';

import '../../utils/app_theme_constant.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

// return DraggableScrollableSheet(
//       expand: false,
//       initialChildSize: 0.9,
//       minChildSize: 0.3,
//       maxChildSize: 0.9,
//       builder: (context, scrollController) {
//         return SingleChildScrollView(
//           controller: scrollController,
//           child: Column(
//             children: [
//               AppBar(
//                 backgroundColor: AppTheme.grey,
//                 automaticallyImplyLeading: false, 
//                 leading: TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(color: AppTheme.redMaroon, fontSize: 18),
//                   ),
//                 ),
//                 title: const Text(
//                   'New Contact',
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'New Contact Form or Content Goes Here',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//               // Add your form or additional widgets here
//             ],
//           ),
//         );
//       },
//     );


// return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppTheme.grey,
//         elevation: 0.0,
//         leading: TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           style: TextButton.styleFrom(
//             padding: EdgeInsets.zero,
//             minimumSize: const Size(0, 0),
//             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           ),
//           child: Text(
//             'Cancel',
//             style: TextStyle(color: AppTheme.redMaroon, fontSize: 18),
//           ),
//         ),
//         title: const Center(
//           child: Text(
//             'New Contact',
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//         ),
//       ),
//     );
