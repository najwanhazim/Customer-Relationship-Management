import 'package:azlistview/azlistview.dart';
import 'package:crm/view/leads/view_leads.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';
import '../../db/leads.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import '../dashboard/dashboard_individual.dart';

class LeadsHomePage extends StatefulWidget {
  const LeadsHomePage({super.key});

  @override
  State<LeadsHomePage> createState() => _LeadsHomePageState();
}

class _LeadsHomePageState extends State<LeadsHomePage> {
  //--------------------leads--------------------------------
  final List<Map<String, dynamic>> prospect = [
    {
      'id': 'L001',
      'portfolio': 'Commercial Projects',
      'title': 'High-Rise Office Construction',
      'scope': 'Structural Engineering',
      'client': 'UrbanConstruct Inc.',
      'end_user': 'Corporate Tenants',
      'location': 'Kuala Lumpur',
      'status': 'Prospect',
      'contact_id': 'C001',
      'value': 5000000.00,
      'created_by': 'John Smith',
    },
    {
      'id': 'L001',
      'portfolio': 'Commercial Projects',
      'title': 'High-Rise Office Construction',
      'scope': 'Structural Engineering',
      'client': 'UrbanConstruct Inc.',
      'end_user': 'Corporate Tenants',
      'location': 'Kuala Lumpur',
      'status': 'Prospect',
      'contact_id': 'C001',
      'value': 5000000.00,
      'created_by': 'John Smith',
    },
  ];

  final List<Map<String, dynamic>> opportunity = [
    {
      'id': 'L002',
      'portfolio': 'Residential Projects',
      'title': 'Luxury Condo Development',
      'scope': 'Architectural Design',
      'client': 'DreamHomes Ltd.',
      'end_user': 'Individual Buyers',
      'location': 'Penang',
      'status': 'Opportunity',
      'contact_id': 'C002',
      'value': 3500000.00,
      'created_by': 'Alice Tan',
    },
  ];

  final List<Map<String, dynamic>> won = [
    {
      'id': 'L003',
      'portfolio': 'Industrial Projects',
      'title': 'Warehouse Expansion',
      'scope': 'Mechanical Engineering',
      'client': 'LogiTech Corp.',
      'end_user': 'Retail Chains',
      'location': 'Johor Bahru',
      'status': 'Sales Won',
      'contact_id': 'C003',
      'value': 1200000.00,
      'created_by': 'Ravi Kumar',
    },
  ];

  final List<Map<String, dynamic>> lost = [
    {
      'id': 'L004',
      'portfolio': 'Government Projects',
      'title': 'Public School Renovation',
      'scope': 'Electrical Systems',
      'client': 'Ministry of Education',
      'end_user': 'School Students',
      'location': 'Putrajaya',
      'status': 'Sales Lost',
      'contact_id': 'C004',
      'value': 800000.00,
      'created_by': 'Maria Lee',
    },
  ];

  final List<Map<String, dynamic>> disqualified = [
    {
      'id': 'L005',
      'portfolio': 'Retail Projects',
      'title': 'Shopping Mall Revamp',
      'scope': 'Interior Design',
      'client': 'MallCorp',
      'end_user': 'Shoppers',
      'location': 'Selangor',
      'status': 'Disqualified',
      'contact_id': 'C005',
      'value': 1500000.00,
      'created_by': 'David Lim',
    },
  ];

  //--------------input lead---------------------
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

  //-------------------------name--------------------------
  final List<String> allContact = [
    'Ammar',
    'Azri',
    'Naiem',
    'Din',
    'Najwan',
  ];

  final List<String> allTeam = [
    'Wan',
    'Raimy',
    'Sai',
    'Syahmi',
    'Amir',
  ];

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

  List<Leads> allLeads = [];

  @override
  void initState() {
    super.initState();
    updateLeadsList(); // Initialize contacts based on `selectedTab`.
  }

  void updateLeadsList() {
    List<Map<String, dynamic>> selectedData;

    switch (selectedTab) {
      case 1:
        selectedData = prospect;
        break;
      case 2:
        selectedData = opportunity;
        break;
      case 3:
        selectedData = won;
        break;
      case 4:
        selectedData = lost;
        break;
      case 5:
        selectedData = disqualified;
        break;
      default:
        selectedData = [];
    }

    setState(() {
      allLeads = _mapToLeads(selectedData);
    });
  }

  List<Leads> _mapToLeads(List<Map<String, dynamic>> data) {
    return data.map((item) {
      String title = item['title']!;
      return Leads(
        id: item['id'],
        portfolio: item['portfolio'],
        title: item['title'],
        scope: item['scope'],
        client: item['client'],
        end_user: item['end_user'],
        location: item['location'],
        status: item['status'],
        contact_id: item['contact_id'],
        value: item['value'],
        created_by: item['created_by'],
        tag: title.isNotEmpty ? title[0].toUpperCase() : '#',
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
            secondAppBar(
                context,
                () => addLeads(
                    context, contactForms, allContact, leadLabel, leadForms)),
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
      data: allLeads,
      indexBarOptions:
          IndexBarOptions(textStyle: TextStyle(color: AppTheme.redMaroon)),
      itemCount: allLeads.length,
      itemBuilder: (context, index) {
        final lead = allLeads[index];

        return Column(
          children: [
            ListTile(
              onTap: () {
                bottomSheet(
                    context,
                    ViewLeads(
                      lead: lead,
                      allContact: allContact,
                      allTeam: allTeam,
                      contactForms: contactForms,
                      leadForms: leadForms,
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
            if (index != allLeads.length - 1) const Divider(),
          ],
        );
      },
      indexBarData: SuspensionUtil.getTagIndexList(allLeads),
    );
  }
}
