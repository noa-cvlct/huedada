import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/auth/bloc/auth_cubit.dart';
import 'package:hue_dada/auth/bloc/login_cubit.dart';
import 'package:hue_dada/navigation/app_router.dart';
import 'package:hue_dada/widgets/gradient_button.dart';
import 'package:hue_dada/widgets/input_field.dart';
import 'package:hue_dada/widgets/loading_dialog.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStateStatus.requestLogin) {
          authCubit.login(state.email, state.password);
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<LoginCubit>(context);

        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Column(
                    children: [
                      const SizedBox(height: 156),
                      Text(
                        'Login',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      const SizedBox(height: 56),
                      InputField(
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: cubit.emailChanged,
                        error: state.emailError?.message,
                      ),
                      const SizedBox(height: 32),
                      InputField(
                        label: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: cubit.passwordChanged,
                        error: state.passwordError?.message,
                        obscureText: state.obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: cubit.toggleObscurePassword,
                        ),
                      ),
                      const SizedBox(height: 56),
                      GradientButton(
                        backgroundGradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue,
                            Colors.pink,
                          ],
                        ),
                        innerPadding: const EdgeInsets.symmetric(
                          horizontal: 56,
                          vertical: 16,
                        ),
                        onPressed: cubit.checkForm,
                        child: const Text('Login'),
                      ),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).push(const RegisterRoute());
                        },
                        child: const Text('Register'),
                      ),
                      const SizedBox(height: 56),
                    ],
                  ),
                ),
              ),
              if (state.status == LoginStateStatus.requestLogin)
                const LoadingDialog(),
            ],
          ),
        );
      },
    );
  }
}
