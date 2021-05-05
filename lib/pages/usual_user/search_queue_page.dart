import 'package:beasy_client/models/company_model/company.dart';
import 'package:beasy_client/models/company_model/company_stream.dart';
import 'package:beasy_client/models/user_models/user.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/widgets/inpurs.dart';
import 'package:beasy_client/widgets/sliverbar.dart';
import 'package:beasy_client/widgets/stream_card.dart';
import 'package:flutter/material.dart';

import '../../utils/style_color.dart';

class SearchQueuePage extends StatefulWidget {
  SearchQueuePage({Key key}) : super(key: key);

  @override
  _SearchQueuePageState createState() => _SearchQueuePageState();
}

class _SearchQueuePageState extends State<SearchQueuePage> {
  bool isLaoding = false;
  bool showOnlyFavorite = false;
  bool showAll = true;
  List<Company> allCompanies = [];
  User user = User();
  String _selectedtItem = 'All';
  List<CompanyStream> listStreams = [];
  List<String> category = [
    'All',
    'Sport',
    'Service',
    'Auto',
    'Med',
    'servicen',
  ];

  void getCompanyes() async {
    setState(() {
      isLaoding = true;
    });

    var resUser = await BeasyApi().profileServices.getUserData();

    var res = await BeasyApi().companyServices.getAllCompanyes();
    if (res != null) {
      if (mounted)
        setState(() {
          allCompanies = res;
          user = resUser;
        });
      // for (int i = 0; i < allCompanies.length; i++) {
      //   for(int j = 0;j<allCompanies[i].companyStreams.length;j++){
      //     print(allCompanies[i].companyStreams[j].streamName);
      //   }
      // }
    }
    setState(() {
      isLaoding = false;
    });
  }

  @override
  void initState() {
    getCompanyes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _pinned = true;
    bool _snap = false;
    bool _floating = false;
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
              title: Text(
                "Good Morning,${user.name ?? ""}",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              backgroundColor: newColor4,
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 120.0,
              flexibleSpace: FlexibleSpaceBar(
                background: AppBarSliver(),
              )),
        ];
      },
      body: _body(),
    ));
  }

  selectedItem(cardTitele) {
    setState(() {
      _selectedtItem = cardTitele;
    });
  }

  Widget gridViewCard({String name, String category}) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        selectedItem(name);
      },
      child: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6,
                  child: Image.asset('assets/user_photo.jpg'),
                ),
                Text(
                  category,
                  style: TextStyle(
                      color:
                          _selectedtItem == name ? Colors.white : Colors.black),
                )
              ]),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.3),
            color: _selectedtItem == name ? newColor4 : Colors.white,
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget _body() {
    return isLaoding
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: Text("Categories",
                      style: TextStyle(
                        color: newColor4,
                        fontSize: 18,
                      )),
                ),
                Container(
                  height: 250,
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return gridViewCard(
                          name: category[index], category: category[index]);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 300),
                  child: Text("Companies",
                      style: TextStyle(color: newColor4, fontSize: 18)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 310),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allCompanies.length,
                      itemBuilder: (context, index) {
                        return StreamsCard(
                          company: allCompanies[index],
                        );
                      }),
                )
              ],
            ),
          );
  }
}
