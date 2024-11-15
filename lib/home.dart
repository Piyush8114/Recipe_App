import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/RecipeView.dart';
import 'package:recipe/Search.dart';
import 'Model.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  List<RecipeModel> recipeList = [];
  List reciptCatList = [
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "continental"
    },
    {
      "imgUrl": "https://images.everydayhealth.com/images/diet-nutrition/what-is-a-vegan-diet-benefits-food-list-beginners-guide-alt-1440x810.jpg?sfvrsn=1d260c85_1",
      "heading": "vegetarian"
    },
    {
      "imgUrl": "https://st3.depositphotos.com/4353155/16386/i/450/depositphotos_163864984-stock-photo-pilaf-traditional-asian-dish-rice.jpg",
      "heading": "Indian Food"
    },
    {
      "imgUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2OjdHcB3qhbRcAJ7FzrpdouYZxeXVlrUn_tygUBiiMNLwAdya5AqmvgVLC2W5L4cuUvs&usqp=CAU",
      "heading": "Asian Food"
    },
    {
      "imgUrl": "https://www.healthaid.co.uk/cdn/shop/articles/Most_Healthy_Food_Choices_for_Daily_Consumption.jpg?v=1640121333&width=480",
      "heading": "Healthy Food"
    },

  ];

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
    getRecipes("chicken");
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
                            if ((searchController.text).replaceAll("", "") == "") {
                              print("Blank Search");
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WHAT DO YOU WANT TO COOK TODAY?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Let's Cook Somethings New!",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
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

                  Container(
                    height: 180,
                    child: ListView.builder(
                        itemCount: reciptCatList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Search(reciptCatList[index]["heading"], )));
                            },
                            child: Card(
                                margin: EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        child: Image.network(
                                          reciptCatList[index]["imgUrl"],
                                          fit: BoxFit.cover,
                                          width: 200,
                                          height: 250,
                                        )),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.black26),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  reciptCatList[index]
                                                      ["heading"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 28),
                                                ),
                                              ],
                                            ))),
                                  ],
                                )),
                          ));
                        }),
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
