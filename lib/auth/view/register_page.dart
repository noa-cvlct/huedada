import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hue_dada/auth/bloc/auth_cubit.dart';
import 'package:hue_dada/auth/bloc/register_cubit.dart';
import 'package:hue_dada/widgets/gradient_button.dart';
import 'package:hue_dada/widgets/input_field.dart';
import 'package:hue_dada/widgets/loading_dialog.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final cubit = BlocProvider.of<RegisterCubit>(context);

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state.status == RegisterStateStatus.requestRegister) {
          await authCubit.register(state.email, state.password);
          cubit.resetStatus();
        }
      },
      builder: (context, state) {
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
                        'Register',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.teal.shade200,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      const SizedBox(height: 56),
                      InputField(
                        label: 'Email',
                        onChanged: cubit.emailChanged,
                        keyboardType: TextInputType.emailAddress,
                        error: state.emailError?.message,
                      ),
                      const SizedBox(height: 32),
                      InputField(
                        label: 'Password',
                        onChanged: cubit.passwordChanged,
                        keyboardType: TextInputType.visiblePassword,
                        error: state.passwordError?.message,
                        obscureText: state.obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: cubit.toggleObscurePassword,
                        ),
                      ),
                      const SizedBox(height: 32),
                      InputField(
                        label: 'Confirm Password',
                        onChanged: cubit.confirmPasswordChanged,
                        keyboardType: TextInputType.visiblePassword,
                        error: state.confirmPasswordError?.message,
                        obscureText: state.obscurePassword,
                      ),
                      const SizedBox(height: 56),
                      GradientButton(
                        backgroundGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue,
                            Colors.teal.shade200,
                          ],
                        ),
                        innerPadding: const EdgeInsets.symmetric(
                          horizontal: 56,
                          vertical: 16,
                        ),
                        onPressed: cubit.checkForm,
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.status == RegisterStateStatus.requestRegister)
                const LoadingDialog(),
            ],
          ),
        );
      },
    );
  }
}
