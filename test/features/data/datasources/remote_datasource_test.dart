import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_example_3/core/services/network_service.dart';
import 'package:testing_example_3/feature/data/datasources/remote_datasource.dart';
import 'package:testing_example_3/feature/data/models/post_model.dart';

import 'remote_datasource_test.mocks.dart';

/// Notation from mockito to generate mock NetworkService class.
@GenerateMocks([NetworkService])

/// we need apply this command in terminal to ensure the notation above build mock class using (build_runner package in dev dependency).
/// flutter pub run build --delete-conflicting--outputs
void main() {
  late RemoteDataSourceImpl remoteDataSource;
  late NetworkService mockNetworkService;

  /// This Function (setUpAll) run before any test method run.
  setUpAll(() {
    ///make instance from MockNetworkService class to send it into  RemoteDataSourceImpl class.
    mockNetworkService = MockNetworkService();
    remoteDataSource = RemoteDataSourceImpl(mockNetworkService);
  });

  test('get all posts best case', () async {
    ///arrange
    /// generate static List.
    final posts = List.generate(
      10,
      (index) => PostModel(
          id: index, userId: index, title: 'title $index', body: 'body $index'),
    );

    final postsMap = posts.map((post) => post.toMap()).toList();

    /// when call method get in mockNetworkService class then we have answer function will execute.

    when(mockNetworkService.get('https://jsonplaceholder.typicode.com/posts'))
        .thenAnswer(
      (_) => Future.value(
        Response(
          requestOptions: RequestOptions(
              path: 'https://jsonplaceholder.typicode.com/posts'),
          data: postsMap,
          statusCode: 200,
        ),
      ),
    );

    ///act
    final result = await remoteDataSource.getPosts();

    ///assert
    expect(result, posts);
  });

  test('worst case for get posts (server down)', () async {
    ///arrange
    final expectedResult = throwsA(isA<Exception>());

    /// when call method get in mockNetworkService class then we have answer function will execute.
    when(mockNetworkService.get('https://jsonplaceholder.typicode.com/posts'))
        .thenAnswer(
      (_) => Future.value(
        Response(
          requestOptions: RequestOptions(
              path: 'https://jsonplaceholder.typicode.com/posts'),
          statusCode: 404,
        ),
      ),
    );

    ///act
    result() async => await remoteDataSource.getPosts();

    ///assert
    expect(result, expectedResult);
  });
}
