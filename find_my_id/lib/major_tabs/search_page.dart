import 'package:find_my_id/constants/string_resources.dart';
import 'package:find_my_id/decor/input_decorations.dart';
import 'package:find_my_id/decor/palette.dart';
import 'package:find_my_id/decor/text_styles.dart';
import 'package:find_my_id/minor_tabs/id_card.dart';
import 'package:find_my_id/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../chopper_api/my_api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

var whichCollegeList = [
  "College",
  "COETEC",
  "COHRED",
  "COPAS",
  "COHES",
  "COANRE",
  "COHES",
  "SABS",
];
var whichGateList = [
  "Gate",
  "Gate A",
  "Gate B",
  "Gate C",
  "Gate D",
];

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;

  late String _whichCollege, _whichGate;

  bool _isCollegeFilterPressed = false;
  bool _isGateFilterPressed = false;
  bool _isSearched = false;
  String? _searchedText;

  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  int _page = 0;
  bool _hasNextPage = true;

  late ScrollController _scrollController;

  List<Map<String, dynamic>> _ids = [];

  @override
  void initState() {
    searchController = TextEditingController();
    _whichCollege = whichCollegeList.first;
    _whichGate = whichGateList.first;
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(searchAppBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              textInputAction: TextInputAction.search,
              controller: searchController,
              decoration: inputDecor.copyWith(
                hintText: searchBarText,
                hintStyle: genTxt.copyWith(
                  color: colorPrimaryVariant,
                  fontSize: 15,
                ),
              ),
              onSubmitted: (searchText) async {
                _ids = [];
                _searchedText = searchText;

                await _firstLoad();
              },
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  _buildChip(collegeFilterCategory),
                  _buildChip(gateFilterCategory),
                  ActionChip(
                    label: Text(
                      resetChipLabel,
                      style: genTxt.copyWith(
                        color: colorPrimaryVariant,
                        fontSize: 13,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                        _searchedText = null;
                        _whichCollege = whichCollegeList.first;
                        _whichGate = whichGateList.first;
                        _isCollegeFilterPressed = false;
                        _isGateFilterPressed = false;
                      });
                    },
                    avatar: Icon(
                      Icons.refresh,
                      color: colorPrimaryVariant,
                    ),
                  ),
                ],
              ),
            ),
            !_isSearched
                ? Container(
                    child: Expanded(
                      child: Image.asset(
                          "assets/images/search_page_illustration.jpg"),
                    ),
                  )
                : _isFirstLoadRunning
                    ? Expanded(
                        child: Center(
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : Expanded(
                      child: ListView.builder(
                        itemCount: _ids.length,
                        controller: _scrollController,
                        itemBuilder: (_, index) => IDCard(
                          id: _ids[index],
                        ),
                      ),
                    )
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String filterCategory) {
    return ActionChip(
      label: Row(
        children: [
          Text(
            filterCategory == gateFilterCategory ? _whichGate : _whichCollege,
            style: genTxt.copyWith(
              color: colorPrimaryVariant,
              fontSize: 13,
            ),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
      onPressed: () {
        if (filterCategory == gateFilterCategory) {
          _showBottomList(filterCategory, whichGateList);
        } else if (filterCategory == collegeFilterCategory) {
          _showBottomList(filterCategory, whichCollegeList);
        }
      },
    );
  }

  _showBottomList(String filterCategory, list) {
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
                      if (filterCategory == gateFilterCategory) {
                        setState(() {
                          _whichGate = e;
                          _isGateFilterPressed = true;
                        });
                      } else if (filterCategory == collegeFilterCategory) {
                        setState(() {
                          _whichCollege = e;
                          _isCollegeFilterPressed = true;
                        });
                      }
                      Navigator.pop(context);
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

  String _searchFilterString() {
    String slug = "?status=L";
    if (_isCollegeFilterPressed ||
        _isGateFilterPressed ||
        _searchedText != null) {
      slug += "&";
    }
    if (_searchedText != null&&_searchedText !="") {
      slug += "search=$_searchedText";
      if (_isCollegeFilterPressed || _isGateFilterPressed) {
        slug += "&";
      }
    }
    if (_isCollegeFilterPressed) {
      //slug += "college_name=${_whichCollege}";
      if (_isGateFilterPressed) {
        //slug += "&";
      }
    }
    if (_isGateFilterPressed) {
      slug += "location_found=";
      slug += _whichGate[(_whichGate.length - 1)];
    }
    print("GGGGGGGGGGG $slug");
    return slug;
  }

  Future<void> _firstLoad() async {
    setState(() {
      _isSearched = true;
      _isFirstLoadRunning = true;
    });

  

    final response = await Provider.of<MyApiService>(context, listen: false)
        .getCards(searchFilterString: _searchFilterString());

    if (response.isSuccessful) {
      final body = response.body;
      List cards = body["results"];
      if (cards.isNotEmpty) {
        _ids.addAll(_decodeJSONToList(cards));
      } else {
        createSnackBar(context: context, text: no_match_report);
      }
    } else {
      createSnackBar(context: context, text: unsuccessful_request);
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page += 1; // Increase _page by 1

      final response = await Provider.of<MyApiService>(context, listen: false)
          .getCards(
              searchFilterString: "${_searchFilterString()}&page=${_page}");

      if (response.isSuccessful) {
        final body = response.body;
        if (body["next"] == null) {
          setState(() {
            _hasNextPage = false;
          });
        }
        setState(() {
          List cards = body["results"];
          _ids.addAll(_decodeJSONToList(cards));
        });
      } else {
        createSnackBar(context: context, text: unsuccessful_request);
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  List<Map<String, dynamic>> _decodeJSONToList(body) {
    List<Map<String, dynamic>> ids = [];
    for (var card in body) {
      Map<String, dynamic> id = {};
      id["id"] = card["id"];
      id["image"] = card["image"];
      id["location_found"] = card["location_found"];
      ids.add(id);
    }
    return ids;
  }
}
