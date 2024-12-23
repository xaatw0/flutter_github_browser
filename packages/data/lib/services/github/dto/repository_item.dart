import 'license.dart';
import 'owner.dart';

class RepositoryItem {
  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final bool isPrivate;
  final Owner owner;
  final String htmlUrl;
  final String? description;
  final bool fork;
  final String url;
  final String forksUrl;
  final String keysUrl;
  final String collaboratorsUrl;
  final String teamsUrl;
  final String hooksUrl;
  final String issueEventsUrl;
  final String eventsUrl;
  final String assigneesUrl;
  final String branchesUrl;
  final String tagsUrl;
  final String blobsUrl;
  final String gitTagsUrl;
  final String gitRefsUrl;
  final String treesUrl;
  final String statusesUrl;
  final String languagesUrl;
  final String stargazersUrl;
  final String contributorsUrl;
  final String subscribersUrl;
  final String subscriptionUrl;
  final String commitsUrl;
  final String gitCommitsUrl;
  final String commentsUrl;
  final String issueCommentUrl;
  final String contentsUrl;
  final String compareUrl;
  final String mergesUrl;
  final String archiveUrl;
  final String downloadsUrl;
  final String issuesUrl;
  final String pullsUrl;
  final String milestonesUrl;
  final String notificationsUrl;
  final String labelsUrl;
  final String releasesUrl;
  final String deploymentsUrl;
  final String createdAt;
  final String updatedAt;
  final String pushedAt;
  final String gitUrl;
  final String sshUrl;
  final String cloneUrl;
  final String svnUrl;
  final String? homepage;
  final int size;
  final int stargazersCount;
  final int watchersCount;
  final String? language;
  final bool hasIssues;
  final bool hasProjects;
  final bool hasDownloads;
  final bool hasWiki;
  final bool hasPages;
  final bool hasDiscussions;
  final int forksCount;
  final String? mirrorUrl;
  final bool archived;
  final bool disabled;
  final int openIssuesCount;
  final License? license;
  final bool allowForking;
  final bool isTemplate;
  final bool webCommitSignoffRequired;
  final List<String> topics;
  final String visibility;
  final int forks;
  final int openIssues;
  final int watchers;
  final String defaultBranch;
  final double score;

  RepositoryItem({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.isPrivate,
    required this.owner,
    required this.htmlUrl,
    this.description,
    required this.fork,
    required this.url,
    required this.forksUrl,
    required this.keysUrl,
    required this.collaboratorsUrl,
    required this.teamsUrl,
    required this.hooksUrl,
    required this.issueEventsUrl,
    required this.eventsUrl,
    required this.assigneesUrl,
    required this.branchesUrl,
    required this.tagsUrl,
    required this.blobsUrl,
    required this.gitTagsUrl,
    required this.gitRefsUrl,
    required this.treesUrl,
    required this.statusesUrl,
    required this.languagesUrl,
    required this.stargazersUrl,
    required this.contributorsUrl,
    required this.subscribersUrl,
    required this.subscriptionUrl,
    required this.commitsUrl,
    required this.gitCommitsUrl,
    required this.commentsUrl,
    required this.issueCommentUrl,
    required this.contentsUrl,
    required this.compareUrl,
    required this.mergesUrl,
    required this.archiveUrl,
    required this.downloadsUrl,
    required this.issuesUrl,
    required this.pullsUrl,
    required this.milestonesUrl,
    required this.notificationsUrl,
    required this.labelsUrl,
    required this.releasesUrl,
    required this.deploymentsUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.gitUrl,
    required this.sshUrl,
    required this.cloneUrl,
    required this.svnUrl,
    this.homepage,
    required this.size,
    required this.stargazersCount,
    required this.watchersCount,
    this.language,
    required this.hasIssues,
    required this.hasProjects,
    required this.hasDownloads,
    required this.hasWiki,
    required this.hasPages,
    required this.hasDiscussions,
    required this.forksCount,
    this.mirrorUrl,
    required this.archived,
    required this.disabled,
    required this.openIssuesCount,
    this.license,
    required this.allowForking,
    required this.isTemplate,
    required this.webCommitSignoffRequired,
    required this.topics,
    required this.visibility,
    required this.forks,
    required this.openIssues,
    required this.watchers,
    required this.defaultBranch,
    required this.score,
  });

  factory RepositoryItem.fromJson(Map<String, dynamic> json) {
    return RepositoryItem(
      id: json['id'],
      nodeId: json['node_id'],
      name: json['name'],
      fullName: json['full_name'],
      isPrivate: json['private'],
      owner: Owner.fromJson(json['owner']),
      htmlUrl: json['html_url'],
      description: json['description'],
      fork: json['fork'],
      url: json['url'],
      forksUrl: json['forks_url'],
      keysUrl: json['keys_url'],
      collaboratorsUrl: json['collaborators_url'],
      teamsUrl: json['teams_url'],
      hooksUrl: json['hooks_url'],
      issueEventsUrl: json['issue_events_url'],
      eventsUrl: json['events_url'],
      assigneesUrl: json['assignees_url'],
      branchesUrl: json['branches_url'],
      tagsUrl: json['tags_url'],
      blobsUrl: json['blobs_url'],
      gitTagsUrl: json['git_tags_url'],
      gitRefsUrl: json['git_refs_url'],
      treesUrl: json['trees_url'],
      statusesUrl: json['statuses_url'],
      languagesUrl: json['languages_url'],
      stargazersUrl: json['stargazers_url'],
      contributorsUrl: json['contributors_url'],
      subscribersUrl: json['subscribers_url'],
      subscriptionUrl: json['subscription_url'],
      commitsUrl: json['commits_url'],
      gitCommitsUrl: json['git_commits_url'],
      commentsUrl: json['comments_url'],
      issueCommentUrl: json['issue_comment_url'],
      contentsUrl: json['contents_url'],
      compareUrl: json['compare_url'],
      mergesUrl: json['merges_url'],
      archiveUrl: json['archive_url'],
      downloadsUrl: json['downloads_url'],
      issuesUrl: json['issues_url'],
      pullsUrl: json['pulls_url'],
      milestonesUrl: json['milestones_url'],
      notificationsUrl: json['notifications_url'],
      labelsUrl: json['labels_url'],
      releasesUrl: json['releases_url'],
      deploymentsUrl: json['deployments_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pushedAt: json['pushed_at'],
      gitUrl: json['git_url'],
      sshUrl: json['ssh_url'],
      cloneUrl: json['clone_url'],
      svnUrl: json['svn_url'],
      homepage: json['homepage'],
      size: json['size'],
      stargazersCount: json['stargazers_count'],
      watchersCount: json['watchers_count'],
      language: json['language'],
      hasIssues: json['has_issues'],
      hasProjects: json['has_projects'],
      hasDownloads: json['has_downloads'],
      hasWiki: json['has_wiki'],
      hasPages: json['has_pages'],
      hasDiscussions: json['has_discussions'],
      forksCount: json['forks_count'],
      mirrorUrl: json['mirror_url'],
      archived: json['archived'],
      disabled: json['disabled'],
      openIssuesCount: json['open_issues_count'],
      license:
      json['license'] != null ? License.fromJson(json['license']) : null,
      allowForking: json['allow_forking'],
      isTemplate: json['is_template'],
      webCommitSignoffRequired: json['web_commit_signoff_required'],
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      visibility: json['visibility'],
      forks: json['forks'],
      openIssues: json['open_issues'],
      watchers: json['watchers'],
      defaultBranch: json['default_branch'],
      score: (json['score'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'node_id': nodeId,
      'name': name,
      'full_name': fullName,
      'private': isPrivate,
      'owner': owner.toJson(),
      'html_url': htmlUrl,
      'description': description,
      'fork': fork,
      'url': url,
      'forks_url': forksUrl,
      'keys_url': keysUrl,
      'collaborators_url': collaboratorsUrl,
      'teams_url': teamsUrl,
      'hooks_url': hooksUrl,
      'issue_events_url': issueEventsUrl,
      'events_url': eventsUrl,
      'assignees_url': assigneesUrl,
      'branches_url': branchesUrl,
      'tags_url': tagsUrl,
      'blobs_url': blobsUrl,
      'git_tags_url': gitTagsUrl,
      'git_refs_url': gitRefsUrl,
      'trees_url': treesUrl,
      'statuses_url': statusesUrl,
      'languages_url': languagesUrl,
      'stargazers_url': stargazersUrl,
      'contributors_url': contributorsUrl,
      'subscribers_url': subscribersUrl,
      'subscription_url': subscriptionUrl,
      'commits_url': commitsUrl,
      'git_commits_url': gitCommitsUrl,
      'comments_url': commentsUrl,
      'issue_comment_url': issueCommentUrl,
      'contents_url': contentsUrl,
      'compare_url': compareUrl,
      'merges_url': mergesUrl,
      'archive_url': archiveUrl,
      'downloads_url': downloadsUrl,
      'issues_url': issuesUrl,
      'pulls_url': pullsUrl,
      'milestones_url': milestonesUrl,
      'notifications_url': notificationsUrl,
      'labels_url': labelsUrl,
      'releases_url': releasesUrl,
      'deployments_url': deploymentsUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pushed_at': pushedAt,
      'git_url': gitUrl,
      'ssh_url': sshUrl,
      'clone_url': cloneUrl,
      'svn_url': svnUrl,
      'homepage': homepage,
      'size': size,
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'language': language,
      'has_issues': hasIssues,
      'has_projects': hasProjects,
      'has_downloads': hasDownloads,
      'has_wiki': hasWiki,
      'has_pages': hasPages,
      'has_discussions': hasDiscussions,
      'forks_count': forksCount,
      'mirror_url': mirrorUrl,
      'archived': archived,
      'disabled': disabled,
      'open_issues_count': openIssuesCount,
      'license': license?.toJson(),
      'allow_forking': allowForking,
      'is_template': isTemplate,
      'web_commit_signoff_required': webCommitSignoffRequired,
      'topics': topics,
      'visibility': visibility,
      'forks': forks,
      'open_issues': openIssues,
      'watchers': watchers,
      'default_branch': defaultBranch,
      'score': score,
    };
  }
}
