part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsSuccess extends PostsState {
  PostsSuccess(this.posts);
  final List<Post> posts;
}

final class PostsError extends PostsState {
  PostsError(this.message);
  final String message;
}
