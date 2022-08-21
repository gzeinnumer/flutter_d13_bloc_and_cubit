# flutter_d13_bloc_and_cubit


- data_service.dart
```dart
import 'dart:convert';
import 'package:flutter_d13_bloc_and_cubit/post.dart';
import 'package:http/http.dart' as http;

class DataService {
  final _baseUrl = 'jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts() async {
    try {
      final uri = Uri.https(_baseUrl, '/posts');
      final response = await http.get(uri);
      final json = jsonDecode(response.body) as List;
      final posts = json.map((postJson) => Post.fromJson(postJson)).toList();
      return posts;
    } on Exception catch (e) {
      throw e;
    }
  }
}
```
- main.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d13_bloc_and_cubit/post_cubit.dart';
import 'package:flutter_d13_bloc_and_cubit/post_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<PostCubit>(create: (context) => PostCubit()..getPost())
        ],
        child: PostView(),
      ),
    );
  }
}
```
- post.dart
```dart
class Post {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']);
}
```
- post_cubit.dart
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d13_bloc_and_cubit/data_service.dart';
import 'package:flutter_d13_bloc_and_cubit/post.dart';

class PostCubit extends Cubit<List<Post>> {
  final _dataService = DataService();

  PostCubit() : super([]);

  void getPost() async {
    return emit(await _dataService.getPosts());
  }
}
```
- post_view.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_d13_bloc_and_cubit/post.dart';
import 'package:flutter_d13_bloc_and_cubit/post_cubit.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: BlocBuilder<PostCubit, List<Post>>(builder: (context, res) {
        if (res.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: res.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(res[index].title.toString()),
                ),
              );
            });
      }),
    );
  }
}
```

---

```
Copyright 2022 M. Fadli Zein
```