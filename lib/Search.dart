import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model.dart';
import 'RecipeView.dart';

class Search extends StatefulWidget {

  String query;
  Search(this.query);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  List<RecipeModel> recipeList = [];

  Future<void> getRecipes(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=ebb6041c&app_key=3c33ad913ab23b8554082bfb5fdd78b5";
    http.Response response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    print(data);

    setState(() {
      recipeList.clear();
      data["hits"].forEach((element) {
        RecipeModel recipeModel = RecipeModel.fromMap(element["recipe"]);

        setState(() {
          isLoading = false;
        });

        recipeList.add(recipeModel);
      });
    });

    recipeList.forEach((Recipe) {
      print(Recipe.appLabel);
      print(Recipe.appcalories);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff213A50), Color(0xff071938)])),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll("", "") ==
                                "") {
                              print("Blank Search");
                            } else {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Let's Cook Something",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: isLoading ? CircularProgressIndicator() : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipeList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeView(recipeList[index].appurl)));
                          },
                          child: Card(
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    recipeList[index].appimageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration:
                                            BoxDecoration(color: Colors.black26),
                                        child: Text(
                                          recipeList[index].appLabel,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20),
                                        ))),
                                Positioned(
                                    right: 0,
                                    width: 80,
                                    height: 40,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            )),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.local_fire_department,
                                                size: 15,
                                                color: Colors.orange,
                                              ),
                                              Text(recipeList[index]
                                                  .appcalories
                                                  .toString()
                                                  .substring(0, 6)),
                                            ],
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
