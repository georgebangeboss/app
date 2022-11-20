import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:find_my_id/chopper_api/my_api_services.dart';
import 'package:find_my_id/constants/string_resources.dart';
import 'package:find_my_id/decor/palette.dart';
import 'package:find_my_id/decor/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IDCard extends StatelessWidget {
  final Map<String, dynamic> id;
  const IDCard({Key? key, required Map<String, dynamic> this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              CachedNetworkImage(
                height: 150,
                imageUrl: id["image"],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Gate ${id["location_found"]}",
                        style: genTxt.copyWith(
                          fontSize: 15,
                          color: colorPrimaryVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Builder(builder: (context) {
                      return OutlinedButton(
                        onPressed: () async {
                          //await _updateCardToClaimed(context,id["id"]);
                        },
                        child: Text(claim),
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _updateCardToClaimed(context, int id) async {
    Map<String, String> status = {"status": "C"};
    Response response = await Provider.of<MyApiService>(context, listen: false)
        .updateCardStatus(status: status, id: id);
    Navigator.pop(context);
  }
}
