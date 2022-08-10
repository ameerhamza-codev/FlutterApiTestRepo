import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart';
import 'package:redim/constants.dart';
import 'package:redim/shop_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories=['Apparel','Bags & Wallets',"Eye wear"];
  String selectedCategory="All Stores";
  Future<List<ShopModel>> getStores()async{
    List<ShopModel> stores=[];
    var response = await  get(Uri.parse(url));
    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body);
      List<ShopModel> data = List<ShopModel>.from(l.map((model)=> ShopModel.fromJson(model)));
      if(selectedCategory=="All Stores"){
        stores=data;
      }
      else{
        data.forEach((element) {
          print("${element.category!.length}==${selectedCategory.length}");
          if(element.category==selectedCategory){
            stores.add(element);
          }
          });
      }

    } else {
      throw Exception('Failed to load stores');
    }
    return stores;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: <Color>[
              primaryColor,
              secondaryColor,

            ],
            tileMode: TileMode.repeated,
          )
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Redim",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w900,fontStyle: FontStyle.italic),),
                    Row(
                      children: [
                        Icon(Icons.notifications_none,color: Colors.white,),
                        SizedBox(width: 10,),
                        Icon(Icons.search,color: Colors.white,)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                  ),
                  child: Column(
                    children: [

                      Container(
                        margin: EdgeInsets.only(top: 20,bottom: 10,left: 10),
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedCategory=categories[0];
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color:  selectedCategory==categories[0]?greenColor:Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: greenColor,width: 1.5)
                                ),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/shirt.png",height: 20,color:  selectedCategory==categories[0]?Colors.white:greenColor,),
                                    SizedBox(width: 10,),
                                    Text(categories[0],style: TextStyle(color: selectedCategory==categories[0]?Colors.white:greenColor),)
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedCategory=categories[1];
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color:  selectedCategory==categories[1]?blueColor:Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: blueColor,width: 1.5)
                                ),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/bag.png",height: 20,color:  selectedCategory==categories[1]?Colors.white:blueColor,),
                                    SizedBox(width: 10,),
                                    Text(categories[1],style: TextStyle(color: selectedCategory==categories[1]?Colors.white:blueColor),)
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedCategory=categories[2];
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color:  selectedCategory==categories[2]?redColor:Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: redColor,width: 1.5)
                                ),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/goggles.png",height: 20,color:  selectedCategory==categories[2]?Colors.white:redColor,),
                                    SizedBox(width: 10,),
                                    Text(categories[2],style: TextStyle(color: selectedCategory==categories[2]?Colors.white:redColor),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,

                                child: Icon(Icons.search,color: Colors.grey,),
                              ),
                              Expanded(
                                child: TypeAheadField(
                                    textFieldConfiguration: TextFieldConfiguration(

                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 0.5
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0.5,
                                            ),
                                          ),
                                          hintText: "Write Store Name",
                                        )
                                    ),
                                    suggestionsCallback: (pattern) async {
                                      List<ShopModel> suggestion=[];
                                      /*await FirebaseFirestore.instance.collection('users').where("type",isEqualTo: "Personal")
                                            .get().then((QuerySnapshot querySnapshot) {
                                          querySnapshot.docs.forEach((doc) {
                                            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                                            ShopModel model=ShopModel.fromMap(data, doc.reference.id);
                                            if("${model.email}".toLowerCase().contains(pattern.toLowerCase())){
                                              if(!provider.userData!.patients.contains(model.userId)){
                                                suggestion.add(model);
                                              }
                                            }

                                          });
                                        });*/
                                      var response = await  get(Uri.parse(url));
                                      if (response.statusCode == 200) {
                                        Iterable l = jsonDecode(response.body);
                                        List<ShopModel> data=[];
                                        data = List<ShopModel>.from(l.map((model)=> ShopModel.fromJson(model)));
                                        data.forEach((element) {
                                          if("${element.name}".toLowerCase().contains(pattern.toLowerCase())){
                                            suggestion.add(element);
                                          }
                                        });
                                      }
                                      return suggestion;
                                    },
                                    itemBuilder: (context,ShopModel suggestion) {
                                      return ListTile(
                                        leading: Icon(Icons.shopping_cart),
                                        title: Text(suggestion.name!),
                                      );
                                    },

                                    onSuggestionSelected: (ShopModel suggestion) async{
                                      //send invite
                                      /* await FirebaseFirestore.instance.collection('notifications').add({
                                          "userId":suggestion.userId,
                                          "date":DateTime.now().millisecondsSinceEpoch,
                                          "title":"healthcare provider ${provider.userData!.name} has invited you",
                                          "type":"invite",
                                          "taskId":FirebaseAuth.instance.currentUser!.uid,
                                          "isRead":false
                                        });*/
                                    },
                                    errorBuilder: (BuildContext context, error){
                                      return Text('${error.toString()}', style: TextStyle(color: Theme.of(context).errorColor));
                                    }
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedCategory,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedCategory='All Stores';
                                });
                              },
                              child: Row(
                                children: [
                                  Text("All Stores",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: primaryColor),),
                                  Icon(Icons.keyboard_arrow_down,color: primaryColor,)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<List<ShopModel>>(
                            future: getStores(),
                            builder: (context, AsyncSnapshot<List<ShopModel>> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator()
                                );
                              }
                              else {
                                if (snapshot.hasError) {
                                  print("error ${snapshot.error}");
                                  return const Center(
                                    child: Text("Something went wrong"),
                                  );
                                }
                                else if(snapshot.data!.isEmpty){
                                  return const Center(
                                    child: Text("No Store"),
                                  );
                                }

                                else {

                                  return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (BuildContext context, int index){
                                      return Container(
                                        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          children: [
                                            //Image.network(snapshot.data![index].logo!),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: AssetImage("assets/images/placeholder.png"),
                                                  fit: BoxFit.cover
                                                )
                                              ),
                                            ),
                                            SizedBox(width: 15,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data![index].name!,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                                  SizedBox(height: 3),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.star,color: Colors.yellowAccent[700],),
                                                      SizedBox(width: 2),
                                                      Text(snapshot.data![index].rating!.toString(),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300))
                                                    ],
                                                  ),
                                                  SizedBox(height: 2),
                                                  Row(
                                                    children: [
                                                      Text("${snapshot.data![index].discount!.toString()}%",style: TextStyle(fontSize:13,color: primaryColor,fontWeight: FontWeight.w400)),
                                                      Text(" was ${snapshot.data![index].discountWas!.toString()}%",style: TextStyle(fontSize:13,color: Colors.grey,fontWeight: FontWeight.w400))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.keyboard_arrow_right,color: primaryColor,)
                                          ],
                                        ),
                                      );

                                    },
                                  );
                                }
                              }
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          color: Colors.white,
          elevation: 3,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.home_outlined,color: Colors.grey),
                    SizedBox(height: 5,),
                    Text("Home",style: TextStyle(color: Colors.grey,fontSize: 13),)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.store,color: primaryColor),
                    SizedBox(height: 5,),
                    Text("Store",style: TextStyle(color: primaryColor,fontSize: 13),)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.person_outline_rounded,color: Colors.grey),
                    SizedBox(height: 5,),
                    Text("My Account",style: TextStyle(color: Colors.grey,fontSize: 13),)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.menu,color: Colors.grey),
                    SizedBox(height: 5,),
                    Text("Menu",style: TextStyle(color: Colors.grey,fontSize: 13),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
