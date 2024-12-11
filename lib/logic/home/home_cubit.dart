import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_amit_56/core/global/dio_helper.dart';
import 'package:pagination_amit_56/core/local/shared_preference.dart';
import 'package:pagination_amit_56/core/models/todo_item_model.dart';
import 'package:pagination_amit_56/core/services/services_locator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<TodoItemClass>? listTodoItemClass;
  List<TodoItemClass> paginationList = [];
  SharedPreferenceHelper preferenceHelper = sl<SharedPreferenceHelper>();

  void getListTodos(int pageNumber) {
    // Call Data  // WebServices
    DioHelper.getData(endPoint: "todos", queryParameters: {"page": pageNumber})
        .then((value) {
      listTodoItemClass =
          (value.data as List).map((e) => TodoItemClass.fromJson(e)).toList();

      paginationList.addAll(listTodoItemClass!);
      emit(GetAllTodosListSuccessState());
    }).catchError((error) {
      emit(GetAllTodosListFailedState());
    });
  }

  final ScrollController scrollController = ScrollController();
  int pageNumber = 1;

  void funPaginationListToDo() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (listTodoItemClass == null || listTodoItemClass!.isEmpty) return;

        pageNumber++;
        getListTodos(pageNumber);
        emit(FunPaginationListToDoSuccessState());
      }
    });
  }

  void refreshToken() async {
    await DioHelper.getData(endPoint: "auth/refresh-token", queryParameters: {
      "token": preferenceHelper.getData(key: "refreshToken")
    }).then((value) async {
      preferenceHelper.saveData(
          key: "token", value: value.data["access_token"]);
      await DioHelper.initDioHelper();
      getListTodos(pageNumber);
    }).catchError((error) {});
  }
}
