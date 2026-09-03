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
  late final TextEditingController controller;
  late final TextEditingController passController;

  bool obscurePass = true;

  @override
  void initState() {
    bloc = injection.get<HomeBloc>();
    bloc.add(HomeEventGetBreed());
    controller = TextEditingController();
    passController = TextEditingController();
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
                TextFormField(
                  controller: controller,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    suffixIcon: controller.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                controller.clear();
                              });
                            },
                            icon: Icon(Icons.close),
                          ),
                  ),
                ),
                TextFormField(
                  controller: passController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  obscureText: obscurePass,
                  decoration: InputDecoration(
                    suffixIcon: obscurePass
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePass = !obscurePass;
                              });
                            },
                            icon: Icon(Icons.visibility),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePass = !obscurePass;
                              });
                            },
                            icon: Icon(Icons.visibility_off),
                          ),
                  ),
                ),
                if (F.isDev)
                  ListTile(title: Text('Card que só habilita como dev')),
                Text(state.breed.name),
                Text(state.breed.origin),
                Text(state.breed.temperament),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(title: Text('Minha Dialog'));
                      },
                    );
                  },
                  child: Text('Abrir dialog'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Aqui snackbar')));
                  },
                  child: Text('Chamar Snackbar'),
                ),
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
