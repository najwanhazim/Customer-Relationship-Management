import 'package:azlistview/azlistview.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:crm/utils/app_theme_constant.dart';
import 'package:crm/utils/app_widget_constant.dart';
import 'package:crm/view/contact/add_contact.dart';
import 'package:crm/view/contact/view_contact.dart';
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
  final List<Map<String, String>> existing = [
    {
      'firstName': 'Muhammad',
      'lastName': 'Naqiudding',
      'company': 'ExSynergy',
      'position': 'Product Manager',
      'phone': '+60192683653',
      'email': 'naiem@exsynergy.com',
      'salutation': 'Mr.',
      'contactType': 'Existing Client',
      'source': 'Email Campaign',
      'notes': 'Active and regular contact.',
    },
    {
      'firstName': 'Ahmad',
      'lastName': 'Yusof',
      'company': 'TechDesigns',
      'position': 'UI/UX Designer',
      'phone': '+60192345678',
      'email': 'ahmad.yusof@techdesigns.com',
      'salutation': 'Mr.',
      'contactType': 'Existing Client',
      'source': 'Referral',
      'notes': 'Provides insightful feedback.',
    },
  ];

  final List<Map<String, String>> potential = [
    {
      'firstName': 'Farah',
      'lastName': 'Hassan',
      'company': 'BrightCorp',
      'position': 'Marketing Manager',
      'phone': '+60124567890',
      'email': 'farah.hassan@brightcorp.com',
      'salutation': 'Ms.',
      'contactType': 'Potential Client',
      'source': 'Trade Show',
      'notes': 'Interested in digital marketing.',
    },
    {
      'firstName': 'Ali',
      'lastName': 'Rahim',
      'company': 'VisionTech',
      'position': 'CTO',
      'phone': '+60123456789',
      'email': 'ali.rahim@visiontech.com',
      'salutation': 'Mr.',
      'contactType': 'Potential Client',
      'source': 'Website Inquiry',
      'notes': 'Discussing a potential partnership.',
    },
  ];

  final List<Map<String, String>> partner = [
    {
      'firstName': 'Sarah',
      'lastName': 'Othman',
      'company': 'EcoPartners',
      'position': 'CEO',
      'phone': '+60133445566',
      'email': 'sarah.othman@ecopartners.com',
      'salutation': 'Ms.',
      'contactType': 'Partner',
      'source': 'Industry Event',
      'notes': 'Collaborating on sustainability projects.',
    },
    {
      'firstName': 'Amir',
      'lastName': 'Hamzah',
      'company': 'FinTech Solutions',
      'position': 'COO',
      'phone': '+60199887766',
      'email': 'amir.hamzah@fintechsolutions.com',
      'salutation': 'Mr.',
      'contactType': 'Partner',
      'source': 'Business Meeting',
      'notes': 'Supports financial integrations.',
    },
  ];

  final List<Map<String, String>> supplier = [
    {
      'firstName': 'Nadia',
      'lastName': 'Yunus',
      'company': 'SupplyCo',
      'position': 'Logistics Manager',
      'phone': '+60188776655',
      'email': 'nadia.yunus@supplyco.com',
      'salutation': 'Ms.',
      'contactType': 'Supplier',
      'source': 'Vendor Directory',
      'notes': 'Manages inventory supply chains.',
    },
    {
      'firstName': 'Zain',
      'lastName': 'Ahmad',
      'company': 'BuildCore',
      'position': 'Procurement Lead',
      'phone': '+60177665544',
      'email': 'zain.ahmad@buildcore.com',
      'salutation': 'Mr.',
      'contactType': 'Supplier',
      'source': 'Industry Referral',
      'notes': 'Provides raw materials.',
    },
  ];

  //-----------------------fill in field--------------
  final List<FormGroup> forms = [
    FormGroup({
      'firstName': FormControl<String>(),
      'lastName': FormControl<String>(),
      'company': FormControl<String>(),
      'position': FormControl<String>(),
    }),
    FormGroup({
      'phoneNumber': FormControl<String>(),
      'email': FormControl<String>(),
    }),
    FormGroup({
      'salutation': FormControl<String>(),
      'contactType': FormControl<String>(),
      'source': FormControl<String>(),
      'remarks': FormControl<String>(),
    }),
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
      String name = item['firstName']!;
      return Contact(
        firstName: item['firstName']!,
        lastName: item['lastName']!,
        company: item['company']!,
        position: item['position']!,
        phone: item['phone']!,
        email: item['email']!,
        salutation: item['salutation']!,
        contactType: item['contactType']!,
        source: item['source'],
        notes: item['notes'],
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
                    addContact(context);
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
            Expanded(child: alphabetScroll(context)),
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

  Widget alphabetScroll(BuildContext context) {
    SuspensionUtil.sortListBySuspensionTag(allContacts);

    return AzListView(
      data: allContacts,
      indexBarOptions:
          IndexBarOptions(textStyle: TextStyle(color: AppTheme.redMaroon)),
      itemCount: allContacts.length,
      itemBuilder: (context, index) {
        final contact = allContacts[index];
        String name = '${contact.firstName} ${contact.lastName}';

        return Column(
          children: [
            ListTile(
              onTap: () {
                viewContact(context, contact);
              },
              leading: CircleAvatar(
                radius: AppTheme.radius30,
                backgroundColor: Colors.blue,
                child: Text(
                  contact.firstName.isNotEmpty
                      ? contact.firstName[0].toUpperCase()
                      : '',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(name),
              subtitle: Text(contact.position),
            ),
            if (index != allContacts.length - 1) const Divider(),
          ],
        );
      },
      indexBarData: SuspensionUtil.getTagIndexList(allContacts),
    );
  }

  Future addContact(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: AppTheme.grey,
      isScrollControlled: true,
      builder: (context) {
        return AddContact(forms: forms);
      },
    );
  }

  Future viewContact(BuildContext context, Contact contact) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        backgroundColor: AppTheme.grey,
        isScrollControlled: true,
        builder: (context) {
          return ViewContact(contact: contact, forms: forms);
        });
  }
}
