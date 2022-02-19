class MainCategoryModel {
  final String id;
  final String title;
  final bool isSpecial;
  final List<SecondLevelCategoryModel> childrenList;
  final String imageId;

  MainCategoryModel({
    required this.id,
    required this.title,
    required this.isSpecial,
    required this.childrenList,
    required this.imageId,
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
  final List<ThirdLevelCategoryModel>? childrenList;
  final List<String> parentList;

  SecondLevelCategoryModel({
    required this.id,
    required this.title,
    required this.isSpecial,
    this.childrenList,
    required this.parentList
  });
  bool isMainCategory = false;
  bool isSecondLevelCategory = true;
  bool isThirdLevelCategory = false;
}

class ThirdLevelCategoryModel {
  final String id;
  final String title;
  final bool isSpecial;
  final List? childrenList;
  final List<String> parentList;

  ThirdLevelCategoryModel({
    required this.id,
    required this.title,
    required this.isSpecial,
    this.childrenList,
    required this.parentList
  });
  bool isMainCategory = false;
  bool isSecondLevelCategory = false;
  bool isThirdLevelCategory = true;
}

class SpecialCategoryOnHomePageModel {
  final String id;
  final String title;
  final bool isSpecial;
  final bool? showOnHomePage;
  final String imageId;

  SpecialCategoryOnHomePageModel({
    required this.id,
    required this.isSpecial,
    this.showOnHomePage,
    required this.title,
    required this.imageId
  });
}