import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hue_dada/auth/view/auth_router.dart';
import 'package:hue_dada/auth/view/login_page.dart';
import 'package:hue_dada/auth/view/register_page.dart';
import 'package:hue_dada/home/view/create_home_page.dart';
import 'package:hue_dada/home/view/home_page.dart';
import 'package:hue_dada/home/view/home_router.dart';
import 'package:hue_dada/light/view/light_page.dart';
import 'package:hue_dada/room/view/create_light_page/create_light_router.dart';
import 'package:hue_dada/room/view/create_light_page/create_light_select_icon_page.dart';
import 'package:hue_dada/room/view/create_light_page/create_light_write_name_page.dart';
import 'package:hue_dada/room/view/create_room_page/create_room_router.dart';
import 'package:hue_dada/room/view/create_room_page/create_room_select_icon_page.dart';
import 'package:hue_dada/room/view/create_room_page/create_room_write_name_page.dart';
import 'package:hue_dada/room/view/room_page.dart';
import 'package:hue_dada/room/view/room_router.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/home',
          page: HomeRouterRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: '',
              page: HomeRoute.page,
            ),
            AutoRoute(
              path: 'create-home',
              page: CreateHomeRoute.page,
            ),
            AutoRoute(
              path: 'room',
              page: RoomRouterRoute.page,
              children: [
                AutoRoute(
                  initial: true,
                  path: '',
                  page: RoomRoute.page,
                ),
                AutoRoute(
                  path: 'create-room',
                  page: CreateRoomRouterRoute.page,
                  children: [
                    AutoRoute(
                      initial: true,
                      path: 'select-icon',
                      page: CreateRoomSelectIconRoute.page,
                    ),
                    AutoRoute(
                      path: 'write-name',
                      page: CreateRoomWriteNameRoute.page,
                    ),
                  ],
                ),
                AutoRoute(
                  path: 'light',
                  page: LightRoute.page,
                ),
                AutoRoute(
                  path: 'create-light',
                  page: CreateLightRouterRoute.page,
                  children: [
                    AutoRoute(
                      initial: true,
                      path: 'select-icon',
                      page: CreateLightSelectIconRoute.page,
                    ),
                    AutoRoute(
                      path: 'write-name',
                      page: CreateLightWriteNameRoute.page,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        AutoRoute(
          initial: true,
          path: '/auth',
          page: AuthRouterRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: 'login',
              page: LoginRoute.page,
            ),
            AutoRoute(
              path: 'register',
              page: RegisterRoute.page,
            ),
          ],
        ),
      ];
}
