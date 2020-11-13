import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/ui/util_ui.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';
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
    audiovisualProvider = Provider.of<AudiovisualProvider>(context, listen: false);
    Future.delayed(Duration(milliseconds: 100), () async {
      audiovisualProvider.checkImageCached();
      if (widget.trending ?? false)
        await audiovisualProvider.findMyDataTrending(context);
      else
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
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.imdb, color: Colors.orange, size: 60),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                audiovisualProvider.data?.score ??
                                    '${audiovisualProvider.voteAverage}',
                                style: Theme.of(context).textTheme.headline4),
                          ),
                          Expanded(child: Container()),
                          likeButton(context),
                        ],
                      ),
                    ),
                    audiovisualProvider.data == null ? LinearProgressIndicator() : Container(),
                    AudiovisualContentHorizontal(content: audiovisualProvider.data?.sinopsis),
                    buildDivider(audiovisualProvider.data?.pais),
                    AudiovisualContentHorizontal(
                        label: 'Pais', content: audiovisualProvider.data?.pais),
                    buildDivider(audiovisualProvider.data?.director),
                    AudiovisualContentHorizontal(
                        label: 'Director', content: audiovisualProvider.data?.director),
                    buildDivider(audiovisualProvider.data?.capitulos),
                    AudiovisualContentHorizontal(
                        label: 'Guión', content: audiovisualProvider.data?.capitulos),
                    buildDivider(audiovisualProvider.data?.temp),
                    AudiovisualContentHorizontal(
                        label: 'Temporadas', content: audiovisualProvider.data?.temp),
                    buildDivider(audiovisualProvider.data?.anno),
                    AudiovisualContentHorizontal(
                        label: 'Año', content: audiovisualProvider.data?.anno),
                    buildDivider(audiovisualProvider.data?.productora),
                    AudiovisualContentHorizontal(
                        label: 'Productora', content: audiovisualProvider.data?.productora),
                    buildDivider(audiovisualProvider.data?.duracion),
                    AudiovisualContentHorizontal(
                        label: 'Duración', content: audiovisualProvider.data?.duracion),
                    buildDivider(audiovisualProvider.data?.idioma),
                    AudiovisualContentHorizontal(
                        label: 'Idioma', content: audiovisualProvider.data?.idioma),
                    buildDivider(audiovisualProvider.data?.reparto),
                    AudiovisualContentHorizontal(
                        label: 'Reparto', content: audiovisualProvider.data?.reparto),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ));

  Future<bool> onLikeButtonTap(bool isLiked, BuildContext context) {
    final ScaffoldState scaffoldState = context.findRootAncestorStateOfType<ScaffoldState>();
    if (scaffoldState != null) {
      scaffoldState.showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(isLiked ? 'Eliminado de Mis Favoritos' : 'Agregado a Mis Favoritos'),
      ));
    }
    return audiovisualProvider.toggleFavourite(context: context);
  }

  SliverAppBar getAppBar(BuildContext context) => SliverAppBar(
        pinned: false,
        floating: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
        expandedHeight: MediaQuery.of(context).size.height * 0.6,
        primary: true,
        automaticallyImplyLeading: false,
        leading: Stack(
          fit: StackFit.loose,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.orange.withOpacity(0.5)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white.withOpacity(0.5)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black.withOpacity(0.5)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
              background: Consumer<AudiovisualProvider>(
                  builder: (ctx, av, child) => Hero(
                        tag: av.id,
                        child: Material(
                          child: GestureDetector(
                            onTap: () => previewImageDialog(context, av.imageUrl),
                            child: CachedNetworkImage(
                              imageUrl: av.imageUrl ?? av.data.image,
//                              color: Colors.red,
                              colorBlendMode: BlendMode.darken,
                              placeholder: (_, __) => Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (ctx, _, __) =>
                                  PlaceholderImage(heigth: MediaQuery.of(ctx).size.height * 0.6),
                              fit: BoxFit.cover,
//                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      )),
            );
          },
        ),
      );

  Widget likeButton(BuildContext context) =>
      Consumer<AudiovisualProvider>(builder: (ctx, av, child) {
        final fav = av.data?.isFavourite ?? av.isFavourite;
        return IconButton(
          icon: Icon(fav ? Icons.favorite : Icons.favorite_border),
          iconSize: 32,
          color: fav ? Colors.red : Colors.black87,
          onPressed: () {
            return onLikeButtonTap(fav, context);
          },
        );
      });

  Widget buildDivider(String value) {
    return Visibility(
      visible: value != null && value.isNotEmpty && value != 'N/A',
      child: Container(
//        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Divider(
            height: 1,
//            color: Colors.black,
          ),
        ),
      ),
    );
  }

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
//                backgroundColor: Colors.white70,
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

class AudiovisualContentHorizontal extends StatelessWidget {
  final String label;
  final String content;

  const AudiovisualContentHorizontal({Key key, this.label, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: content != null && content.isNotEmpty && content != 'N/A',
      child: Container(
//        color: Colors.white,
        child: ListTile(
          title: label != null ? Text(label, style: Theme.of(context).textTheme.headline6) : null,
          subtitle: Text(content != null && content.isNotEmpty ? content : '',
              style: Theme.of(context).textTheme.subtitle2),
        ),
      ),
    );
  }
}
