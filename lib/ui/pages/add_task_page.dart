import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/models/task.dart';
import '/ui/theme.dart';
import '/ui/widgets/button.dart';
import '/ui/widgets/input_field.dart';
import '/controllers/task_controller.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  int _selectedColor = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daliy', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              'Add Task',
              style: headingStyle,
            ),
            InputField(
              title: 'Title',
              hint: 'Enter Somthing',
              controller: _titleController,
            ),
            InputField(
              title: 'Note',
              hint: 'Enter note here',
              controller: _noteController,
            ),
            InputField(
              title: 'Date',
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                onPressed: () => _getDateFromUser(),
                icon: Icon(
                  Icons.calendar_today_outlined,
                ),
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    title: 'Start Time',
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: () => _getTimeFromUser(isStartTime: true),
                      icon: Icon(
                        Icons.access_time_rounded,
                      ),
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputField(
                    title: 'End Time',
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: () => _getTimeFromUser(isStartTime: false),
                      icon: Icon(
                        Icons.access_time_rounded,
                      ),
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
            InputField(
              title: 'Remind',
              hint: '$_selectedRemind minutes early',
              widget: Row(
                children: [
                  DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: remindList
                          .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem(
                                  value: value.toString(),
                                  child: Text(
                                    '$value',
                                    style: TextStyle(color: Colors.white),
                                  )))
                          .toList(),
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      style: subTitleStyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      }),
                  SizedBox(
                    width: 6,
                  )
                ],
              ),
            ),
            InputField(
              title: 'Repeat',
              hint: _selectedRepeat,
              widget: Row(
                children: [
                  DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: repeatList
                          .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  )))
                          .toList(),
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      style: subTitleStyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      }),
                  SizedBox(
                    width: 6,
                  )
                ],
              ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _colorPalette(),
                MyButton(label: 'Create Taske', onTap: () => _validateDate())
              ],
            )
          ]),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: primaryClr,
          ),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 18,
          ),
          SizedBox(
            width: 20,
          )
        ],
      );

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasksToDB();
      Get.back();
    } else {
      Get.snackbar('required', 'All fields are required',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: Icon(Icons.warning_amber_rounded));
    }
  }

  _addTasksToDB() async {
    int value = await _taskController.addTask(
        task: Task(
            title: _titleController.text,
            note: _noteController.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            color: _selectedColor,
            remind: _selectedRemind,
            repeat: _selectedRepeat));

    print(value);
    _taskController.getTasks();
  }

  Column _colorPalette() {
    return Column(
      children: [
        Text('Color'),
        SizedBox(height: 8),
        Wrap(
          children: List.generate(
              3,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CircleAvatar(
                        child: _selectedColor == index
                            ? Icon(
                                Icons.done,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                        backgroundColor: index == 0
                            ? primaryClr
                            : index == 1
                                ? pinkClr
                                : orangeClr,
                        radius: 14,
                      ),
                    ),
                  )),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 1000)),
        initialEntryMode: DatePickerEntryMode.input);
    if (_pickedDate != null)
      setState(() => _selectedDate = _pickedDate);
    else
      print('Rong Date ');
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 15))),
    );
    if (_pickedTime != null)
      setState(() => isStartTime
          ? _startTime = _pickedTime.format(context)
          : _endTime = _pickedTime.format(context));
    else
      print('Rong Time ');
  }
}
