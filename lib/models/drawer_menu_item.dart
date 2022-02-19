

class DrawerMenuItem {

  final String id;
  final String title;
  final String  parentId;    // if no parent this will be -2 "minus 2"

  DrawerMenuItem({
    required this.id,
    required this.title,
    required this.parentId
  });
}



class TransformedDrawerMenuItem {
  final DrawerMenuItem drawerMenuItem;
  final bool hasChildren;
  final bool isSubItem;

  TransformedDrawerMenuItem({
    required this.drawerMenuItem,
    required this.hasChildren,
    required this.isSubItem
  });

}