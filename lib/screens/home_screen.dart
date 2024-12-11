import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_amit_56/core/models/todo_item_model.dart';
import 'package:pagination_amit_56/logic/home/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home Screen"),
          ),
          body:  ListView.builder(
            controller: cubit.scrollController,
            itemBuilder: (context, index) {
              if (index < cubit.paginationList.length) {
                return toDoItem(context, cubit.paginationList[index]);
              } else if (cubit.listTodoItemClass != null &&
                  cubit.listTodoItemClass!.isNotEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(
                    child: Text(
                  "No Data",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 24),
                ));
              }
            },
            itemCount: cubit.paginationList.length + 1,
          ),
        );
      },
    );
  }
}

Widget toDoItem(context, TodoItemClass todoItem) {
  return GestureDetector(
    onTap: () {},
    child: ListTile(
      leading: Image.network(
        "https://tse1.mm.bing.net/th?id=OIP.IGNf7GuQaCqz_RPq5wCkPgHaLH&pid=Api",
      ),
      title: Text(todoItem.title ?? ""),
      subtitle: Text(todoItem.status ?? ""),
    ),
  );
}
