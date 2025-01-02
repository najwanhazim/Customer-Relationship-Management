import 'package:azlistview/azlistview.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:crm/function/repository/contact_repository.dart';
import 'package:crm/utils/app_theme_constant.dart';
import 'package:crm/utils/app_widget_constant.dart';
import 'package:crm/view/contact/add_contact.dart';
import 'package:crm/view/contact/view_contact.dart';
import 'package:crm/view/dashboard/dashboard_individual.dart';
import 'package:crm/view/meeting_notes/add_meeting_notes.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';

class ContactHomePage extends StatefulWidget {
  const ContactHomePage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<ContactHomePage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<ContactHomePage> {
  //----------------------- fill in field --------------
  final List<FormGroup> contactForms = [
    FormGroup({
      'fullname': FormControl<String>(),
      'position': FormControl<String>(),
    }),
    FormGroup({
      'phoneNumber': FormControl<String>(),
      'email': FormControl<String>(),
    }),
    FormGroup({
      'salutation': FormControl<String>(),
      'contact_type': FormControl<String>(),
      'source': FormControl<String>(),
    }),
  ];

  //-------------- input lead ---------------------
  final List<String> leadLabel = [
    'Portfolio',
    'Leads Title',
    'Value(RM)',
    'Scope',
    'Client',
    'End User',
    'Location(Region)',
    'Contact',
    'Lead Status'
  ];

  final FormGroup leadForms = FormGroup({
    'portfolio': FormControl<String>(),
    'leadsTitle': FormControl<String>(),
    'value': FormControl<String>(),
    'scope': FormControl<String>(),
    'client': FormControl<String>(),
    'endUser': FormControl<String>(),
    'location': FormControl<String>(),
    'contact': FormControl<String>(),
    'leadStatus': FormControl<String>(),
  });

  /// ------------------------------------------ state ------------------------------------------

  String search = '';
  int selectedTab = 1;

  ContactRepository contactRepository = ContactRepository();
  List<Contact> allContacts = [];
  List<Contact> selectedContact = [];

  @override
  void initState() {
    super.initState();
    getContact();
    updateContactList(); // Initialize contacts based on `selectedTab`.
  }

  Future<void> getContact() async {
    try {
      allContacts = await contactRepository.getContactByUserId();
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

  void updateContactList() {
    List<Contact> filteredContacts = [];

    switch (selectedTab) {
      case 1:
        filteredContacts = allContacts
            .where((contact) =>
                (contact.contact_type == "Existing Contact" ||
                    contact.contact_type == "existing contact" ||
                    contact.contact_type == "Existing" ||
                    contact.contact_type == "existing") &&
                contact.fullname.toLowerCase().contains(search.toLowerCase()))
            .toList();
        break;
      case 2:
        filteredContacts = allContacts
            .where((contact) =>
                (contact.contact_type == "Potential Client" ||
                    contact.contact_type == "potential client" ||
                    contact.contact_type == "Potential" ||
                    contact.contact_type == "potential") &&
                contact.fullname.toLowerCase().contains(search.toLowerCase()))
            .toList();
        break;
      case 3:
        filteredContacts = allContacts
            .where((contact) =>
                (contact.contact_type == "Partner" ||
                    contact.contact_type == "partner") &&
                contact.fullname.toLowerCase().contains(search.toLowerCase()))
            .toList();
        break;
      case 4:
        filteredContacts = allContacts
            .where((contact) =>
                (contact.contact_type == "Supplier" ||
                    contact.contact_type == "supplier") &&
                contact.fullname.toLowerCase().contains(search.toLowerCase()))
            .toList();
        break;
      default:
        filteredContacts = [];
    }

    setState(() {
      selectedContact = filteredContacts;
    });
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
            secondAppBar(context, () => addContact(context, contactForms)),
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
            handleSearch();
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

  void handleSearch() {
    if (search.isEmpty) {
      // If search is empty, just update the contact list for the current tab
      updateContactList();
      return;
    }

    // Search for the contact across allContacts
    Contact? foundContact = allContacts.firstWhere(
      (contact) =>
          contact.fullname.toLowerCase().contains(search.toLowerCase()),
      orElse: () => Contact.empty(), // Return null if no contact is found
    );

    if (foundContact != null) {
      // Determine the tab based on contact_type
      int tabToSwitch;
      switch (foundContact.contact_type.toLowerCase()) {
        case "existing contact":
        case "existing":
          tabToSwitch = 1;
          break;
        case "potential client":
        case "potential":
          tabToSwitch = 2;
          break;
        case "partner":
          tabToSwitch = 3;
          break;
        case "supplier":
          tabToSwitch = 4;
          break;
        default:
          tabToSwitch =
              selectedTab; // Stay on the current tab if not categorized
      }

      // Update the selectedTab and selectedContact
      setState(() {
        selectedTab = tabToSwitch;
      });

      // Update contacts in the selected tab
      updateContactList();
    }
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
    SuspensionUtil.sortListBySuspensionTag(selectedContact);

    return AzListView(
      data: selectedContact,
      indexBarOptions:
          IndexBarOptions(textStyle: TextStyle(color: AppTheme.redMaroon)),
      itemCount: selectedContact.length,
      itemBuilder: (context, index) {
        final contact = selectedContact[index];
        String name = '${contact.fullname}';

        return Column(
          children: [
            ListTile(
              onTap: () {
                bottomSheet(
                    context,
                    ViewContact(
                        contact: contact,
                        contactForms: contactForms,
                        // leadForms: leadForms,
                        leadLabel: leadLabel));
              },
              leading: CircleAvatar(
                radius: AppTheme.radius30,
                backgroundColor: Colors.blue,
                child: Text(
                  contact.fullname.isNotEmpty
                      ? contact.fullname[0].toUpperCase()
                      : '',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(name),
              subtitle: Text(contact.position ?? ""),
            ),
            if (index != selectedContact.length - 1) const Divider(),
          ],
        );
      },
      indexBarData: SuspensionUtil.getTagIndexList(selectedContact),
    );
  }

  // Future addContact(BuildContext context, ) {
  //   return showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
  //     ),
  //     backgroundColor: AppTheme.grey,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return AddContact(forms: forms);
  //     },
  //   );
  // }
}
