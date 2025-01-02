import 'package:azlistview/azlistview.dart';
import 'package:crm/function/repository/leads_reposiotry.dart';
import 'package:crm/view/leads/view_leads.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';
import '../../db/leads.dart';
import '../../db/user.dart';
import '../../function/repository/contact_repository.dart';
import '../../function/repository/user_repository.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class LeadsHomePage extends StatefulWidget {
  const LeadsHomePage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<LeadsHomePage> createState() => _LeadsHomePageState();
}

class _LeadsHomePageState extends State<LeadsHomePage> {
  //--------------input lead---------------------
  final List<String> leadLabel = [
    'Portfolio',
    'Leads Title',
    'Value(RM)',
    'Scope',
    'Client',
    'End User',
    'Location(Region)',
    'Person In Charge',
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

  //-----------------------fill in field--------------
  final List<FormGroup> contactForms = [
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

  ContactRepository contactRepository = ContactRepository();
  LeadsRepository leadsRepository = LeadsRepository();
  UserRepository userRepository = UserRepository();
  List<User> userList = [];
  List<Leads> allLeads = [];
  List<Contact> contactList = [];
  List<Leads> selectedLeads = [];

  @override
  void initState() {
    super.initState();
    getLeads();
    updateLeadsList();
    getAllContact();
    getAllUser();
  }

  Future<void> getLeads() async {
    try {
      allLeads = await leadsRepository.getLeadsByUserId();
      print("allLeads: $allLeads");
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

  Future<void> getAllContact() async{
    try{
      contactList = await contactRepository.getContactByUserId();
      print("all contact: ${contactList}");
    } catch(e) {
      print(e);
    }
  }

  Future<void> getAllUser() async{
    try{
      userList = await userRepository.getAllUser();
      print("all user: ${userList}");
    } catch(e) {
      print(e);
    }
  }

  void updateLeadsList() {
    List<Leads> filteredLeads = [];

    switch (selectedTab) {
      case 1:
        filteredLeads = allLeads
            .where((leads) =>
                (leads.status == "Prospect" || leads.status == "prospect") &&
                leads.title.toLowerCase().contains(search.toLowerCase()))
            .toList();
        break;
      case 2:
        filteredLeads = allLeads
            .where((leads) =>
                (leads.status == "Opportunity" ||
                    leads.status == "opportunity") &&
                leads.title.toLowerCase().contains(search.toLowerCase()))
            .toList();
        break;
      case 3:
        filteredLeads = allLeads
            .where((leads) =>
                (leads.status == "Sales Won" ||
                    leads.status == "Sales won" ||
                    leads.status == "sales Won" ||
                    leads.status == "sales won") &&
                leads.title.toLowerCase().contains(search.toLowerCase()))
            .toList();
        break;
      case 4:
        filteredLeads = allLeads
            .where((leads) =>
                (leads.status == "Sales Lost" ||
                    leads.status == "Sales lost" ||
                    leads.status == "sales Lost" ||
                    leads.status == "sales lost") &&
                leads.title.toLowerCase().contains(search.toLowerCase()))
            .toList();
        break;
      case 5:
        filteredLeads = allLeads
            .where((leads) =>
                (leads.status == "Disqualified" ||
                    leads.status == "disqualified") &&
                leads.title.toLowerCase().contains(search.toLowerCase()))
            .toList();
        break;
      default:
        filteredLeads = [];
    }

    setState(() {
      selectedLeads = filteredLeads;
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
            secondAppBar(
                context,
                () => addLeads(
                    context, contactForms, contactList, userList, leadLabel)),
            const Padding(
              padding: AppTheme.padding3,
              child: Text(
                'Leads',
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
          1: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Prospect',
              style: TextStyle(
                color: selectedTab == 1 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          2: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Opportunity',
              style: TextStyle(
                color: selectedTab == 2 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          3: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Sales Won',
              style: TextStyle(
                color: selectedTab == 3 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          4: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Sales Lost',
              style: TextStyle(
                color: selectedTab == 4 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          5: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Disqualified',
              style: TextStyle(
                color: selectedTab == 5 ? AppTheme.redMaroon : Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        },
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
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
          updateLeadsList();
        },
      ),
    );
  }

  Widget alphabetScroll(BuildContext context) {
    SuspensionUtil.sortListBySuspensionTag(allLeads);

    return AzListView(
      data: selectedLeads,
      indexBarOptions:
          IndexBarOptions(textStyle: TextStyle(color: AppTheme.redMaroon)),
      itemCount: selectedLeads.length,
      itemBuilder: (context, index) {
        final lead = selectedLeads[index];

        return Column(
          children: [
            ListTile(
              onTap: () {
                bottomSheet(
                    context,
                    ViewLeads(
                      allLeads: allLeads,
                      lead: lead,
                      allContacts: contactList,
                      allUsers: userList,
                      contactForms: contactForms,
                      // leadForms: leadForms,
                      leadLabel: leadLabel,
                    ));
              },
              title: Text(
                lead.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lead.portfolio),
                  Text('${lead.client} - ${lead.end_user}')
                ],
              ),
              isThreeLine: true,
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'RM ${lead.value}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    lead.status,
                    style: TextStyle(
                      color: lead.status == 'Prospect'
                          ? Colors.green
                          : lead.status == 'Opportunity'
                              ? Colors.blue
                              : lead.status == 'Sales Won'
                                  ? Colors.purple
                                  : lead.status == 'Sales Lost'
                                      ? Colors.red
                                      : Colors.black,
                    ),
                  )
                ],
              ),
            ),
            if (index != selectedLeads.length - 1) const Divider(),
          ],
        );
      },
      indexBarData: SuspensionUtil.getTagIndexList(selectedLeads),
    );
  }
}
