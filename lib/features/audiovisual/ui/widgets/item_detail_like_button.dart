// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:movie_search/common/domain/search_result.dart';
//
// class ItemLikeButton extends ConsumerWidget {
//   final double iconSize;
//   final bool showDisabled;
//   final BaseSearchResult item;
//
//   const ItemLikeButton({super.key, this.iconSize = 32, this.showDisabled = true, required this.item});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Builder(
//       builder: (ctx) {
//         final isLiked = model.listFavouriteId.contains(item.id);
//         return model.busy(item.id)
//             ? Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(height: iconSize, width: iconSize, child: CircularProgressIndicator(strokeWidth: 1)),
//               )
//             : model.anyObjectsBusy
//             ? Container()
//             : Consumer<AccountViewModel>(
//                 builder: (context, accountViewModel, child) {
//                   if (!isLiked && !this.showDisabled) {
//                     return Container();
//                   }
//                   return IconButton(
//                     icon: Icon(isLiked ? MyIcons.favourite_on : MyIcons.favourite_off),
//                     iconSize: this.iconSize,
//                     padding: EdgeInsets.zero,
//                     color: /*snapshot.data!.contains(id) ? Colors.red : */ Theme.of(context).colorScheme.onSurface,
//                     onPressed: () async {
//                       if (accountViewModel.userUuid == null) {
//                         await context.showLoginModalBottomSheet();
//                       }
//                       if (accountViewModel.userUuid != null) {
//                         final type = isLiked
//                             ? model.findTypeGivenId(item.id)
//                             : await SelectBookmarkTypeDialog.show(context);
//                         if (type != null) {
//                           await model.toggleFavourite(
//                             isLiked: isLiked,
//                             data: item,
//                             type: type,
//                             userUuid: accountViewModel.userUuid!,
//                             onError: (e) => context.showError(error: e.toString()),
//                           );
//                         }
//                       }
//                     },
//                   );
//                 },
//               );
//       },
//     );
//   }
// }
//
// class ItemBookmarkTag extends ViewModelWidget<FavouritesViewModel> {
//   final BaseSearchResult item;
//
//   ItemBookmarkTag({required this.item});
//
//   @override
//   Widget build(BuildContext context, FavouritesViewModel model) {
//     final isLiked = model.listFavouriteId.contains(item.id);
//
//     return Align(
//       alignment: Alignment.bottomRight,
//       child: isLiked
//           ? Builder(
//               builder: (context) {
//                 final type = model.findTypeGivenId(item.id);
//                 if (type == null) {
//                   return Container();
//                 }
//                 return Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   color: context.theme.colorScheme.tertiary,
//                   child: Text(
//                     type,
//                     style: context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.onTertiary),
//                   ),
//                 );
//               },
//             )
//           : Container(),
//     );
//   }
// }
