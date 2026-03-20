// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: WebViewPage());
//   }
// }
//
// class WebViewPage extends StatefulWidget {
//   const WebViewPage({super.key});
//
//   @override
//   State<WebViewPage> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   InAppWebViewController? webViewController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('NekSolution Mobile Preview')),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: WebUri("https://neksolution.com")),
//         onWebViewCreated: (controller) {
//           webViewController = controller;
//           InAppWebViewController.setWebContentsDebuggingEnabled(true);
//         },
//       ),
//       bottomNavigationBar: ConvexAppBar(
//         items: const [
//           TabItem(icon: Icons.home, title: 'Home'),
//           TabItem(icon: Icons.map, title: 'Discovery'),
//           TabItem(icon: Icons.add, title: 'Add'),
//           TabItem(icon: Icons.message, title: 'Message'),
//           TabItem(icon: Icons.people, title: 'Profile'),
//         ],
//         onTap: (i) => debugPrint('click index=$i'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1️⃣ Event: các hành động có thể xảy ra
abstract class CounterEvent {}
class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}

// 2️⃣ State: dữ liệu mà UI sẽ render
class CounterState {
  final int count;
  CounterState(this.count);
}

// 3️⃣ Bloc: nhận Event -> xử lý -> emit State mới
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<Increment>((event, emit) => emit(CounterState(state.count + 1)));
    on<Decrement>((event, emit) => emit(CounterState(state.count - 1)));
  }
}

// 4️⃣ UI: sử dụng BlocProvider và BlocBuilder
void main() {
  runApp(
    BlocProvider(
      create: (_) => CounterBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple BLoC Counter')),
        body: Center(
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Text(
                'Count: ${state.count}',
                style: const TextStyle(fontSize: 30),
              );
            },
          ),
        ),
        
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "inc",
              onPressed: () =>
                  context.read<CounterBloc>().add(Increment()),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "dec",
              onPressed: () =>
                  context.read<CounterBloc>().add(Decrement()),
              child: const Icon(Icons.remove),
            ),
          ],
        ),

      ),
    );
  }
}
