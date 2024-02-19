import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/auth/bloc/auth_cubit.dart';
import 'package:hue_dada/auth/bloc/auth_state.dart';
import 'package:hue_dada/bluetooth/bloc/bluetooth_pairing_cubit.dart';
import 'package:hue_dada/bluetooth/repository/bluetooth_repository.dart';
import 'package:hue_dada/home/repository/home_repository.dart';

import 'firebase_options.dart';
import 'navigation/app_router.dart';

class GlobalBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('${bloc.runtimeType} $event', name: 'Test log');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('${bloc.runtimeType} $change', name: 'Test log');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('${bloc.runtimeType} $transition', name: 'Test log');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('${bloc.runtimeType} $error $stackTrace', name: 'Test log');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.signOut();

  Bloc.observer = GlobalBlocObserver();

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(),
        ),
        RepositoryProvider<BluetoothRepository>(
          create: (context) => BluetoothRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<BluetoothPairingCubit>(
            create: (context) => BluetoothPairingCubit(
              context.read<BluetoothRepository>(),
            )..startPairing(),
          ),
        ],
        child: BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) => previous.user != current.user,
          listener: (context, state) {
            if (state.user == null) {
              _appRouter.replace(const LoginRoute());
            } else {
              _appRouter.replace(const HomeRouterRoute());
            }
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Sora',
              brightness: Brightness.dark,
            ),
            routerConfig: _appRouter.config(),
          ),
        ),
      ),
    );
  }
}
