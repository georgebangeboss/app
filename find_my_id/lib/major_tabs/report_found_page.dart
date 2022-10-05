import 'package:find_my_id/constants/string_resources.dart';
import 'package:flutter/material.dart';

class ReportFoundPage extends StatefulWidget {
  const ReportFoundPage({Key? key}) : super(key: key);

  @override
  State<ReportFoundPage> createState() => _ReportFoundPageState();
}

class _ReportFoundPageState extends State<ReportFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(reportFoundAppBarTitle),
      ),
      body: SizedBox(),
    );
  }
}
