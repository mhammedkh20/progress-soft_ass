part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

// ! GET POSTS
class PostsLoading extends HomeState {}

class PostsSuccess extends HomeState {}

class PostsFailuer extends HomeState {
  final String message;
  PostsFailuer(this.message);
}

// ! SEARCH
class SearchPostsState extends HomeState {
  final List<PostModel> searchResults;

  SearchPostsState(this.searchResults);
}

// ! CLEAR
class SearchClearState extends HomeState {}

// ! GET DATA USER FROM FIRESTORE

class GetUserLoading extends HomeState {}

class GetUserSuccess extends HomeState {}

class GetUserFailuer extends HomeState {
  final String message;
  GetUserFailuer(this.message);
}
