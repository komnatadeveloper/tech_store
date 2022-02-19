
// constants
import '../constants/constants.dart' as constants;

// Models
import '../models/product.dart';


// It was not possible to convert data fetched by http library to List<Map<String, dynamic>>
// The method below achieves this problem
List<Map<String, dynamic>> convertListDynamicToListMap (List<dynamic> inputList) {
  // print('helpers -> convertListDynamicToListMap -> inputList ->');
  // print(inputList);
  List<Map<String, dynamic>> mappedList = [];
  inputList.forEach( (element) {
    Map<String, dynamic> item = {};
    for( final name in element.keys ) {
      item[name] = element[name];
    }
    mappedList.add({...item});
  });
  // print('helpers -> convertListDynamicToListMap -> mappedList ->');
  // print(mappedList);
  return mappedList;
}


List<String> convertDynamicToListString ( dynamic input ) {
  List tempList = input as List;
  List<String> list = [];
  for(int i = 0; i < tempList.length; i++) {
    list.add(
      tempList[i] as String
    );
  }
  return list;
}

String mainImageUrlHelper ({ required ProductModel productModel}) {
  return constants.apiUrl + '/api/product/images/' +  productModel.imageList.firstWhere(
    (element) => element.isMain
  ).imageId;
}

String imageUrlHelper  ({required String imageId }) {
  return constants.apiUrl + '/api/product/images/' + imageId;
}



