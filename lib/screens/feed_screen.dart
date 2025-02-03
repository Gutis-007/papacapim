import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/post_provider.dart';
import '../models/post.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: postProvider.fetchFeed(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (postProvider.posts.isEmpty) {
            return const Center(child: Text('Nenhuma postagem encontrada.'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: postProvider.posts.length,
              itemBuilder: (context, index) => PostCard(post: postProvider.posts[index]),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/create-post'),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 10),
                Text(
                  post.authorId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(post.content),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                Text(post.likes.toString()),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}