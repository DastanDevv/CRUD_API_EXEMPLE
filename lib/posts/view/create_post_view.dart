import 'package:crud_api/posts/cubit/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Post View'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: bodyController,
            decoration: const InputDecoration(
              labelText: 'Body',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    final result = await context.read<PostsCubit>().createPost(
                          title: titleController.text,
                          body: bodyController.text,
                        );
                    setState(() {
                      isLoading = false;
                    });

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${result.$1}/n ${result.$2}'),
                        ),
                      );
                    }
                  },
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('Create Post'),
          ),
        ],
      ),
    );
  }
}
