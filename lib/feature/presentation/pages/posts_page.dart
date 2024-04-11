import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_example_3/core/services/network_service.dart';

import '../../data/datasources/remote_datasource.dart';
import '../../data/models/post_model.dart';
import '../../domain/repository/posts_repository.dart';
import '../cubit/posts_cubit.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(
        PostsRepositoryImpl(
          RemoteDataSourceImpl(NetworkServiceImpl()),
        ),
      )..loadPosts(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('posts'),
          centerTitle: true,
        ),
        body: BlocConsumer<PostsCubit, PostsState>(
          listener: (context, state) {
            if (state is PostsError) _showErrorDialog(context);
          },
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostsLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (_, index) {
                  final post = state.posts[index];
                  return _PostItem(post);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('An error occurred!'),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  final PostModel _post;

  const _PostItem(this._post);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Color(0xFFA3F8A3),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ListTile(
        leading: Text(_post.id.toString()),
        title: Text(_post.title),
        subtitle: Text(_post.body),
      ),
    );
  }
}
