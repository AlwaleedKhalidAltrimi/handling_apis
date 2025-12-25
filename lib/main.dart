import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/injection.dart';
import 'views/home_view.dart';
import 'cubit/user_cubit.dart';

void main() {
  initGetIt();
  runApp(const HandlingApis());
}

class HandlingApis extends StatelessWidget {
  const HandlingApis({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => getIt<UserCubit>(),
        child: HomeView(),
      ),
    );
  }
}
