
import 'package:flutter/foundation.dart';
// HTTP and convert
import 'package:http/http.dart' as http;
import 'dart:convert';
// constants
import '../constants/constants.dart' as constants;
// models
import '../models/category_model.dart';
import '../models/customer_model.dart';
import '../models/feature_model.dart';
// helpers
import '../helpers/helpers.dart' as helpers;

class CategoryProvider with ChangeNotifier {
  // from AuthState
  final String authToken;
  final CustomerModel customerModel;
  // Own Variables
  List<MainCategoryModel> _mainCategoryList;
  List<SpecialCategoryOnHomePageModel> _specialCategoryOnHomePageList;
  List<FeatureModel> _featureList = [];
  // Contructor
  CategoryProvider(
    this.authToken,
    this.customerModel,
    this._mainCategoryList,
    this._specialCategoryOnHomePageList,
    this._featureList
  );
  // Getters
  List<MainCategoryModel> get mainCategoryList {
    return [ ..._mainCategoryList ];
  }
  List<SpecialCategoryOnHomePageModel> get specialCategoryOnHomePageList {
    return [ ..._specialCategoryOnHomePageList ];
  }
  List<FeatureModel> get featureList {
    return [ ..._featureList ];
  }

  // ---------- Methods ----------

  void resetCategoryProvider () {
    _mainCategoryList = [];
    _specialCategoryOnHomePageList = [];
    _featureList = [];
    notifyListeners();
  }  // End of resetCategoryProvider


  Future<void> fetchFeatureList () async {
    print('CategoryProvider -> fetchFeatureList FIRED ->');
    final url = '${constants.apiUrl}/api/customer/feature';
    try {
      final res = await http.get(
        url,
        headers: {
          'token': authToken,
          'Content-Type': 'application/json'
        },        
      ); 
      final  extractedData = json.decode(res.body ) as List<dynamic>;
      print('CategoryProvider -> fetchFeatureList -> extractedData ->');
      print(extractedData);
      final rawFeatureData = helpers.convertListDynamicToListMap(extractedData);
      if( rawFeatureData.length > 0 ) {
        for( int i = 0; i <  rawFeatureData.length; i++ ) {
          var tempFeatureItem = FeatureModel(
            featureType: rawFeatureData[i]['featureType'] as String,
            imageId: rawFeatureData[i]['imageId'] as String,
          );
          switch( tempFeatureItem.featureType ) {
            case  'category':
              tempFeatureItem.categoryId = rawFeatureData[i]['categoryId'];
              break;
            case  'categoryWithBrand':
              tempFeatureItem.categoryId = rawFeatureData[i]['categoryId'];
              tempFeatureItem.brand = rawFeatureData[i]['brand'];
              break;
            case  'product':
              tempFeatureItem.productId = rawFeatureData[i]['productId'];
              break;
            default:
              break;
          }
          _featureList.add(tempFeatureItem);
        }
      }
      notifyListeners();
    } catch ( err ) {
      print(err);
    }
  } //  End of fetchFeatureList


  Future<void> fetchCategoryList () async {
    print('CategoryProvider -> fetchCategoryList FIRED ->');
    print( authToken );
    final url = '${constants.apiUrl}/api/customer/categories';
    print('url ->');
    print(url);
    try {
      final res = await http.get(
        url,
        headers: {
          'token': authToken,
          'Content-Type': 'application/json'
        }, 
      );
      final  extractedData = json.decode(res.body ) as List<dynamic>;
      var mappedList = helpers.convertListDynamicToListMap(extractedData);
      _mainCategoryList = handleTransformRawCategory(mappedList);
      _specialCategoryOnHomePageList = handleTransformRawSpecialCategory(mappedList);
      notifyListeners();
    } catch (err) {
      print(err);
    }
  } // End of fetchCategoryList


  List<MainCategoryModel> handleTransformRawCategory (List<Map<String, dynamic>> rawCategory) {
    final mainRawCategoryList = rawCategory.where((element) => element['isMainCategory'] == true).toList();
    final secondLevelRawCategoryList = rawCategory.where((element) => element['isSecondLevelCategory'] == true).toList();
    final thirdLevelRawCategoryList = rawCategory.where(
      (element) => element['isThirdLevelCategory'] == true
    ).toList();
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
      }  // End of interior for loop
      mainCategoryList.add(
        MainCategoryModel(
          title: mainRawCategoryList[i]['title'],
          id: mainRawCategoryList[i]['_id'],
          imageId: mainRawCategoryList[i]['imageId'],
          isSpecial: mainRawCategoryList[i]['isSpecial'],
          childrenList: [...secondChildrenList]
        )
      );
    } // End of exterior for loop
    return [...mainCategoryList];
  } // End of handleTransformRawCategory


  List<SpecialCategoryOnHomePageModel> handleTransformRawSpecialCategory (List<Map<String, dynamic>> rawCategory) {
    final specialOnHomePageRawCategoryList = rawCategory.where(
      (element) => element['showOnHomePage'] == true
      && element['isSpecial'] == true
    ).toList();
    List<SpecialCategoryOnHomePageModel>  tempSpecialList  = [];
    for( int i = 0; i < specialOnHomePageRawCategoryList.length; i++ ) {
      tempSpecialList.add(
        SpecialCategoryOnHomePageModel(
          id: specialOnHomePageRawCategoryList[i]['_id'],
          imageId: specialOnHomePageRawCategoryList[i]['imageId'],
          isSpecial:  specialOnHomePageRawCategoryList[i]['isSpecial'],
          title:  specialOnHomePageRawCategoryList[i]['title'],
        )
      );
    }
    return [ ...tempSpecialList ];
  } // End of handleTransformRawSpecialCategory



} // End of CategoryProvider