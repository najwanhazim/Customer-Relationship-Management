import 'package:azlistview/azlistview.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:crm/utils/app_theme_constant.dart';
import 'package:crm/utils/app_widget_constant.dart';
import 'package:crm/view/contact/new_contact.dart';
import 'package:crm/view/dashboard/dashboard_individual.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';

class ContactHomePage extends StatefulWidget {
  const ContactHomePage({super.key});

  @override
  State<ContactHomePage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<ContactHomePage> {
  List<Map<String, String>> existing = [
    {'name': 'Muhammad Naiem Naqiudding', 'role': 'Product Manager'},
    {'name': 'Nuhammad Naiem Naqiudding', 'role': 'Product Manager'},
    {'name': 'Auhammad Naiem Naqiudding', 'role': 'Product Manager'},
    {'name': 'Cuhammad Naiem Naqiudding', 'role': 'Product Manager'},
    {'name': 'quhammad Naiem Naqiudding', 'role': 'Product Manager'},
    {'name': 'wuhammad Naiem Naqiudding', 'role': 'Product Manager'},
    {'name': 'euhammad Naiem Naqiudding', 'role': 'Product Manager'},
    {'name': 'tuhammad Naiem Naqiudding', 'role': 'Product Manager'}
  ];

  List<Map<String, String>> potential = [
    {'name': 'Muhammad Naqiudding', 'role': 'Product'},
    {'name': 'Muhammad Naqiudding', 'role': 'Product'},
    {'name': 'Muhammad Naqiudding', 'role': 'Product'},
    {'name': 'Muhammad Naqiudding', 'role': 'Product'},
    {'name': 'Muhammad Naqiudding', 'role': 'Product'},
    {'name': 'Muhammad Naqiudding', 'role': 'Product'},
  ];

  List<Map<String, String>> partner = [
    {'name': 'Azri', 'role': 'Product Manager'},
    {'name': 'Azri', 'role': 'Product Manager'},
    {'name': 'Azri', 'role': 'Product Manager'},
    {'name': 'Azri', 'role': 'Product Manager'},
    {'name': 'Azri', 'role': 'Product Manager'},
    {'name': 'Azri', 'role': 'Product Manager'},
  ];

  List<Map<String, String>> supplier = [
    {'name': 'Ammar', 'role': 'Product Manager'},
    {'name': 'Ammar', 'role': 'Product Manager'},
    {'name': 'Ammar', 'role': 'Product Manager'},
    {'name': 'Ammar', 'role': 'Product Manager'},
    {'name': 'Ammar', 'role': 'Product Manager'},
    {'name': 'Ammar', 'role': 'Product Manager'},
  ];

  //-----------------------fill in field--------------
  final _form1 = FormGroup({
    'firstName': FormControl<String>(),
    'lastName': FormControl<String>(),
    'company': FormControl<String>(),
    'position': FormControl<String>(),
  });

  final _form2 = FormGroup({
    'phoneNumber': FormControl<String>(),
    'email': FormControl<String>(),
  });

  final _form3 = FormGroup({
    'salutation': FormControl<String>(),
    'contactType ': FormControl<String>(),
    'source': FormControl<String>(),
    'remarks': FormControl<String>(),
  });

  //---------------------label------------------------
  final List<String> label1 = [
    'First Name',
    'Last Name',
    'Company',
    'Position'
  ];
  final List<String> label2 = ['Phone Number', 'Email'];
  final List<String> label3 = [
    'Salutation',
    'Contact Type',
    'Source',
    'Remarks'
  ];

  String search = '';
  int selectedTab = 1;

  List<Contact> allContacts = [];

  @override
  void initState() {
    super.initState();
    updateContactList(); // Initialize contacts based on `selectedTab`.
  }

  void updateContactList() {
    List<Map<String, String>> selectedData;

    switch (selectedTab) {
      case 1:
        selectedData = existing;
        break;
      case 2:
        selectedData = potential;
        break;
      case 3:
        selectedData = partner;
        break;
      case 4:
        selectedData = supplier;
        break;
      default:
        selectedData = [];
    }

    setState(() {
      allContacts = _mapToContacts(selectedData);
    });
  }

  List<Contact> _mapToContacts(List<Map<String, String>> data) {
    return data.map((item) {
      String name = item['name'] ?? '';
      return Contact(
        name: name,
        role: item['role'] ?? '',
        tag: name.isNotEmpty ? name[0].toUpperCase() : '#',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey,
      appBar: appBarPage(context),
      body: Padding(
        padding: AppTheme.padding3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DashboardIndividual();
                    }));
                  },
                  child: Text(
                    'Home',
                    style: TextStyle(color: AppTheme.redMaroon, fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    displayBottomSheet(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return NewContact();
                    // }));
                  },
                  icon: Icon(Icons.add),
                  color: AppTheme.redMaroon,
                  iconSize: 35,
                ),
              ],
            ),
            const Padding(
              padding: AppTheme.padding3,
              child: Text(
                'Contact',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            searchBar(search),
            tab(),
            Expanded(child: alphabetScroll()),
          ],
        ),
      ),
    );
  }

  Widget searchBar(String search) {
    return Padding(
      padding: AppTheme.padding10,
      child: SizedBox(
        height: 40,
        child: TextField(
          onChanged: (value) {
            setState(() {
              search = value;
            });
          },
          decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
    );
  }

  Widget tab() {
    return Container(
      margin: AppTheme.padding10,
      child: CustomSlidingSegmentedControl(
        initialValue: selectedTab,
        children: {
          1: Text(
            'Existing Contact',
            style: TextStyle(
                color: selectedTab == 1 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          2: Text(
            'Potential Client',
            style: TextStyle(
                color: selectedTab == 2 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          3: Text(
            'Partner',
            style: TextStyle(
                color: selectedTab == 3 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          4: Text(
            'Supplier',
            style: TextStyle(
                color: selectedTab == 4 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        },
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
        thumbDecoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        isStretch: true,
        onValueChanged: (value) {
          setState(() {
            selectedTab = value;
          });
          updateContactList();
        },
      ),
    );
  }

  Widget alphabetScroll() {
    SuspensionUtil.sortListBySuspensionTag(allContacts);

    return AzListView(
      data: allContacts,
      indexBarOptions:
          IndexBarOptions(textStyle: TextStyle(color: AppTheme.redMaroon)),
      itemCount: allContacts.length,
      itemBuilder: (context, index) {
        final contact = allContacts[index];

        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: AppTheme.radius30,
                backgroundColor: Colors.blue,
                child: Text(
                  contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(contact.name),
              subtitle: Text(contact.role),
            ),
            if (index != allContacts.length - 1) const Divider(),
          ],
        );
      },
      indexBarData: SuspensionUtil.getTagIndexList(allContacts),
    );
  }

  Future displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: AppTheme.grey,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: AppTheme.usableHeight(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 60, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppTheme.redMaroon,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Text(
                        'New Contact',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: AppTheme.redMaroon,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    body: SingleChildScrollView(
                      child: Container(
                        margin: AppTheme.padding8,
                        child: SafeArea(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: AppTheme.radius50,
                                backgroundColor: Colors.blue,
                              ),
                              // Form sections
                              reactiveForm(_form1, label1),
                              reactiveForm(_form2, label2),
                              reactiveForm(_form3, label3),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

 // Widget listContact(List<Map<String, String>> data) {
  //   return ListView.separated(
  //     itemCount: data.length,
  //     itemBuilder: (context, index) {

  //       String name = data[index]['name']!;
  //       String firstLetter = name.isNotEmpty ? name[0] : '';

  //       return ListTile(
  //         leading: CircleAvatar(
  //           radius: AppTheme.radius30,
  //           backgroundColor: AppTheme.greyPekat,
  //           child: Text(
  //             firstLetter.toUpperCase(),
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         title: Text(data[index]['name']!),
  //         subtitle: Text(data[index]['role']!),
  //       );
  //     },
  //     separatorBuilder: (context, index) => const Divider(),
  //   );
  // }
