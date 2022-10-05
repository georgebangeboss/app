import 'package:find_my_id/constants/string_resources.dart';
import 'package:flutter/material.dart';

class ReportLostPage extends StatefulWidget {
  const ReportLostPage({Key? key}) : super(key: key);

  @override
  State<ReportLostPage> createState() => _ReportLostPageState();
}

class _ReportLostPageState extends State<ReportLostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(reportLostAppBarTitle),
      ),
      body: SizedBox(),
    );
  }
}
