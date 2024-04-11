import 'package:flutter_test/flutter_test.dart';
import 'package:testing_example_3/feature/data/models/post_model.dart';

void main() {
  const postsModel = PostModel(
      body: "Hello World ,Hello Everyone",
      id: 1,
      title: "please smile why you are shy ",
      userId: 100);

  /// to ensure that we have same type of model.
  test('test if the model have same type (if you have entity)', () async {
    expect(postsModel, isA<PostModel>());
  });
}
