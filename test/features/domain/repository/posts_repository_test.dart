import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_example_3/feature/data/datasources/remote_datasource.dart';
import 'package:testing_example_3/feature/data/models/post_model.dart';
import 'package:testing_example_3/feature/domain/repository/posts_repository.dart';

import 'posts_repository_test.mocks.dart';

/// Notation from mockito to generate mock RemoteDataSource class.
@GenerateMocks([RemoteDataSource])

/// we need apply this command in terminal to ensure the notation above build mock class using (build_runner package in dev dependency).
/// flutter pub run build --delete-conflicting--outputs
void main() {
  late RemoteDataSource mockRemoteDataSource;
  late PostsRepository postsRepository;

  /// This Function (setUpAll) run before any test method run.
  setUp(() {
    ///make instance from MockRemoteDataSource class to send it into  PostsRepositoryImpl class.
    mockRemoteDataSource = MockRemoteDataSource();
    postsRepository = PostsRepositoryImpl(mockRemoteDataSource);
  });

  test('Get list of posts in repository layer', () async {
    ///arrange
    /// generate static List.
    final posts = List.generate(
        5,
        (index) => PostModel(
            id: index,
            userId: index,
            title: 'title $index',
            body: 'body $index'));

    /// when call method getPosts in mockRemoteDataSource class then we have answer function will execute.

    when(mockRemoteDataSource.getPosts())
        .thenAnswer((_) => Future.value(posts));

    ///act
    final result = await postsRepository.getPosts();

    ///assert
    expect(result, posts);
  });
}
