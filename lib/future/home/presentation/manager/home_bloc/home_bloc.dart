import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_soft_ass/core/storage/pref/shared_pref_controller.dart';
import 'package:progress_soft_ass/future/auth/models/user_model.dart';
import 'package:progress_soft_ass/future/home/domin/home_repo.dart';
import 'package:progress_soft_ass/future/home/models/post_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore _authFirestore = FirebaseFirestore.instance;

  final HomeRepo repo;

  HomeBloc(this.repo) : super(HomeInitial()) {
    on<GetPostsEvent>(_getPosts);
    on<SearchPostsByTitleEvent>(_searchPostsByTitle);
    on<SearchClearEvent>(_searchClear);
    on<GetDataUserEvent>(_getUserData);
  }

  List<PostModel> posts = [];
  Future<void> _getPosts(GetPostsEvent event, emit) async {
    emit(PostsLoading());
    (await repo.getPosts()).fold(
      (l) {
        emit(PostsFailuer(l));
      },
      (r) {
        posts = r;
        emit(PostsSuccess());
      },
    );
  }

  void _searchPostsByTitle(SearchPostsByTitleEvent event, emit) {
    List<PostModel> searchResults =
        posts.where((post) => post.title!.contains(event.title)).toList();
    emit(SearchPostsState(searchResults));
  }

  void _searchClear(SearchClearEvent event, emit) {
    emit(SearchClearState());
  }

  UserModel? user;
  Future _getUserData(GetDataUserEvent event, emit) async {
    emit(GetUserLoading());
    QuerySnapshot query = await _authFirestore
        .collection('users')
        .where('phone_number', isEqualTo: SharedPrefController().getPhoneNumber)
        .get();
    user = UserModel.fromDocumentSnapshot(query.docs[0]);
    emit(GetUserSuccess());
  }
}
