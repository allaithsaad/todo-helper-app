// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    Key? key,
    required this.massage,
  }) : super(key: key);
  final String massage;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _massage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _massage = widget.massage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          _massage.toString().split('|')[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  'Hello , Laith ',
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : darkGreyClr,
                      fontSize: 26,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'You have , new reminder ',
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : darkGreyClr,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: primaryClr),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.text_format,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Title',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _massage.toString().split('|')[0],
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.description,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _massage.toString().split('|')[1],
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 35,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Date',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _massage.toString().split('|')[2],
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              )),
            )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
