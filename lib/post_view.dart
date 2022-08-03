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
