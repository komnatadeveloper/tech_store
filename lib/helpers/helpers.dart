


// It was not possible to convert data fetched by http library to List<Map<String, dynamic>>
// The method below achieves this problem
List<Map<String, dynamic>> convertListDynamicToListMap (List<dynamic> inputList) {
  List<Map<String, dynamic>> mappedList = [];
  inputList.forEach( (element) {
    Map<String, dynamic> item = {};
    for( final name in element.keys ) {
      item[name] = element[name];
    }
    mappedList.add({...item});
  });
  return mappedList;
}

