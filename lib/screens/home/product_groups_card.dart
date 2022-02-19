import 'package:flutter/material.dart';

// Models
import '../../models/category_model.dart';
// helpers
import '../../helpers/helpers.dart' as  helpers;

// dummy
import '../../dummy_data.dart' as dummy;
// Components
import './product_group_item.dart';


class ProductGroupsCard extends StatelessWidget {
  final Function changeTab;
  final List<MainCategoryModel> mainCategoryList;
  ProductGroupsCard({
    required this.changeTab,
    required this.mainCategoryList
  });

  // List<Map<String, String>> _dummyProductsGroupList = dummy.dummyProductGroupList;
  List<Map<String, String>> _dummyProductsGroupList = dummy.dummyProductGroupList;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  
  // imgList.map()

  Widget productGroupItem (
    String imageUrl
  ) {
    return Flexible(
      fit: FlexFit.tight,

      child: Container(
        color: Colors.green,

        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(
          vertical: 8
        ),

        child: InkWell(
          onTap: () {
            print('Item Tap');
          },  
          onHover: (isHover) {
            print(isHover);
          },
          onFocusChange: (isFocus) {
            print(isFocus);
          },
          onLongPress: () {
            print('Long Press');
          },


        // child: FlatButton(
        //   padding: EdgeInsets.zero,
        //   clipBehavior: Clip.hardEdge,
        //   hoverColor: Colors.pink,
        //   onPressed: () {
        //     print('Item Tap');
        //   },  



        // child: GestureDetector(
        //   behavior: HitTestBehavior.opaque,
        //   onTap: () {
        //     print('Item Tap');
        //   },          
          // behavior: HitTestBehavior.translucent,


        // child: FlatButton(
        //   padding: EdgeInsets.zero,                    
        //   hoverColor: Colors.red,
        //   onPressed: () {
        //     print('Item Press');
        //   },


          
          // splashColor: Colors.blue,
          // hoverColor: Colors.red,


          child: Column(
            children: <Widget>[

              // Image
              Container(
                padding: EdgeInsets.all(8.0),
                child: Image.network(
                  imageUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Text Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Product Group Text',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87
                    ),
                  ),
                  Icon(Icons.chevron_right)
                ],
              )

            ],
          ),
        ),
      )
    );
  }
  




  @override
  Widget build(BuildContext context) {
    // List<Widget> rowsList = [];
    // for( int i = 0; i< mainCategoryList.length; i++ ) {
    //   if(  i.remainder(2) == 0 && mainCategoryList.length >= i+2 ) {
    //     rowsList.add(
    //       Row(
    //         children: <Widget>[
    //           productGroupItem(
    //             helpers.imageUrlHelper(
    //               imageId: mainCategoryList[i].imageId
    //             )                
    //           ),
    //           productGroupItem(
    //             helpers.imageUrlHelper(
    //               imageId: mainCategoryList[i+1].imageId
    //             )  
    //           ),
              
    //         ],
    //       )
    //     );
    //   } else if( i.remainder(2) == 0 ) {
    //     rowsList.add(
    //       Row(
    //         children: <Widget>[
    //           productGroupItem(
    //             helpers.imageUrlHelper(
    //               imageId: mainCategoryList[i].imageId
    //             )  
    //           ),
    //         ],
    //       )
    //     );
    //   } 
    // }  
    // // end of for loop
    List<Widget> rowsList2 = [];
    for( int i = 0; i< mainCategoryList.length; i++ ) {
      if(  i.remainder(2) == 0 && mainCategoryList.length >= i+2 ) {
        rowsList2.add(
          Row(
            children: <Widget>[
              ProductGroupItem(
                imageUrl: helpers.imageUrlHelper(
                  imageId: mainCategoryList[i].imageId
                ),
                title: mainCategoryList[i].title,
                changeTab: this.changeTab,
                categoryId: mainCategoryList[i].id,
              ),
              ProductGroupItem(
                imageUrl: helpers.imageUrlHelper(
                  imageId: mainCategoryList[i+1].imageId
                ),
                title: mainCategoryList[i+1].title,
                changeTab: this.changeTab,
                categoryId: mainCategoryList[i+1].id,
              ),
              
              
            ],
          )
        );
      } else if( i.remainder(2) == 0 ) {
        rowsList2.add(
          Row(
            children: <Widget>[
              ProductGroupItem(
                imageUrl: helpers.imageUrlHelper(
                  imageId: mainCategoryList[i].imageId
                ),
                title: mainCategoryList[i].title,
                changeTab: this.changeTab,
                categoryId: mainCategoryList[i].id,
              ),
            ],
          )
        );
      } 
    }  // end of for loop


    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: rowsList2,
        ),
      )
      
    );
  }
}


    // return Flexible(
    //   fit: FlexFit.tight,
    //   child: Image.network(
    //     imageUrl,
    //     height: 200,
    //     fit: BoxFit.cover,
    //     // width: 50,
    //   ),



// Padding(
//         padding: EdgeInsets.all(12),
//         child: Container(
//           height: imgList.length * 50.0,
//           child: GridView.builder(
//             itemCount: imgList.length,
//             itemBuilder: ( _, index) => Image.network(
//                 imgList[index],
//                 height: 150,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//             ),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,            
//             ),
//           ),
//         ),
//       ),







// for( int i = 0; i< imgList.length; i++ ) {
//       if(  i.remainder(2) == 0 && imgList.length >= i+2 ) {
//         rowsList.add(
//           Row(
//             children: <Widget>[
//               Image.network(
//                 imgList[i],
//                 height: 50,
//                 width: 50,
//               ),
//               Image.network(
//                 imgList[i+1],
//                 height: 50,
//                 width: 50,
//               ),
//             ],
//           )
//         );
//       } else if( i.remainder(2) == 0 ) {
//         rowsList.add(
//           Row(
//             children: <Widget>[
//               Image.network(
//                 imgList[i],
//                 height: 50,
//                 width: 50,
//               ),
//             ],
//           )
//         );
//       } 
//     }  // end of for loop