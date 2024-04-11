
import '../../data/datasources/remote_datasource.dart';
import '../../data/models/post_model.dart';

abstract class PostsRepository {
  Future<List<PostModel>> getPosts();
}

class PostsRepositoryImpl implements PostsRepository {
  final RemoteDataSource _remoteDataSource;

  PostsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<PostModel>> getPosts() {
    return _remoteDataSource.getPosts();
  }
}
