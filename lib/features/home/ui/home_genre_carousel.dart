import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/provider/genres_provider.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_list_view.dart';
import 'package:movie_search/features/home/provider/home_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeGenreCarousel extends HookConsumerWidget {
  const HomeGenreCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentTypeProvider = ref.watch(homeContentTypeProvider);

    if (contentTypeProvider.hasValue) {
      final genresProvider = ref.watch(genresByTypeProvider(contentTypeProvider.value!));

      if (genresProvider.hasValue) {
        final genres = genresProvider.value!;
        useEffect(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Aquí puedes acceder a ref.read o ref.watch
            ref.read(homeGenreCarouseSelectedProvider.notifier).updateSelectedGenre(genres.first);
          });
          return null;
        }, [genres]);

        return DefaultTabController(
          length: genres.length,
          initialIndex: 0,
          child: Builder(
            builder: (context) {
              DefaultTabController.of(context).addListener(() {
                final index = DefaultTabController.of(context).index;
                ref.read(homeGenreCarouseSelectedProvider.notifier).updateSelectedGenre(genres[index]);
              });
              return Column(
                children: [
                  ListTile(
                    title: Text('Explora ${contentTypeProvider.value!.nameSingular}s por generos', style: context.textTheme.titleLarge),
                  ),
                  Container(
                    color: context.theme.scaffoldBackgroundColor,
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: true,
                      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      // labelStyle: context.theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      tabAlignment: .start,
                      indicatorColor: context.colors.onPrimary,
                      indicator: BoxDecoration(
                        color: context.colors.primaryContainer,
                        borderRadius: .vertical(top: .circular(8))
                      ),
                      // unselectedLabelColor: context.theme.colorScheme.onPrimary,
                      automaticIndicatorColorAdjustment: false,
                      unselectedLabelStyle: context.theme.textTheme.titleSmall,
                      tabs: genres.map((e) => Tab(text: e.name)).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }
    }

    return Container();
  }
}

class HomeActualGenreCarousel extends ConsumerWidget with RouteAware {
  final int itemsCount = 5;

  HomeActualGenreCarousel({super.key});

  final controller = CarouselSliderControllerImpl();

  @override
  void didPushNext() {
    super.didPushNext();
    controller.stopAutoPlay();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    controller.startAutoPlay();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int columns = context.calculateColumns(itemWidth: 400, minValue: 1, maxValue: 5);

    return Builder(
      builder: (context) {
        final itemsProvider = ref.watch(itemsForActualGenreProvider);
        return itemsProvider.when(
          data: (data) {
            if (data.isEmpty) {
              return _buildPlaceholder(context);
            }
            final items = data
                .where((element) => element.backDropImage != null)
                .toList()
                .sublist(0, itemsCount)
                .map((item) => ItemGridCarousel(searchResult: item))
                .toList();
            return Container(
              color: context.colors.primaryContainer,
              child: CarouselSlider(
                items: items,
                carouselController: controller,
                options: CarouselOptions(
                  initialPage: 0,
                  viewportFraction: 1 / columns,
                  aspectRatio: 1.778 * columns,
                  enableInfiniteScroll: true,
                  disableCenter: true,
                  onPageChanged: (index, reason) {
                    // control.updateValue(index);
                  },
                  reverse: false,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            );
          },
          error: (error, stackTrace) => _buildPlaceholder(context),
          loading: () => _buildPlaceholder(context),
        );
      },
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    int columns = context.calculateColumns(itemWidth: 400, minValue: 1, maxValue: 5);
    return Container(
      color: context.colors.primaryContainer,
      child: AspectRatio(aspectRatio: 1.778 * columns),
    );
  }
}
