import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'postss.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  getPost() async {
    List<Postss> listposts = [];
    var Url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.get(Url);
    var responsebody = jsonDecode(response.body);
    listposts.add(responsebody);
    for (var i in responsebody)
      listposts.add(Postss(i["userId"], i["id"], i["title"], i["body"]));

    return listposts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("posts"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getPost(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return (snapshot.hasData)? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text("${snapshot.data[index].id}"),
                  title: Text("${snapshot.data[index].title}"),
                  subtitle: Text("${snapshot.data[index].body}"),
                );
              },
            ):Center(child: CircularProgressIndicator());
          },
        ));
  }
}
