

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