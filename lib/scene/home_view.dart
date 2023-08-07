import 'dart:convert';

import 'package:bmms/custom/common_ui.dart';
import 'package:bmms/model/category.dart';
import 'package:bmms/model/globals.dart';
import 'package:bmms/scene/main_drawer.dart';
import 'package:bmms/scene/visit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/appapi.dart';
import '../api/request.dart';
import '../constants/message.dart' as msg;
import '../constants/color.dart' as color;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Data> categoryList = [];
  //List<SubCategory> subcategoryList = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> loadCategoryList() async {
   // Dialogs.progressDialog(context);
    String urlString = AppApi.categoryurl;
    var response = await Request.getMethodCall(context, urlString, {});
    //Navigator.of(context).pop();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var nResponse = jsonDecode(response.body);
      Categories categories = Categories.fromJson(nResponse);
      categoryList.clear();
      categories.data!.forEach((element) {
        if(element.parentId == null){
          categoryList.add(element);
        }
      });

     // categoryList = categories.data!;
      // subcategoryList = categories.data![1].subCategory??[];
      //
      // print('subcatName '+subcategoryList[0].name.toString());
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    checkVerify();

    loadCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.scafColor.withOpacity(0.5),
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(msg.HOME_TEXT),
        centerTitle: true,
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: (){

              },
              // =>
              //     Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (_) =>  GlobalSearchMineralListView(categoryList:categoryList,categoryName: '',categoryId: 1,))),
              icon: const Icon(Icons.search,size: 30,)
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: buildCtn(),
    );
  }

  Widget buildCtn() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GridView.builder(
      itemCount: categoryList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        Data data = categoryList[index];

        print(AppApi.baseurl + data.image!);

        return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
                onTap: () {
                  if (mounted) {



                    // if(data.subCategory!.length >0){
                    //
                    //
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //         SubCatPage(
                    //           categoryList:data.subCategory??[],
                    //           categoryId: data.id!,
                    //           categoryName: data.name!,
                    //         )
                    //     ),
                    //   );
                    // }else{
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //         MineralListView(
                    //           categoryId: data.id!,
                    //           categoryName: data.name!,
                    //         )
                    //     ),
                    //   );
                    // }


                  }
                },
                child: Center(
                  child: Column(
                    children: [
                      Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          elevation: 1,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              AppApi.baseurl + data.image!,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            data.name!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                )));
      },
    );
  }

  Future<void> checkVerify() async {
    final prefs = await SharedPreferences.getInstance();
   bool? isverify =  prefs.getBool('isEmailVerified');
    if(isverify != null ){
      if(!isverify){
        Global.token = '';
      }
    }

  }
}
