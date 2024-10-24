import 'package:supertec_app_clean_code/utils/new_all_imports.dart';

class FutureBuilderComponent<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      builder;

  const FutureBuilderComponent({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return builder(context, snapshot);
        }
      },
    );
  }
}
