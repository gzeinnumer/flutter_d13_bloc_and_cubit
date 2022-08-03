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
