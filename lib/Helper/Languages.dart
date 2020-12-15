class Languages {
  String code;
  String englishName;
  String localName;
  String flag;
  bool selected;

  Languages(this.code, this.englishName, this.localName, this.flag,
      {this.selected = false});
}

class MyLanguagesList {
  List<Languages> _languages;

  MyLanguagesList() {
    this._languages = [
      new Languages("en", "English", "English", "Assets/flags/usa.png",
          selected: true),
      new Languages("ar", "Arabic", "العربية", "Assets/flags/uae.png"),
      new Languages("es", "Spanish", "Spana", "Assets/flags/spain.png"),
      new Languages("fr", "French (Canada)", "Français - Canadien",
          "Assets/flags/canada.png"),
      new Languages("pr", "Brazilian", "Brazilian", "Assets/flags/brazil.png"),
    ];
  }

  List<Languages> get languages => _languages;
}
