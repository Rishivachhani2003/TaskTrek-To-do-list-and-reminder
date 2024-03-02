// // // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/enums/category.dart';
import 'package:to_do_riverpod/services/task_services.dart';
import 'package:to_do_riverpod/view/home_page.dart';
import 'package:to_do_riverpod/widget/textfield_widget.dart';

class NewTask extends StatefulWidget {
  NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  String? _selectedRemind = "5";
  final TextEditingController _reminderController = TextEditingController();
  final List<String> remindList = [
    "5",
    "10",
    "15",
    "20",
  ];

  category _category = category.Learning;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 40,
          left: 25,
          right: 25,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "New Task Todo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black),
                ),
              ),
              Divider(
                thickness: 1.2,
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Title of Task",
                style: AppStyle.headingOne,
              ),
              SizedBox(height: 10),
              TextFieldWidget(
                txtController: _titleController,
                hintText: "Add New Task",
                maxLine: 1,
              ),
              SizedBox(height: 15),
              Text(
                "Description",
                style: AppStyle.headingOne,
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                txtController: _descriptionController,
                hintText: "Add Description",
                maxLine: 3,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Category",
                style: AppStyle.headingOne,
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          activeColor: Colors.green,
                          splashRadius: 1,
                          value: category.Learning,
                          groupValue: _category,
                          onChanged: (value) {
                            setState(() {
                              _category = value!;
                            });
                          },
                        ),
                        Text(
                          "LRN",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: category.Working,
                          activeColor: Colors.blue.shade700,
                          splashRadius: 1,
                          groupValue: _category,
                          onChanged: (value) {
                            setState(() {
                              _category = value!;
                            });
                          },
                        ),
                        Text(
                          "WRK",
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: category.General,
                          activeColor: Colors.amberAccent.shade700,
                          splashRadius: 1,
                          groupValue: _category,
                          onChanged: (value) {
                            setState(() {
                              _category = value!;
                            });
                          },
                        ),
                        Text(
                          "GNR",
                          style: TextStyle(
                            color: Colors.amberAccent.shade700,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Date",
                style: AppStyle.headingOne,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText:
                              DateFormat("dd/MM/yyyy").format(_selectedDate),
                        ),
                        readOnly: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _getDateFromUser(),
                      child: Icon(CupertinoIcons.calendar),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Time",
                          style: AppStyle.headingOne,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: _startTime,
                                  ),
                                  readOnly: true,
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    _getTimeFromUser(isStartTime: true),
                                child: Icon(
                                  CupertinoIcons.clock,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "End Time",
                          style: AppStyle.headingOne,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: _endTime,
                                  ),
                                  readOnly: true,
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    _getTimeFromUser(isStartTime: false),
                                child: Icon(
                                  CupertinoIcons.clock,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Remind",
                style: AppStyle.headingOne,
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  hint: Text(
                    '$_selectedRemind minutes early',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: remindList
                      .map((item) => DropdownMenuItem<String>(
                            value: item + " minutes early",
                            child: Text(
                              item + " minutes early",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRemind = value;
                    });
                  },
                  onSaved: (value) {
                    _selectedRemind = value;
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),

              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   width: MediaQuery.of(context).size.width,
              //   height: 50,
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade200,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              // Expanded(
              //   child: TextField(
              //     decoration: InputDecoration(
              //       enabledBorder: InputBorder.none,
              //       focusedBorder: InputBorder.none,
              //       hintText: "${_selectedRemind} minutes early",
              //     ),
              //     readOnly: true,
              //   ),
              // ),

              // DropdownMenu<String>(
              //   initialSelection: "${_selectedRemind} minutes early",
              //   controller: _reminderController,
              //   requestFocusOnTap: true,
              //   // onSelected: () {
              //   //   setState(() {
              //   //     _selectedRemind = value;
              //   //   });
              //   // },
              //   onSelected: (value) {
              //     setState(() {
              //       _selectedRemind = int.parse(value!);
              //     });
              //   },
              //   dropdownMenuEntries: remindList
              //       .map<DropdownMenuEntry<String>>((int value) {
              //     return DropdownMenuEntry<String>(
              //       value: value.toString(),
              //       label: remindList[value].toString(),
              //       style: MenuItemButton.styleFrom(
              //         foregroundColor: Colors.black,
              //       ),
              //     );
              //   }).toList(),
              // ),
              // DropdownButton(
              //   dropdownColor: Colors.blueGrey,
              //   borderRadius: BorderRadius.circular(10),
              //   items: remindList
              //       .map<DropdownMenuItem<String>>(
              //           (int value) => DropdownMenuItem(
              //               value: value.toString(),
              //               child: Text(
              //                 '$value',
              //                 style: const TextStyle(color: Colors.white),
              //               )))
              //       .toList(),
              //   icon: const Icon(Icons.keyboard_arrow_down,
              //       color: Colors.grey),
              //   iconSize: 32,
              //   elevation: 4,
              //   underline: Container(
              //     height: 0,
              //   ),
              //   style: TextStyle(
              //     color: Colors.black,
              //   ),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _selectedRemind = int.parse(newValue!);
              //     });
              //   },
              // ),
              //       const SizedBox(
              //         width: 6,
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade800,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: Colors.blue.shade800,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue.shade800,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: Colors.blue.shade800,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        String title = _titleController.text;
                        String desc = _descriptionController.text;

                        String category = _category.name;
                        if (title.isEmpty) {
                          Fluttertoast.showToast(msg: "Task Title is Empty");
                        } else if (desc.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Task description is Empty");
                        } else {
                          TaskServices().storeDetailsOfTask(
                              title,
                              desc,
                              category,
                              DateFormat('dd/MM/yyyy')
                                  .format(_selectedDate)
                                  .toString(),
                              _startTime,
                              _endTime);
                          //                                 ref
                          //                                     .read(radioProvider.notifier)
                          //                                     .update((state) => 0);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (c) => MyHomePage()));
                        }
                      },
                      child: Text("Create"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2040));

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    } else {
      Fluttertoast.showToast(msg: "Please select correct date");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );

    String formattedTime = pickedTime!.format(context);

    if (isStartTime) {
      setState(() => _startTime = formattedTime);
    } else if (!isStartTime) {
      setState(() => _endTime = formattedTime);
    } else {
      print('Something went wrong !');
    }
  }
}
