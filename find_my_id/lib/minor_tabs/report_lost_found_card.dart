import 'package:find_my_id/constants/string_resources.dart';
import 'package:find_my_id/decor/palette.dart';
import 'package:find_my_id/decor/text_styles.dart';
import 'package:find_my_id/major_tabs/search_page.dart';
import 'package:find_my_id/routes/routes.dart';
import 'package:flutter/material.dart';

class ReportLostFoundCard extends StatefulWidget {
  final String illustrationFile;
  ReportLostFoundCard(this.illustrationFile, {Key? key}) : super(key: key);

  @override
  State<ReportLostFoundCard> createState() => _ReportLostFoundCardState();
}

class _ReportLostFoundCardState extends State<ReportLostFoundCard> {
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
        _showBottomList(whichGateList);
      },
      child: Card(
        elevation: 1,
        shadowColor: shadowColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          child: Column(
            children: [
              Image.asset(
                'assets/images/' + widget.illustrationFile,
                height: 100,
                width: 100,
              ),
              Text(
                (widget.illustrationFile == lostIllustration)
                    ? reportLostString
                    : reportFoundString,
                style: genTxt.copyWith(
                    fontWeight: FontWeight.bold, color: colorPrimaryVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showBottomList(list) {
    showModalBottomSheet<void>(
      backgroundColor: colorWhiteBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return ListView(
          padding: EdgeInsets.all(8),
          children: list
              .map<Widget>((e) {
                return Container(
                  margin: EdgeInsets.only(top: 8),
                  child: ListTile(
                    tileColor: colorBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Container(
                      child: Text(
                        e,
                        style: genTxt.copyWith(
                          color: colorPrimaryVariant,
                          fontSize: 15,
                        ),
                      ),
                      padding: EdgeInsets.all(7),
                    ),
                    onTap: () {

                      Navigator.popAndPushNamed(
                          context, RouteManager.camScanPage,
                          arguments: e);
                    },
                  ),
                );
              })
              .skip(1)
              .toList(),
        );
      },
    );
  }
}
