part of 'search_repositories_page.dart';

class _RepositoryTile extends StatelessWidget {
  const _RepositoryTile({
    required this.item,
  });
  static const _kDescriptionLength = 50;
  final GitRepositoryEntity item;

  @override
  Widget build(BuildContext context) {
    final description = item.description.length < _kDescriptionLength
        ? item.description
        : item.description.substring(0, _kDescriptionLength);

    return ListTile(
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(item.authorImage),
        ),
        title: Text(item.repositoryName),
        subtitle: Text(description));
  }
}
