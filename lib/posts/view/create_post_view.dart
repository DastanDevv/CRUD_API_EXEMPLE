import 'package:crud_api/models/post_model.dart';
import 'package:crud_api/posts/cubit/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key, this.post});

  final Post? post;

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    if (widget.post != null) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.post == null ? 'Create Post ' : 'Update Post'),
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
            maxLines: 3,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: bodyController,
            decoration: const InputDecoration(
              labelText: 'Body',
            ),
            maxLines: 6,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : widget.post == null
                    ? createPost
                    : updatePost,
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(widget.post == null ? 'Create Post ' : 'Update Post'),
          ),
          if (widget.post != null)
            ElevatedButton(
              onPressed: isLoading ? null : deletePost,
              child: const Text('Delete Post'),
            ),
        ],
      ),
    );
  }

  Future<void> createPost() async {
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
  }

  Future<void> updatePost() async {
    setState(() {
      isLoading = true;
    });
    final result = await context.read<PostsCubit>().updatePost(
          postId: widget.post!.id,
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
  }

  Future<void> deletePost() async {
    setState(() {
      isLoading = true;
    });
    final result = await context.read<PostsCubit>().deletePost(
          postId: widget.post!.id,
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
  }
}
