class Setting {
  final int supportBuildNum;
  String latestBuildUrl;

  Setting({
    required this.supportBuildNum,
    required this.latestBuildUrl,
  });

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      supportBuildNum: map['support_build_number'],
      latestBuildUrl: map['latest_build_url'] ?? "",
    );
  }

  @override
  String toString() {
    return 'Setting{supportBuildNum:$supportBuildNum}';
  }
}
