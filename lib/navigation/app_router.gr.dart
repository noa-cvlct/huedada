// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthRouterPage(),
      );
    },
    CreateHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateHomePage(),
      );
    },
    CreateLightRouterRoute.name: (routeData) {
      final args = routeData.argsAs<CreateLightRouterRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateLightRouterPage(
          key: args.key,
          roomId: args.roomId,
        ),
      );
    },
    CreateLightSelectIconRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateLightSelectIconPage(),
      );
    },
    CreateLightWriteNameRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateLightWriteNamePage(),
      );
    },
    CreateRoomRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateRoomRouterPage(),
      );
    },
    CreateRoomSelectIconRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateRoomSelectIconPage(),
      );
    },
    CreateRoomWriteNameRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateRoomWriteNamePage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    HomeRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeRouterPage(),
      );
    },
    LightRoute.name: (routeData) {
      final args = routeData.argsAs<LightRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LightPage(
          key: args.key,
          roomId: args.roomId,
          lightId: args.lightId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
    RoomRoute.name: (routeData) {
      final args = routeData.argsAs<RoomRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RoomPage(
          key: args.key,
          roomId: args.roomId,
        ),
      );
    },
    RoomRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RoomRouterPage(),
      );
    },
  };
}

/// generated route for
/// [AuthRouterPage]
class AuthRouterRoute extends PageRouteInfo<void> {
  const AuthRouterRoute({List<PageRouteInfo>? children})
      : super(
          AuthRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateHomePage]
class CreateHomeRoute extends PageRouteInfo<void> {
  const CreateHomeRoute({List<PageRouteInfo>? children})
      : super(
          CreateHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateLightRouterPage]
class CreateLightRouterRoute extends PageRouteInfo<CreateLightRouterRouteArgs> {
  CreateLightRouterRoute({
    Key? key,
    required String roomId,
    List<PageRouteInfo>? children,
  }) : super(
          CreateLightRouterRoute.name,
          args: CreateLightRouterRouteArgs(
            key: key,
            roomId: roomId,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateLightRouterRoute';

  static const PageInfo<CreateLightRouterRouteArgs> page =
      PageInfo<CreateLightRouterRouteArgs>(name);
}

class CreateLightRouterRouteArgs {
  const CreateLightRouterRouteArgs({
    this.key,
    required this.roomId,
  });

  final Key? key;

  final String roomId;

  @override
  String toString() {
    return 'CreateLightRouterRouteArgs{key: $key, roomId: $roomId}';
  }
}

/// generated route for
/// [CreateLightSelectIconPage]
class CreateLightSelectIconRoute extends PageRouteInfo<void> {
  const CreateLightSelectIconRoute({List<PageRouteInfo>? children})
      : super(
          CreateLightSelectIconRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateLightSelectIconRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateLightWriteNamePage]
class CreateLightWriteNameRoute extends PageRouteInfo<void> {
  const CreateLightWriteNameRoute({List<PageRouteInfo>? children})
      : super(
          CreateLightWriteNameRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateLightWriteNameRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateRoomRouterPage]
class CreateRoomRouterRoute extends PageRouteInfo<void> {
  const CreateRoomRouterRoute({List<PageRouteInfo>? children})
      : super(
          CreateRoomRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateRoomRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateRoomSelectIconPage]
class CreateRoomSelectIconRoute extends PageRouteInfo<void> {
  const CreateRoomSelectIconRoute({List<PageRouteInfo>? children})
      : super(
          CreateRoomSelectIconRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateRoomSelectIconRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateRoomWriteNamePage]
class CreateRoomWriteNameRoute extends PageRouteInfo<void> {
  const CreateRoomWriteNameRoute({List<PageRouteInfo>? children})
      : super(
          CreateRoomWriteNameRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateRoomWriteNameRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeRouterPage]
class HomeRouterRoute extends PageRouteInfo<void> {
  const HomeRouterRoute({List<PageRouteInfo>? children})
      : super(
          HomeRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LightPage]
class LightRoute extends PageRouteInfo<LightRouteArgs> {
  LightRoute({
    Key? key,
    required String roomId,
    required String lightId,
    List<PageRouteInfo>? children,
  }) : super(
          LightRoute.name,
          args: LightRouteArgs(
            key: key,
            roomId: roomId,
            lightId: lightId,
          ),
          initialChildren: children,
        );

  static const String name = 'LightRoute';

  static const PageInfo<LightRouteArgs> page = PageInfo<LightRouteArgs>(name);
}

class LightRouteArgs {
  const LightRouteArgs({
    this.key,
    required this.roomId,
    required this.lightId,
  });

  final Key? key;

  final String roomId;

  final String lightId;

  @override
  String toString() {
    return 'LightRouteArgs{key: $key, roomId: $roomId, lightId: $lightId}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RoomPage]
class RoomRoute extends PageRouteInfo<RoomRouteArgs> {
  RoomRoute({
    Key? key,
    required String roomId,
    List<PageRouteInfo>? children,
  }) : super(
          RoomRoute.name,
          args: RoomRouteArgs(
            key: key,
            roomId: roomId,
          ),
          initialChildren: children,
        );

  static const String name = 'RoomRoute';

  static const PageInfo<RoomRouteArgs> page = PageInfo<RoomRouteArgs>(name);
}

class RoomRouteArgs {
  const RoomRouteArgs({
    this.key,
    required this.roomId,
  });

  final Key? key;

  final String roomId;

  @override
  String toString() {
    return 'RoomRouteArgs{key: $key, roomId: $roomId}';
  }
}

/// generated route for
/// [RoomRouterPage]
class RoomRouterRoute extends PageRouteInfo<void> {
  const RoomRouterRoute({List<PageRouteInfo>? children})
      : super(
          RoomRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoomRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
