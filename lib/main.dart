import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'blocks.dart';
import 'example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Blocks>> blocksfuture = getBlocks();
  static Future<List<Blocks>> getBlocks() async {
    const url = 'https://jsonplaceholder.typicode.com/photos?albumId=1';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<Blocks>(Blocks.fromJson).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("GridView"),
      ),
      body: Center(
        child: FutureBuilder<List<Blocks>>(
          future: blocksfuture,
          builder: (context , snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.black45,
                  ),
                  SizedBox(height: 30),
                  Text('Loding...',
                  style: TextStyle(
                    fontSize: 20 ,fontWeight: FontWeight.bold
                  ),
                  ),
                ],
              );
            }
            else if(snapshot.hasData){
              final blocks = snapshot.data!;
              return buildblocks(blocks:blocks);
            }
            else if(snapshot.hasError){
              print(snapshot.error);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${snapshot.hasError}'),
                  Text('${snapshot.error}'),
                ],
              );
            }
            else {
              return Text("No User Data!");
            }
          }
        ),
      ),
    );
  }
}

class buildblocks extends StatelessWidget{
  final blocks;
  buildblocks({required this.blocks});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:GridView.builder(
          itemCount: blocks.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 2/3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          // scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final block = blocks[index];
            print('url :-${block.url}');
            return  Container(
              padding: const EdgeInsets.only(top: 10,right: 10 , left: 10 , bottom: 10),
              child: Column(
                children: [
                  // Text('AlbumId :- ${block.albumId}'),
                  // Text('Id :- ${block.id}'),
                  // Text('Title :- ${block.title}'),
                  Image.network("${block.url}"),
                  // Image.network("${block.thumbnailUrl}", height: 50,),
                ],
              ),
            );
          }
      ),
    );
  }
}
