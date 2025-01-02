import 'package:crm/function/repository/contact_repository.dart';
import 'package:crm/utils/app_string_constant.dart';
import 'package:crm/view/action/add_following_action.dart';
import 'package:crm/view/contact/edit_contact.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../db/contact.dart';
import '../../db/leads.dart';
import '../../db/meeting.dart';
import '../../db/task_action_with_user.dart';
import '../../db/user.dart';
import '../../function/repository/leads_reposiotry.dart';
import '../../function/repository/meeting_repository.dart';
import '../../function/repository/task_action_repository.dart';
import '../../function/repository/user_repository.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';
import '../meeting_notes/add_meeting_notes.dart';

class ViewContact extends StatefulWidget {
  const ViewContact(
      {Key? key,
      required this.contact,
      required this.contactForms,
      // required this.leadForms,
      required this.leadLabel})
      : super(key: key);

  final Contact contact;
  final List<FormGroup> contactForms;
  // final FormGroup leadForms;
  final List<String> leadLabel;

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {

  List<MeetingNote> meetingList = [];
  MeetingRepository meetingRepository = MeetingRepository();
  List<TaskActionWithUser> taskList = [];
  TaskActionRepository taskActionRepository = TaskActionRepository();
  List<User> userList = [];
  UserRepository userRepository = UserRepository();
  List<Contact> contactList = [];
  ContactRepository contactRepository = ContactRepository();
  List<Leads> leadsList = [];
  LeadsRepository leadsRepository = LeadsRepository();

  @override
  void initState() {
    super.initState();
    getMeeting();
    getFollowUpAction();
    getAllUser();
    gettAllContact();
    getAllLead();
  }

  Future<void> getMeeting() async {
    try {
      meetingList = await meetingRepository.getMeetingList(widget.contact.id!);
      print("all meeting: ${meetingList}");
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

  Future<void> getFollowUpAction() async {
    try {
      taskList = await taskActionRepository.getTaskActionByContact(widget.contact.id!);
      print("all task: ${taskList}");
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
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

  Future<void> gettAllContact() async{
    try{
      contactList = await contactRepository.getContactByUserId();
      print("all contact: ${contactList}");
    } catch(e) {
      print(e);
    }
  }

  Future<void> getAllLead() async{
    try{
      leadsList = await leadsRepository.getLeadsByUserId();
      print("Leads: ${leadsList}");
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.grey,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: SizedBox(
          height: 750,
          child: Column(
            children: [
              Container(
                decoration: AppTheme.bottomSheet,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    backButton(context),
                    pageTitle(
                        '${widget.contact.salutation} ${widget.contact.fullname}'),
                    editButton(
                        context,
                        EditContact(
                            contact: widget.contact,
                            forms: widget.contactForms))
                  ],
                ),
              ),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Container(
                      margin: AppTheme.padding10,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30),
                                      bottom: Radius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    '${widget.contact.contact_type}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            // Profile Section
                            CircleAvatar(
                              radius: AppTheme.radius50,
                              backgroundColor: Colors.blue,
                            ),
                            AppTheme.box20,
                            displayInField(
                              context,
                              widget.contact.position,
                            ),
                            displayInField(
                              context,
                              widget.contact.phone_no,
                            ),
                            displayInField(
                              context,
                              widget.contact.email,
                            ),
                            displayInField(
                              context,
                              widget.contact.source,
                            ),
                            AppTheme.box10,
                            // Meeting Header Section
                            meetingHeader(() {
                              bottomSheet(
                                  context,
                                  AddMeetingNotes(
                                    taskList: taskList,
                                    allContacts: contactList,
                                    allUser: userList,
                                    allLeads: leadsList,
                                    contactForms: widget.contactForms,
                                    // leadForms: widget.leadForms,
                                    leadLabel: widget.leadLabel,
                                  ));
                            }),
                            // Meeting History Section
                            Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: meetingHistory(
                                  context,
                                  meetingList,
                                  contactList,
                                  userList,
                                  widget.contactForms,
                                  // widget.leadForms,
                                  widget.leadLabel),
                            ),
                            // Follow Up Header
                            followUpHeader(() => bottomSheet(
                                  context,
                                  AddFollowingAction(
                                    allContact: contactList,
                                    allUser: userList,
                                    allLeads: leadsList,
                                    contactForms: widget.contactForms,
                                    // leadForms: widget.leadForms,
                                    leadLabel: widget.leadLabel,
                                  ),
                                )),
                            // Follow Up Action Section
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 700,
                              child: followUpAction(
                                  context,
                                  taskList,
                                  contactList,
                                  userList,
                                  widget.contactForms,
                                  // widget.leadForms,
                                  widget.leadLabel
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future editContact(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
  //     ),
  //     backgroundColor: AppTheme.grey,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return EditContact(contact: widget.contact, forms: widget.forms);
  //     },
  //   );
  // }

  // Future addMeeting(
  //     BuildContext context, Contact contact, List<FormGroup> forms) {
  //   return showModalBottomSheet(
  //       context: context,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
  //       ),
  //       backgroundColor: AppTheme.grey,
  //       isScrollControlled: true,
  //       builder: (context) {
  //         return AddMeetingNotes(contact: contact, forms: forms);
  //       });
  // }
}
