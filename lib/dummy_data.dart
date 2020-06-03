

import './models/drawer_menu_item.dart';


List<DrawerMenuItem> dummyDrawerMenuList = [
  DrawerMenuItem(
    id: '1',
    title: 'Computers & Tablets',
    parentId: '-2'
  ),
  DrawerMenuItem(
    id: '2',
    title: 'OEM - Peripheral Devices',
    parentId: '-2'
  ),
  DrawerMenuItem(
    id: '3',
    title: 'Gaming Products',
    parentId: '-2'
  ),
  DrawerMenuItem(
    id: '4',
    title: 'Office - Consumed Products',
    parentId: '-2'
  ),
  DrawerMenuItem(
    id: '5',
    title: 'Telephones',
    parentId: '-2'
  ),
  DrawerMenuItem(
    id: '6',
    title: 'Electronic Accesories',
    parentId: '-2'
  ),
  DrawerMenuItem(
    id: '7',
    title: 'Software',
    parentId: '-2'
  ),
  DrawerMenuItem(
    id: '8',
    title: 'Enterprise Products',
    parentId: '-2'
  ),
  DrawerMenuItem(
    id: '9',
    title: 'Security Systems',
    parentId: '-2'
  ),
  DrawerMenuItem(
    id: '10',
    title: 'Household Appliances',
    parentId: '-2'
  ),

  // Sub Items
    DrawerMenuItem(
    id: '11',
    title: 'Desktop',
    parentId: '1',
  ),
    DrawerMenuItem(
    id: '12',
    title: 'Portable Computers',
    parentId: '1',
  ),
    DrawerMenuItem(
    id: '13',
    title: 'Tablets',
    parentId: '1',
  ),
  // Sub Items
    DrawerMenuItem(
    id: '14',
    title: 'Storage Discs',
    parentId: '2',
  ),
    DrawerMenuItem(
    id: '15',
    title: 'Network',
    parentId: '2',
  ),
    DrawerMenuItem(
    id: '16',
    title: 'RAM',
    parentId: '2',
  ),
    DrawerMenuItem(
    id: '17',
    title: 'Mainboards',
    parentId: '2',
  ),
  // Gaming Sub Items
    DrawerMenuItem(
    id: '18',
    title: 'Gaming Notebook',
    parentId: '3',
  ),
    DrawerMenuItem(
    id: '19',
    title: 'Gaming Desktop',
    parentId: '3',
  ),
  // Office Consumed Products Sub items
    DrawerMenuItem(
    id: '20',
    title: 'Consumer Products',
    parentId: '4',
  ),
    DrawerMenuItem(
    id: '21',
    title: '3D Printer Equipments',
    parentId: '4',
  ),
  // Enterprise Sub items
    DrawerMenuItem(
    id: '22',
    title: 'Thin Client',
    parentId: '8',
  ),
    DrawerMenuItem(
    id: '23',
    title: 'Workstation',
    parentId: '8',
  ),
  // Security Sub items
    DrawerMenuItem(
    id: '24',
    title: 'AHD Security Systems',
    parentId: '9',
  ),
    DrawerMenuItem(
    id: '25',
    title: 'IP - Network CCTV Systems',
    parentId: '9',
  ),

  //  Droppable Items
      DrawerMenuItem(
    id: '26',
    title: 'Notebooks',
    parentId: '12',
  ),
    DrawerMenuItem(
    id: '27',
    title: 'Two-in-One',
    parentId: '12',
  ),
    DrawerMenuItem(
    id: '28',
    title: 'Notebook Accessories',
    parentId: '12',
  ),

  DrawerMenuItem(
    id: '29',
    title: 'TEST1',
    parentId: '13',
  ),
    DrawerMenuItem(
    id: '30',
    title: 'TEST2',
    parentId: '13',
  ),
  DrawerMenuItem(
    id: '31',
    title: 'TEST1',
    parentId: '13',
  ),
    DrawerMenuItem(
    id: '32',
    title: 'TEST2',
    parentId: '13',
  ),
  DrawerMenuItem(
    id: '33',
    title: 'TEST1',
    parentId: '13',
  ),
    DrawerMenuItem(
    id: '34',
    title: 'TEST2',
    parentId: '13',
  ),
  DrawerMenuItem(
    id: '35',
    title: 'TEST1',
    parentId: '13',
  ),
    DrawerMenuItem(
    id: '36',
    title: 'TEST2',
    parentId: '13',
  ),
  DrawerMenuItem(
    id: '37',
    title: 'TEST1',
    parentId: '13',
  ),
    DrawerMenuItem(
    id: '38',
    title: 'TEST2',
    parentId: '13',
  ),
  DrawerMenuItem(
    id: '39',
    title: 'TEST1',
    parentId: '13',
  ),
    DrawerMenuItem(
    id: '40',
    title: 'TEST2',
    parentId: '13',
  ),
  DrawerMenuItem(
    id: '41',
    title: 'TEST1',
    parentId: '13',
  ),
    DrawerMenuItem(
    id: '42',
    title: 'TEST2',
    parentId: '13',
  ),
  DrawerMenuItem(
    id: '43',
    title: 'TEST1',
    parentId: '13',
  ),
    DrawerMenuItem(
    id: '44',
    title: 'TEST2',
    parentId: '13',
  ),

  
  
];

  // DrawerMenuItem(
  //   id: '1',
  //   title: 'Computers & Tablets',
  //   parentId: '-2'
  // ),




var   dummySampleProductDetailsItem = {
  'imageUrlList' : [
    'https://warungkomputer.com/wp-content/uploads/2019/02/iStock_000005414770Medium1.jpg',
    'https://3.bp.blogspot.com/-bgaRxVcT7gM/VITRlmiLstI/AAAAAAAAAbw/B-7WHpQUTV0/s1600/Merawat%2BKomputer.jpg',
    'https://impuls-it.ru/upload/iblock/572/2a9/1.jpg'
  ],
  'brand': 'Lenovo',
  'productNo': '90LX004DTX',
  'keyProperties': '510S CI5 2.90 GHz 9400F 4GB 256GB SSD Ubuntu',
  'specifications': [
    {'Processor Family': 'Intel CI5'},
    {'Processor Model': 'Intel CI5-9100 3.6GHz'},
    {'Screen Size': '15.6"' },
    {'Screen Resolution': '1920x1080'},
    {'Operating System': 'Ubuntu'},
    {'Optical Readers': 'None'},
    {'Webcam': 'Exists'},
    {'Wi-Fi': 'Exists'},
    {'Warranty': '2 Years'}
  ],
  'price': 485.25,
  'stockStatus': '5'
};




var dummyProductList = [
  {
    'id': '150',
    'brand': 'Dell',
    'productNo': 'N109VD3670BTO_UBU',
    'keyProperties': 'Vostro 3670 CI5 2.90 GHz 8400 4GB 1TB HDD Ubuntu',
    'imageUrl': 'https://www.vladtime.ru/uploads/posts/2016-04/1460473513_1.jpg',
    'price': 455.85
  },
  {
    'id': '151',
    'brand': 'Dell',
    'productNo': '5070MT9700',
    'keyProperties': 'OptiPlex 5070 CI7 4.70 GHz 9700 32GB 1TB HDD + 512GB SSD  Win 10 Pro',
    'imageUrl': 'https://im0-tub-ru.yandex.net/i?id=e7b02a9dd42ca1583c7626473cdb43fc&n=13',
    'price': 1095.58
  },
  {
    'id': '152',
    'brand': 'Asus',
    'productNo': '90PD01J5-M06330',
    'keyProperties': 'M32CD 3670 CI5 2.70 GHz 6400 8GB GeForce GTX 950 1TB HDD Ubuntu',
    'imageUrl': 'https://best-practice.ru/itemimages/2aa307d6-b566-11e5-a110-001fc65a13f4/90PD01J5-M06330_001.jpg',
    'price': 750.85
  },
  {
    'id': '153',
    'brand': 'Asus',
    'productNo': 'K20CD-DE032T',
    'keyProperties': '6098 CI3 3.60 GHz 6098 16GB GeForce GTX 720  1TB HDD Ubuntu',
    'imageUrl': 'https://i.simpalsmedia.com/999.md/BoardImages/900x900/821cc1967ab0a80930e0dad8923eda71.jpg',
    'price': 625.99
  },
  {
    'id': '154',
    'brand': 'Acer',
    'productNo': 'ES2730G',
    'keyProperties': 'Veriton ES2730G CI5 2.80 GHz 8400 8GB 128GB SDD Windows 10 Pro',
    'imageUrl': 'https://avatars.mds.yandex.net/get-pdb/1412649/9aa612f6-83b2-479e-843d-6aaac6468fa7/s1200',
    'price': 700.50
  },
];

var dummyProductGroupList = [
  {
    'imageUrl': 'https://avatars.mds.yandex.net/get-zen_doc/1875939/pub_5d0ba322b34feb00af5ddb26_5d0baae62d23ae00af68c06b/scale_1200',
    'title': 'Computers and Tablets'
  },
  {
    'imageUrl': 'https://banner2.cleanpng.com/20180605/hhr/kisspng-computer-keyboard-peripheral-dell-laptop-peripherals-5b1633d56028f8.3970810315281817173939.jpg',
    'title': 'OEM - Peripheral Devices'
  },
  {
    'imageUrl': 'https://avatars.mds.yandex.net/get-mpic/175985/img_id4454483274191757751/orig',
    'title': 'Gaming Products'
  },
  {
    'imageUrl': 'https://avatars.mds.yandex.net/get-pdb/1606385/4cb40823-ef2a-4155-a83e-b97ce7de4e45/s1200',
    'title': 'Printers'
  },
  {
    'imageUrl': 'https://i.simpalsmedia.com/999.md/BoardImages/900x900/3d4c5b8cde1dc7044e141cbc9fa6721a.jpg',
    'title': 'Office - Consumable Products'
  },
  {
    'imageUrl': 'http://4.bp.blogspot.com/-Sdg3pPdlXzc/U_SlKcCZc5I/AAAAAAAAAKw/euyG39STAlk/s1600/shutterstock_102382234-1024x1024.jpg',
    'title': 'Mobile Phones'
  },
];

var dummyMostPopularImageList = [
  'https://avatars.mds.yandex.net/get-mpic/1626700/img_id7735018695857307227.jpeg/orig',
  'https://bigbunce.ru/img/detail/1b0/1b0eaa0e569f94f3b14ed4c028364251.jpg',
  'https://tyumen-market.ru/images/tmnmart/pp/1454679971_542_1280.jpeg',
  'https://cdn1.ozone.ru/multimedia/1032105472.jpg',
  'https://www.lostelecom.ru/image/cache/catalog/product/3/ru-Pdb-40071118b1-1000x1000.jpg',
  'https://ae01.alicdn.com/kf/HTB1EYOodNiH3KVjSZPfq6xBiVXah/LeadingStar-ZLRC-Beast-SG906-5G-Wifi-GPS-FPV-Drone-with-4K-Camera.jpg'
];

var dummyFeaturesList = [
  'https://s.sellercheck.ru/pic/4f/c4/kotin-z2-igrovoy-pk-intel-i7-9700-k-gtx1060-6-4fc416e9f17cb06e8cbf3f7f5b71d6ba-500.jpg',
  'https://img.fasttechcdn.com/962/9625235/9625235-1.jpg',
  
  
];