import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/features/audiovisual/provider/audiovisual_provider.dart';

class ImdbRatingView extends ConsumerWidget {
  final String? imdbId;
  final num tmdbId;
  final String type;

  const ImdbRatingView(this.tmdbId, this.type, {super.key, required this.imdbId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(fetchImdbRatingProvider(tmdbId, type, imdbId));

    if (rating.hasError || !rating.hasValue || rating.value == null || rating.value == 0 || rating.value == -1) {
      return Container();
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.zero, color: context.colors.onSurface),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // color: Color(0xFFF5C300), // amarillo IMDb
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            width: 64,
            decoration: BoxDecoration(
              color: Color(0xFFF5C300),
              image: DecorationImage(
                image: AssetImage('assets/images/imdb-flat.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              !rating.hasValue
                  ? ''
                  : rating.value! >= 0
                  ? '${rating.value?.toStringAsFixed(1)}'
                  : 'N/A',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: context.colors.surface, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentRatingView extends ConsumerWidget {
  final num id;
  final TMDB_API_TYPE type;

  const ContentRatingView(this.id, this.type, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(fetchContentRatingsProvider(id, type.type));
    if (model.hasError || !model.hasValue || model.value!.results.isEmpty) {
      return SizedBox.shrink();
    }

    return Chip(
      backgroundColor: Colors.transparent,
      onDeleted: model.hasError ? () => ref.invalidate(fetchContentRatingsProvider(id, type.type)) : null,
      deleteIcon: model.isLoading
          ? CircularProgressIndicator(strokeWidth: 1)
          : model.hasError
          ? Icon(Icons.refresh)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: context.theme.dividerColor),
      ),
      label: Text(model.value!.results.first.rating ?? '-'),
    );
  }
}

class ContentVoteAverageView extends StatelessWidget {
  final num? voteAverage;
  
  const ContentVoteAverageView({super.key, required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    if (voteAverage == null || voteAverage! < 0 || voteAverage! > 10) {
      return Container();
    }

    double percentage = voteAverage! / 10.0;

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(60, 60),
            painter: CircularProgressPainter(voteAverage!),
          ),
          Text(
            voteAverage!.toStringAsFixed(1),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final num voteAverage;

  CircularProgressPainter(this.voteAverage);

  @override
  void paint(Canvas canvas, Size size) {
    Color color;
    if (voteAverage >= 7) {
      color = Colors.green;
    } else if (voteAverage >= 5) {
      color = Colors.yellow;
    } else {
      color = Colors.red;
    }

    double percentage = voteAverage / 10.0;

    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = (size.width / 2) - 4; // Adjust for border and stroke
    Offset center = Offset(size.width / 2, size.height / 2);
    double startAngle = -pi / 2; // Start from top
    double sweepAngle = 2 * pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}