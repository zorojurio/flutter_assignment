import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
class AnimalPage extends StatefulWidget {
  AnimalPage({Key? key}) : super(key: key);
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => AnimalPage(),
  );
  @override
  _AnimalPageState createState() => _AnimalPageState();
}
class _AnimalPageState extends State<AnimalPage> {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animals"),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post>? posts = snapshot.data;
            return ListView(
              children: posts!
                  .map(
                    (Post post) => ListTile(
                  title: Text(post.animalName),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PostDetail(
                        post: post,
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            );
          } else {
            return Center(child: Text("Not fetching"));
          }
        },
      ),
    );
  }
}
class HttpService {
  final String postsURL = "https://fi67.github.io/JsonData/apiAnimals.json";
  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.parse(postsURL));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
      )
          .toList();
      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}

class Post {
  final String animalName;
  final String animalPic;
  final String animalAge;
  final String animalType;
  final String animalBreed;
  Post(
      {required this.animalName,
        required this.animalPic,
        required this.animalAge,
        required this.animalType,
        required this.animalBreed});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        animalName: json['animalName'] as String,
        animalPic: json['animalPic'] as String,
        animalAge: json['animalAge'] as String,
        animalType: json['animalType'] as String,
        animalBreed: json['animalBreed'] as String);
  }
}

class PostDetail extends StatelessWidget {
  final Post post;
  PostDetail({required this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.animalName),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildVerticalLayout(post)
              : _buildHorizontalLayout(post);
        },
      ),
    );
  }
}

Widget _buildVerticalLayout(post) {
  return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    Image.network(post.animalPic),
    Expanded(
      child:
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Name: ${post.animalName}"),
        Text("Age: ${post.animalAge}"),
        Text("Type: ${post.animalType}"),
        Text("Breed: ${post.animalBreed}")
      ]),
    )
  ]);
}
Widget _buildHorizontalLayout(post) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(post.animalPic),
        Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Name: ${post.animalName}"),
                  Text("Age: ${post.animalAge}"),
                  Text("Type: ${post.animalType}"),
                  Text("Breed: ${post.animalBreed}"),
                ]))
      ]);
}