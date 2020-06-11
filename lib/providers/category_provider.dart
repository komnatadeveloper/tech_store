
import 'package:flutter/foundation.dart';
// HTTP and convert
import 'package:http/http.dart' as http;
import 'dart:convert';
// constants
import '../constants/constants.dart' as constants;
// models
import '../models/category_model.dart';
// helpers
import '../helpers/helpers.dart' as helpers;

class CategoryProvider with ChangeNotifier {
  List<MainCategoryModel> _mainCategoryList;
  List<MainCategoryModel> get mainCategoryList {
    return [ ..._mainCategoryList];
  }

  Future<void> fetchCategoryList () async {
    print('CategoryProvider -> fetchCategoryList FIRED ->');
    final url = '${constants.apiUrl}/api/category/';
    print('url ->');
    print(url);
    try {
      final res = await http.get(url);
      final  extractedData = json.decode(res.body ) as List<dynamic>;
      var mappedList = helpers.convertListDynamicToListMap(extractedData);

      // var mapData = extractedData.cast()

      print('CategoryProvider -> fetchCategoryList -> res ->');
      // print(extractedData);
      print('CategoryProvider -> fetchCategoryList -> transFormedCategoryList ->');
      // var mappedData = extractedData as List<Map<String, dynamic>>;
      print(handleTransformRawCategory(mappedList ));
      _mainCategoryList = handleTransformRawCategory(mappedList);
      notifyListeners();

    } catch (err) {
      print(err);
    }
  }

  List<MainCategoryModel> handleTransformRawCategory (List<Map<String, dynamic>> rawCategory) {
    final mainRawCategoryList = rawCategory.where((element) => element['isMainCategory'] == true).toList();
    final secondLevelRawCategoryList = rawCategory.where((element) => element['isSecondLevelCategory'] == true).toList();
    final thirdLevelRawCategoryList = rawCategory.where((element) => element['isThirdLevelCategory'] == true).toList();

    List<MainCategoryModel> mainCategoryList = [];

    for (int i = 0; i < mainRawCategoryList.length; i++) {

      final secondLevelRawChildrenCategories = secondLevelRawCategoryList.where(
        (element) => element['parentList'].indexOf(mainRawCategoryList[i]['_id']) >= 0
      ).toList();
      List<SecondLevelCategoryModel> secondChildrenList = [];
      

      for (int j = 0; j < secondLevelRawChildrenCategories.length; j++) {
        List<ThirdLevelCategoryModel> thirdChildrenList = [];
        final thirdLevelRawChildrenCategories = thirdLevelRawCategoryList.where(
          (element) => element['parentList'].indexOf(secondLevelRawChildrenCategories[j]['_id']) >= 0
        ).toList();
        thirdLevelRawChildrenCategories.forEach((element) { 
          thirdChildrenList.add(
            ThirdLevelCategoryModel(
              id: element['_id'],
              title: element['title'],
              childrenList: [],
              parentList: [ ...element['parentList']],
              isSpecial: element['isSpecial'],
            )
          );
        });
        secondChildrenList.add(
          SecondLevelCategoryModel(
            id: secondLevelRawChildrenCategories[j]['_id'],
            title: secondLevelRawChildrenCategories[j]['title'],
            isSpecial: false,
            parentList: [ ...secondLevelRawChildrenCategories[j]['parentList'] ],
            childrenList: [ ...thirdChildrenList ]
          )
        );
      }

      mainCategoryList.add(
        MainCategoryModel(
          title: mainRawCategoryList[i]['title'],
          id: mainRawCategoryList[i]['_id'],
          isSpecial: mainRawCategoryList[i]['isSpecial'],
          childrenList: [...secondChildrenList]
        )
      );
    }
    return [...mainCategoryList];
  }



}