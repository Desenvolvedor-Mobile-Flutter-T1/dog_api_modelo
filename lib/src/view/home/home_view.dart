import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerencia_estado_injecao_dependencia/core/app_injection.dart';
import 'package:gerencia_estado_injecao_dependencia/flavors.dart';
import 'package:gerencia_estado_injecao_dependencia/src/blocs/home/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeBloc bloc;

  @override
  void initState() {
    bloc = injection.get<HomeBloc>();
    bloc.add(HomeEventGetBreed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flavors: ${F.title}')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is HomeSuccess) {
            return Column(
              children: [
                if (F.isDev)
                  ListTile(title: Text('Card que só habilita como dev')),
                Text(state.breed.name),
                Text(state.breed.origin),
                Text(state.breed.temperament),
              ],
            );
          }
          if (state is HomeError) {
            return Text(state.message);
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
