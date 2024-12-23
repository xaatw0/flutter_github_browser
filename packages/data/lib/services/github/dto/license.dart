class License {
  final String key;
  final String name;
  final String spdxId;
  final String url;
  final String nodeId;

  License({
    required this.key,
    required this.name,
    required this.spdxId,
    required this.url,
    required this.nodeId,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      key: json['key'],
      name: json['name'],
      spdxId: json['spdx_id'],
      url: json['url'] ?? '',
      nodeId: json['node_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'name': name,
      'spdx_id': spdxId,
      'url': url,
      'node_id': nodeId,
    };
  }
}
