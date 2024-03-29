import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './search_product_item.dart';
import '../../models/product.dart';
// Provider
import '../../providers/product_provider.dart';



import '../../dummy_data.dart' as dummy;


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}


// -------------------  STATE  -------------------------
class _SearchScreenState extends State<SearchScreen> {

  List<ProductModel> _productList = [];

  List<ProductModel> handleProductListInit () {
    List<ProductModel> tempList = [];
    List<Map<String, dynamic>> dummyProductList = dummy.dummyProductList;
    dummyProductList.forEach(
      (rawItem)  {
        String? id;
        String? brand;
        String? productNo;
        String? keyProperties;
        String? imageUrl;
        double? price;
        for(final name in rawItem.keys) {
          // print(name);
          // print(rawItem[name]);
          
          switch (name) {
            case  'id':
              id = rawItem[name]!;
              break;
            case  'brand':
              brand = rawItem[name]!;
              break;
            case  'productNo':
              productNo = rawItem[name]!;
              break;
            case  'keyProperties':
              keyProperties = rawItem[name]!;
              break;
            case  'imageUrl':
              imageUrl = rawItem[name]!;
              break;
            case  'price':
              // price = double.parse(rawItem[name]);
              price = rawItem[name];
              break;
            default:
          }
          
        }
        print(id);
        print(brand);
        print(keyProperties);
        print(productNo);
        print(imageUrl);
        print(price);

        // tempList.add(
        //   ProductModel(
        //     id: id,
        //     brand: brand,
        //     keyProperties: keyProperties,
        //     productNo: productNo,
        //     imageUrl: imageUrl,
        //     price: price
        //   )
        // );


        //------------------------------------------------------- 
        //-------------------------------------------------------

      }
    ); 
    return tempList;   
  }

  @override
  void initState() {
    // setState(() {
    //   _productList = handleProductListInit();
    // });
    
    // TODO: implement initState
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _productList = Provider.of<ProductProvider>(context).searchedProductsList;
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    if(Provider.of<ProductProvider>(context).isLoadingProducts) {
      return Center(child: CircularProgressIndicator(),);
    }
    return Container ( 
      height: double.infinity,
      color: Colors.grey[400],      
      child: ListView.builder(
        itemCount: _productList.length,
        itemBuilder: (ctx, index) => SearchProductItem(
          productModel: _productList[index],
          isFirstItem: index == 0 ? true : false,
          isLastItem: index == _productList.length-1 ? true : false,
          
        )
      ),
       
    );
  }
}