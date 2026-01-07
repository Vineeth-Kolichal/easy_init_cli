class Config {
  final String architecture;

  /// patterns means: [feature-wise, layer-wise]
  final String pattern;
  final String version;

  Config({
    required this.architecture,
    required this.pattern,
    required this.version,
  });

  Map<String, dynamic> toJson() => {
        "architecture": architecture,
        "pattern": pattern,
        "version": version,
      };

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      architecture: json["architecture"],
      pattern: json["pattern"],
      version: json["version"],
    );
  }
}
