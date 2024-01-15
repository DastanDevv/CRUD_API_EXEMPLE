import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crud_api/models/post_model.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'posts_state.dart';

//CRUD - Create, Read, Update, Delete

// написали наш endpoint
const url = 'https://jsonplaceholder.typicode.com/posts';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.client) : super(PostsInitial());

  final Client client;
// Get (Read) posts
/*
Это должен соединится с endpoint и вернуть список постов 
https://jsonplaceholder.typicode.com/posts
эсли это будет успешно то переводим на Post model и возвращаем Success state
если будет ошибка то возвращаем Error state
*/

  /// Получает сообщения из API
  Future<void> getPosts() async {
    emit(PostsLoading()); // Уведомление о том, что сообщения загружаются
    try {
      final response =
          await client.get(Uri.parse(url)); // Отправьте GET-запрос к API
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body)
            as List<dynamic>; // Декодируйте тело ответа
        final posts = body
            .map((e) => Post.fromJson(e))
            .toList(); // Преобразуйте данные JSON в список объектов Post
        emit(PostsSuccess(
            posts)); // Уведомление об успешном извлечении сообщений
      } else {
        emit(PostsError(response
            .body)); //Уведомление о том, что при получении сообщений произошла ошибка
      }
    } catch (e) {
      emit(PostsError(e
          .toString())); // Уведомление о том, что при получении сообщений возникло исключение
    }
  }

// Post (Create) post
/*
От пользователя получаем Title и description и отправляем на endpoint
https://jsonplaceholder.typicode.com/posts
*/

  Future<(int, String)> createPost(
      {required String title, required String body}) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
      );

      if (response.statusCode == 201) {
        return (201, 'Post created successfully');
      } else {
        return (0, response.body);
      }
    } catch (e) {
      return (0, e.toString());
    }
  }
// Put (Update) post
/*
От пользователя получаем Title и description и изменяем пост
PUT - для полной замены ресурса
endpoint: https://jsonplaceholder.typicode.com/posts/1
*/

// patch (Update) post
/*
Отличие от Put - может изменить только конкретное поле например id,title,description и т.д.
PATCH обновляет только указанные поля ресурса. Передаются только измененные данные.
endpoint: https://jsonplaceholder.typicode.com/posts/1
*/

// Delete (delete) post
/*
Смотрим id пользователя и удаляем пост от бекенда
Таким образом, DELETE - это простой способ удаления данных на сервере по URI. 
endpoint: https://jsonplaceholder.typicode.com/posts/1
*/
}
