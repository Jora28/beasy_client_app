import 'package:beasy_client/models/company_model/company.dart';
import 'package:beasy_client/models/company_model/company_stream.dart';
import 'package:beasy_client/models/user_models/user.dart';
import 'package:beasy_client/services/beasyApi.dart';
import 'package:beasy_client/widgets/inpurs.dart';
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
    return Container(
      color: newColor4,
      child: SafeArea(
        child: Scaffold(
          body: _body(),
        ),
      ),
    );
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
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: newColor4),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Good Morning,${user.name}",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Container(
                            child: CustomInput(
                                prefix: Icons.search,
                                hintText: "Search",
                                obscureText: false)),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 140),
                  child: Text("Categories",
                      style: TextStyle(
                        color: newColor4,
                        fontSize: 18,
                      )),
                ),
                Container(
                  height: 250,
                  margin: EdgeInsets.only(top: 180, left: 20, right: 20),
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
                  margin: EdgeInsets.only(left: 30, right: 30, top: 430),
                  child: Text("Companies",
                      style: TextStyle(color: newColor4, fontSize: 18)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 460),
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
