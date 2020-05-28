

class DrawerMenuItem {

  final String id;
  final String title;
  final String  parentId;    // if no parent this will be -2 "minus 2"

  DrawerMenuItem({
    this.id,
    this.title,
    this.parentId
  });
}



class TransformedDrawerMenuItem {
  final DrawerMenuItem drawerMenuItem;
  final bool hasChildren;
  final bool isSubItem;

  TransformedDrawerMenuItem({
    this.drawerMenuItem,
    this.hasChildren,
    this.isSubItem
  });

}