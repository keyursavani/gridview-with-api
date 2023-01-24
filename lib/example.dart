import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'blocks.dart';

class GalleryDemo extends StatelessWidget {
  Future<List<Blocks>> blocksfuture = getBlocks();

  static Future<List<Blocks>> getBlocks() async {
    const url = "https://jsonplaceholder.typicode.com/photos?albumId=1";
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<Blocks>(Blocks.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Gallery Example"),
        ),
        body: FutureBuilder<List<Blocks>>(
          future: blocksfuture,
          builder: (context, snapshot) {
            if (snapshot.hasData!) {
              return GridView.builder(
                  itemCount: snapshot.data?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                     childAspectRatio: 2/3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return  Container(
                      padding: const EdgeInsets.only(top: 10,right: 10 , left: 10 , bottom: 10),
                      child: Column(
                        children: [
                          Text('albumId :- ${snapshot.data![index].albumId}'),
                          Text('id :- ${snapshot.data![index].id}'),
                          Text('id :- ${snapshot.data![index].title}'),
                          Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_eoWRpVlgfOGi9fw5kxk1R_O2wDul_ORbFb507lc&s"),
                        ],
                      ),
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return Text("Error");
            }
            return Text("Loading...");
          },
        ),);
  }
}