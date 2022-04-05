import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/nav_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(
    () => runApp(const App()),
    storage: storage,
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const title = 'GoRouter Example: Declarative Routes';

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => NavCubit(),
        child: Builder(builder: (context) {
          final _router = GoRouter(
            routes: [
              GoRoute(
                name: 'page1',
                path: '/',
                builder: (context, state) => const Page1Screen(),
              ),
              GoRoute(
                name: 'page2',
                path: '/page2',
                builder: (context, state) => const Page2Screen(),
              ),
            ],
            debugLogDiagnostics: true,
            redirect: (state) {
              context.read<NavCubit>().setPath(state.location);

              return null;
            },
            initialLocation: context.read<NavCubit>().state.path,
          );

          return MaterialApp.router(
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            title: title,
          );
        }),
      );
}

class Page1Screen extends StatelessWidget {
  const Page1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Page 1'),
              ElevatedButton(
                onPressed: () => context.goNamed('page2'),
                child: const Text('Go to page 2'),
              ),
            ],
          ),
        ),
      );
}

class Page2Screen extends StatelessWidget {
  const Page2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Page 2'),
              ElevatedButton(
                onPressed: () => context.goNamed('page1'),
                child: const Text('Go to page 1'),
              ),
            ],
          ),
        ),
      );
}
