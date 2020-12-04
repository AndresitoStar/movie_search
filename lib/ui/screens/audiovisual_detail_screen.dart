import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';
import 'package:provider/provider.dart';

import '../widgets/default_image.dart';

class AudiovisualDetail extends StatefulWidget {
  final bool trending;

  const AudiovisualDetail({Key key, this.trending}) : super(key: key);

  @override
  _AudiovisualDetailState createState() => _AudiovisualDetailState();
}

class _AudiovisualDetailState extends State<AudiovisualDetail> {
  AudiovisualProvider audiovisualProvider;

  @override
  void initState() {
    super.initState();
    audiovisualProvider =
        Provider.of<AudiovisualProvider>(context, listen: false);
    Future.delayed(Duration(milliseconds: 100), () async {
      await audiovisualProvider.findMyData(context);
      audiovisualProvider.toggleDateReg(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        top: true,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: getAppBar(context),
                ),
              )
            ],
            body: Container(
//            color: Colors.white,
              child: CustomScrollView(
                slivers: <Widget>[getContent()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding getContent() => SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Consumer<AudiovisualProvider>(
                builder: (context, audiovisualProvider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'title-${audiovisualProvider.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          audiovisualProvider.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: audiovisualProvider.data != null,
                      child: ListTile(
                        title: Text(
                            '${audiovisualProvider.data?.anno} / ${audiovisualProvider.data?.genre}'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.imdb,
                              color: Colors.orange, size: 60),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                audiovisualProvider.data?.score ??
                                    '${audiovisualProvider.voteAverage ?? ''}',
                                style: Theme.of(context).textTheme.headline4),
                          ),
                          Expanded(child: Container()),
                          likeButton(context),
                        ],
                      ),
                    ),
                    audiovisualProvider.data == null
                        ? LinearProgressIndicator()
                        : Container(),
                    AudiovisualContentHorizontal(
                        content: audiovisualProvider.data?.sinopsis),
                    AudiovisualContentRow(
                      label1: 'Pais',
                      label2: 'Idioma',
                      value1: audiovisualProvider.data?.pais,
                      value2: audiovisualProvider.data?.idioma,
                    ),
                    ContentDivider(value: audiovisualProvider.data?.director),
                    AudiovisualContentHorizontal(
                        label: 'Director',
                        content: audiovisualProvider.data?.director),
                    AudiovisualContentRow(
                      label1: 'Temporadas',
                      label2: 'Capitulos',
                      value1: audiovisualProvider.data?.temp,
                      value2: audiovisualProvider.data?.capitulos,
                    ),
                    AudiovisualContentRow(
                      label1: 'Año',
                      label2: 'Duración',
                      value1: audiovisualProvider.data?.anno,
                      value2: audiovisualProvider.data?.duracion != null
                          ? '${audiovisualProvider.data?.duracion} minutos'
                          : null,
                    ),
                    ContentDivider(value: audiovisualProvider.data?.productora),
                    AudiovisualContentHorizontal(
                        label: 'Productora',
                        content: audiovisualProvider.data?.productora),
                    ContentDivider(value: audiovisualProvider.data?.reparto),
                    AudiovisualContentHorizontal(
                        label: 'Reparto',
                        content: audiovisualProvider.data?.reparto),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ));

  Future<bool> onLikeButtonTap(bool isLiked, BuildContext context) {
    final ScaffoldState scaffoldState =
        context.findRootAncestorStateOfType<ScaffoldState>();
    if (scaffoldState != null) {
      scaffoldState.showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(isLiked
            ? 'Eliminado de Mis Favoritos'
            : 'Agregado a Mis Favoritos'),
      ));
    }
    return audiovisualProvider.toggleFavourite(context: context);
  }

  SliverAppBar getAppBar(BuildContext context) => SliverAppBar(
        pinned: false,
        floating: true,
        elevation: 5,
        expandedHeight: MediaQuery.of(context).size.height /
            (MediaQuery.of(context).devicePixelRatio) *
            2,
        primary: true,
        automaticallyImplyLeading: false,
        actions: [
          Consumer<AudiovisualProvider>(
            builder: (context, value, child) => Visibility(
              visible: !audiovisualProvider.imageLoaded,
              child: IconButton(
                  icon: Icon(Icons.high_quality_rounded),
                  onPressed: () => audiovisualProvider.toggleLoadImage()),
            ),
          )
        ],
        leading: SizedBox(
          height: 12,
          width: 12,
          child: MyCircularButton(
            color: Colors.white24,
            icon: Icon(FrinoIcons.f_arrow_left, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
              background: Consumer<AudiovisualProvider>(
                  builder: (ctx, av, child) => Hero(
                        tag: '${widget.trending}${av.id}',
                        child: Material(
                          child: GestureDetector(
                            onTap: av.imageUrl != null
                                ? () => previewImageDialog(
                                      context,
                                      av.imageLoaded
                                          ? '$URL_IMAGE_BIG${av.imageUrl}'
                                          : '$URL_IMAGE_MEDIUM${av.imageUrl}',
                                    )
                                : null,
                            child: av.imageUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: av.imageLoaded
                                        ? '$URL_IMAGE_BIG${av.imageUrl}'
                                        : '$URL_IMAGE_MEDIUM${av.imageUrl}',
                                    color: Colors.black12,
                                    colorBlendMode: BlendMode.darken,
                                    placeholder: (_, __) => CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            '$URL_IMAGE_SMALL${av.imageUrl}'),
                                    errorWidget: (ctx, _, __) =>
                                        PlaceholderImage(
                                            height:
                                                MediaQuery.of(ctx).size.height *
                                                    0.6),
                                    fit: BoxFit.cover,
//                              height: double.infinity,
                                    width: double.infinity,
                                  )
                                : PlaceholderImage(
                                    height:
                                        MediaQuery.of(ctx).size.height * 0.6),
                          ),
                        ),
                      )),
            );
          },
        ),
      );

  Widget likeButton(BuildContext context) =>
      Consumer<AudiovisualProvider>(builder: (ctx, av, child) {
        final fav = av.data?.isFavourite ?? av.isFavourite ?? false;
        return IconButton(
          icon: Icon(fav ? FrinoIcons.f_heart : FrinoIcons.f_heart),
          iconSize: 32,
          color: fav ? Colors.red : Colors.grey,
          onPressed: () {
            return onLikeButtonTap(fav, context);
          },
        );
      });

  previewImageDialog(BuildContext context, String imageUrl) {
    showDialog(
        context: context,
        builder: (context) => MediaQuery.removeViewInsets(
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: AlertDialog(
                title: ListTile(
                  contentPadding: EdgeInsets.zero,
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white30,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 24,
                      color: Colors.black87,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                elevation: 0,
                backgroundColor: Colors.black54,
                content: Builder(builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  return Container(
                    height: height - 20,
                    width: double.infinity,
                    child: ExtendedImage.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                      //enableLoadState: false,
                      mode: ExtendedImageMode.gesture,
                      initGestureConfigHandler: (state) => GestureConfig(
                        minScale: 0.9,
                        animationMinScale: 0.7,
                        maxScale: 3.0,
                        animationMaxScale: 3.5,
                        speed: 1.0,
                        inertialSpeed: 100.0,
                        initialScale: 0.9,
                        inPageView: true,
                        initialAlignment: InitialAlignment.center,
                      ),
                    ),
                  );
                }),
              ),
            ));
  }
}

class ContentDivider extends StatelessWidget {
  const ContentDivider({
    Key key,
    @required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value != null && value.isNotEmpty && value != 'N/A',
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Divider(height: 1),
        ),
      ),
    );
  }
}

class AudiovisualContentRow extends StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  const AudiovisualContentRow(
      {Key key, this.value1, this.value2, this.label1, this.label2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: value1 != null && value2 != null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ContentDivider(value: value1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AudiovisualContentHorizontal(
                      label: label1, content: value1),
                ),
                Expanded(
                  child: AudiovisualContentHorizontal(
                      label: label2, content: value2),
                ),
              ],
            ),
          ],
        ));
  }
}

class AudiovisualContentHorizontal extends StatelessWidget {
  final String label;
  final String content;

  const AudiovisualContentHorizontal({Key key, this.label, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: content != null && content.isNotEmpty && content != 'N/A',
      child: Container(
        child: ListTile(
          title: label != null
              ? Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.bold))
              : null,
          subtitle: Text(content != null && content.isNotEmpty ? content : '',
              style: Theme.of(context).textTheme.subtitle1),
        ),
      ),
    );
  }
}
