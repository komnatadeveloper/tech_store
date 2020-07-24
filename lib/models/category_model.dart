class MainCategoryModel {
  final String id;
  final String title;
  final bool isSpecial;
  final List<SecondLevelCategoryModel> childrenList;
  final String imageId;

  MainCategoryModel({
    this.id,
    this.title,
    this.isSpecial,
    this.childrenList,
    this.imageId,
  });
  bool isMainCategory = true;
  bool isSecondLevelCategory = false;
  bool isThirdLevelCategory = false;
  List<String> parentList = [];
}

class SecondLevelCategoryModel {
  final String id;
  final String title;
  final bool isSpecial;
  final List<ThirdLevelCategoryModel> childrenList;
  final List<String> parentList;

  SecondLevelCategoryModel({
    this.id,
    this.title,
    this.isSpecial,
    this.childrenList,
    this.parentList
  });
  bool isMainCategory = false;
  bool isSecondLevelCategory = true;
  bool isThirdLevelCategory = false;
}

class ThirdLevelCategoryModel {
  final String id;
  final String title;
  final bool isSpecial;
  final List childrenList;
  final List<String> parentList;

  ThirdLevelCategoryModel({
    this.id,
    this.title,
    this.isSpecial,
    this.childrenList,
    this.parentList
  });
  bool isMainCategory = false;
  bool isSecondLevelCategory = false;
  bool isThirdLevelCategory = true;
}

class SpecialCategoryOnHomePageModel {
  final String id;
  final String title;
  final bool isSpecial;
  final bool showOnHomePage;
  final String imageId;

  SpecialCategoryOnHomePageModel({
    this.id,
    this.isSpecial,
    this.showOnHomePage,
    this.title,
    this.imageId
  });
}