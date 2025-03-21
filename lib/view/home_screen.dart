import 'package:cargofl_assignment/main.dart';
import 'package:cargofl_assignment/provider/dog_data_provider.dart';
import 'package:cargofl_assignment/utils/compnents/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final dataProvider = Provider.of<DogDataProvider>(context, listen: false);
    dataProvider.getDogData(needLoading: true, context: context);
    dataProvider.scrollController.addListener(() {
      if (dataProvider.scrollController.position.maxScrollExtent ==
          dataProvider.scrollController.offset) {
        dataProvider.getDogData(
          needLoading: false,
          context: context,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            elevation: 0,
            pinned: true,
            expandedHeight: 130.0,
            flexibleSpace: Container(
              child: Column(
                children: [
                  Profile(),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<DogDataProvider>(
                    builder: (ctx, value, child) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            value.category.length,
                            (index) => GestureDetector(
                              onTap: () {
                                String toLower(String val) {
                                  return val.toLowerCase();
                                }

                                value.categoryToggle(
                                    value.category[index]['name']);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: value.defaultCategory ==
                                          value.category[index]['name']
                                      ? Colors.black
                                      : Colors.black.withOpacity(0.1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                  vertical: 8,
                                ),
                                child: Center(
                                  child: Text(
                                    value.category[index]['name'],
                                    style: TextStyle(
                                      color: value.defaultCategory ==
                                              value.category[index]['name']
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ];
      }, body: Consumer<DogDataProvider>(builder: (ctx, provider, child) {
        return provider.isLoading && provider.dogData.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StaggeredGridView.countBuilder(
                controller: provider.scrollController,
                staggeredTileBuilder: (index) =>
                    StaggeredTile.fit(1), //cross axis cell count
                mainAxisSpacing: 8, // vertical spacing between items
                crossAxisSpacing: 8, // horizontal spacing between items
                crossAxisCount: 2, // no. of virtual columns in grid
                itemCount: provider.dogData.length + 1,
                itemBuilder: (context, int index) {
                  if (index < provider.dogData.length) {
                    return CustomCard(
                        img: provider.dogData[index].url.toString(),
                        img2: provider.dogData[index].url.toString(),
                        id: provider.dogData[index].id.toString());
                  } else {
                    return Center(
                        child: provider.isMoreData
                            ? CircularProgressIndicator()
                            : Text(
                                'No More Data',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ));
                  }
                });
      })),
    ));
  }

  ListTile Profile() {
    return ListTile(
      horizontalTitleGap: 5,
      leading: CircleAvatar(
        backgroundColor: Colors.purple,
        radius: 25,
        backgroundImage:
            NetworkImage('https://cdn2.thedogapi.com/images/A09F4c1qP.jpg'),
      ),
      title: Text(
        'Bronny King',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(
        'Airedale Terrier',
        style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
      ),
    );
  }
}
