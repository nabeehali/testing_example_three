import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_example_3/feature/data/models/post_model.dart';
import 'package:testing_example_3/feature/domain/repository/posts_repository.dart';
import 'package:testing_example_3/feature/presentation/cubit/posts_cubit.dart';

import 'posts_cubit_test.mocks.dart';

/// Notation from mockito to generate mock PostsRepository class.
@GenerateMocks([PostsRepository])

/// we need apply this command in terminal to ensure the notation above build mock class using (build_runner package in dev dependency).
/// flutter pub run build --delete-conflicting--outputs
void main() {
  late PostsCubit postsCubit;
  late PostsRepository mockPostsRepository;

  /// This Function (setUpAll) run before any test method run.
  setUpAll(() {
    ///make instance from MockPostsRepository class to send it into  PostsCubit class.

    mockPostsRepository = MockPostsRepository();
    postsCubit = PostsCubit(mockPostsRepository);
  });

  test(
      'PostsCubit should emit PostsLoading then PostsLoaded State with a list of posts when calling loadPosts method',
      () async {
    ///arrange
    final posts = List.generate(
      10,
      (index) => PostModel(
          id: index, userId: index, title: 'title $index', body: 'body $index'),
    );

    /// when call method getPosts in mockPostsRepository class then we have answer function will execute.
    when(mockPostsRepository.getPosts()).thenAnswer((_) => Future.value(posts));

    ///assert
    final expectedStates = [
      PostsLoading(),
      PostsLoaded(posts),
    ];

    /// expect post cubit emit  PostsLoading then PostsLoaded respectively.
    expectLater(postsCubit.stream, emitsInAnyOrder(expectedStates));

    ///act
    postsCubit.loadPosts();
  });

  test(
    '''PostsCubit should emit PostsLoading then PostsError State
   when calling loadPosts method if repository throw an Exception''',
    () {
      ///arrange
      /// when call method getPosts in mockPostsRepository class then we have answer function will execute.
      when(mockPostsRepository.getPosts()).thenThrow(Exception());

      ///assert
      final expectedStates = [
        PostsLoading(),
        const PostsError(),
      ];

      /// expect post cubit emit  PostsLoading then PostsError respectively.
      expectLater(postsCubit.stream, emitsInAnyOrder(expectedStates));

      ///act
      postsCubit.loadPosts();
      verify(mockPostsRepository.getPosts());
    },
  );
}
