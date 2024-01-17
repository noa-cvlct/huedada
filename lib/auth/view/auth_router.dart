import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/auth/bloc/auth_cubit.dart';
import 'package:hue_dada/auth/bloc/auth_state.dart';
import 'package:hue_dada/auth/bloc/login_cubit.dart';
import 'package:hue_dada/auth/bloc/register_cubit.dart';

@RoutePage()
class AuthRouterPage extends StatelessWidget {
  const AuthRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) => previous.error != current.error,
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(state.error!.message),
              ),
            );
          }
        },
        child: const AutoRouter(),
      ),
    );
  }
}
