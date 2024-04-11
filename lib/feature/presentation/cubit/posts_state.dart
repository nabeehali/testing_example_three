part of 'posts_cubit.dart';
@immutable
abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostsLoading extends PostsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class PostsLoaded extends PostsState {
  final List<PostModel> posts;

  const PostsLoaded(this.posts);

  @override
  // TODO: implement props
  List<Object?> get props =>[posts];
}

class PostsError extends PostsState {
  final String? message;
  const PostsError({this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];


}
