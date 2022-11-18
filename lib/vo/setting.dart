class Setting {
  final int supportBuildNum;
  // int latestBuildNum;
  // String latestBuildUrl;

  Setting({
    required this.supportBuildNum,
    // required this.latestBuildNum,
    // required this.latestBuildUrl,
  });

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      supportBuildNum: map['support_build_number'],
      // latestBuildNum: map['latest_build_number'] ?? 1,
      // latestBuildUrl: map['latest_build_url'] ?? "",
    );
  }

  @override
  String toString() {
    return 'Setting{supportBuildNum:$supportBuildNum}';
  }
}
