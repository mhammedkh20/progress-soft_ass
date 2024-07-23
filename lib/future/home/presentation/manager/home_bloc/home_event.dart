part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetPostsEvent extends HomeEvent {}

class GetInitHomeEvent extends HomeEvent {
  final BuildContext context;
  GetInitHomeEvent(this.context);
}

class SearchPostsByTitleEvent extends HomeEvent {
  final String title;

  SearchPostsByTitleEvent(this.title);
}

class SearchClearEvent extends HomeEvent {}

class GetDataUserEvent extends HomeEvent {}
