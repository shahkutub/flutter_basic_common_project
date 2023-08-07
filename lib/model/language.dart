class Language {
  final int id;
  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(0, "Bangla", "bn"),
      Language(1, "English", "en"),
    ];
  }
}