import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'drawer_expansion_tile.dart';
import 'drawer_simple_tile.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(bottom: 60),
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(top: 30),
              //height: Utils.getTextScaleFactor(context)*160,
              decoration: BoxDecoration(
                  color: const Color(0xFF061DDB),
              ),
              child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        color: Colors.transparent,
                        width: 50,
                        child: SvgPicture.asset(
                          'assets/images/avatar.svg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //SizedBox(height: Utils.getTextScaleFactor(context)*5,),
                    const Text(
                      'مهمان',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'IranSans',
                      ),
                    ),
                  ]
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.check_circle,
              size: 23,
            ),
            title: const Text(
              'داشبورد',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'IranSans',
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.check_circle,
              size: 23,
            ),
            title: const Text(
              'مدیریت برنامه ها',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'IranSans',
              ),
            ),
            onTap: () {},
          ),
          ExpansionTile(
            title: const Text(
              'مدیریت بلیط ها',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'IranSans',
              ),
            ),
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'پیگیری بلیط',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'رزرو',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'ابطال',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'استرداد',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'مدیریت مالی',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'IranSans',
              ),
            ),
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'درخواست تسویه حساب',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'حساب های بانکی',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'مدیریت کاربران',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'IranSans',
              ),
            ),
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'لیست کاربران',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'نقشها',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          ExpansionTile(
            title: const Text(
              'گزارشات',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'IranSans',
              ),
            ),
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'گزارش فروش تفریحات',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  size: 23,
                ),
                title: const Text(
                  'گزارش تراکنش ها',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'IranSans',
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 23,
            ),
            title: const Text(
              'خروج',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'IranSans',
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
