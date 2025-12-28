import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/ui/utils.dart';
import 'package:movie_search/features/audiovisual/provider/audiovisual_provider.dart';

class ItemWatchProvidersView extends ConsumerWidget {
  final String type;
  final num id;

  const ItemWatchProvidersView({required this.type, required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchProviders = ref.watch(fetchWatchProviderProvider(id, type));
    return watchProviders.isLoading
        ? Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: LinearProgressIndicator())
        : watchProviders.hasError
        ? IconButton(
            onPressed: () {
              ref.invalidate(fetchWatchProviderProvider(id, type));
            },
            icon: Icon(Icons.update),
          )
        : !watchProviders.hasValue || watchProviders.value!.isEmpty
        ? Container()
        : ContentHorizontal(
            padding: 8,
            label: 'Disponible en',
            forceLight: true,
            subtitle: LogosWidget(
              list: watchProviders.value!.map((e) => MapEntry(e.providerName!, e.logoPath)).toList(),
            ),
          );
  }
}
