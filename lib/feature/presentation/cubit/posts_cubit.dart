import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/post_model.dart';
import '../../domain/repository/posts_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository _postsRepository;
  PostsCubit(this._postsRepository) : super(PostsInitial());

  Future<void> loadPosts() async {
    emit(PostsLoading());
    try {
      final posts = await _postsRepository.getPosts();
      emit(PostsLoaded(posts));
    } on Exception catch (e) {
      var errorString = e.toString();
      log(errorString);
      emit(const PostsError());
    }
  }
}
