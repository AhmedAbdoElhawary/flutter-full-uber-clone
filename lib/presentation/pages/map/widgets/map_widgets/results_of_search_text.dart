import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/functions/network_exceptions.dart';
import 'package:uber/core/functions/toast_show.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';
import 'package:uber/data/models/place_suggestion/places_suggestions.dart';
import 'package:uber/presentation/cubit/google_map_cubit/places_suggestions_cubit.dart';
import 'package:uber/presentation/cubit/google_map_cubit/result_state.dart';
import 'package:uber/presentation/pages/map/logic/map_logic.dart';
import 'package:uber/presentation/pages/map/logic/search_destination/appearance_of_search_list_logic.dart';
import 'package:uber/presentation/pages/map/logic/search_destination/search_destination_logic.dart';
import 'package:uber/presentation/pages/map/view/initial_map/initial_map_page.dart';

class ResultsOfSearchText extends StatelessWidget {
  const ResultsOfSearchText({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppearanceOfSearchListLogic>(
      id: "pointer",
      initState: (state) {
        Get.find<AppearanceOfSearchListLogic>(tag: "1");
      },
      tag: "1",
      builder: (controller) {
        return SafeArea(
          child: Stack(
            children: [
              AnimatedPositioned(
                top: controller.getPositionInTop,
                bottom: 0,
                left: 0,
                right: 0,
                duration: controller.disAppearTheResult
                    ? const Duration(milliseconds: 200)
                    : const Duration(milliseconds: 1),
                child: Listener(
                  onPointerDown: controller.onListPointerDown,
                  onPointerUp: controller.onListPointerUp,
                  onPointerMove: (d) => controller.onListPointerMove(d, context),
                  child: const _GoogleMapBlocConsumer(),
                ),
              ),
              if (!controller.getDisplayRidersMenu)
                const Align(alignment: Alignment.topCenter, child: SearchBars()),
            ],
          ),
        );
      },
    );
  }
}

class _GoogleMapBlocConsumer extends StatelessWidget {
  const _GoogleMapBlocConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleMapCubit, ResultState>(
      listenWhen: (previous, current) => listenWhen(previous, current, context),
      listener: listener,
      buildWhen: (previous, current) => buildWhen(previous, current, context),
      builder: buildPlaceSuggestion,
    );
  }

  bool listenWhen(
      ResultState previous, ResultState current, BuildContext context) {
    if (previous == current) return false;

    return current.maybeWhen(
      placesLocationLoaded: (data) => true,
      error: (NetworkExceptions networkExceptions) {
        ToastShow.reformatToast(context, networkExceptions.toString());
        return false;
      },
      orElse: () => false,
    );
  }

  void listener(context, ResultState state) {
    state.whenOrNull(
      placesLocationLoaded: (placesLocationInfo) async {
        MapLogic mapLogic = Get.find(tag: '2');
        mapLogic.goToThosePositions(context, placesLocationInfo);
        mapLogic.preparePlacesDirection(context, placesLocationInfo);
      },
    );
  }

  bool buildWhen(
      ResultState previous, ResultState current, BuildContext context) {
    if (previous == current) return false;

    return current.maybeWhen(
      initial: () => true,
      placesSuggestionsLoaded: (data) => true,
      error: (NetworkExceptions networkExceptions) {
        ToastShow.reformatToast(context, networkExceptions.toString());
        return false;
      },
      orElse: () => false,
    );
  }

  Widget buildPlaceSuggestion(context, state) {
    return state.maybeWhen(
      placesSuggestionsLoaded: (placeInfo) => _PlaceSuggestionsList(placeInfo),
      orElse: () => const _SavedResultsList(),
    );
  }
}

class _PlaceSuggestionsList extends StatelessWidget {
  const _PlaceSuggestionsList(this.placeInfo, {Key? key}) : super(key: key);
  final PlacesSuggestions placeInfo;

  @override
  Widget build(BuildContext context) {
    final SearchDestinationLogic textFieldsController = Get.find(tag: "1");
    final AppearanceOfSearchListLogic appearanceController = Get.find(tag: "1");

    return Container(
        color: ColorManager.white,
        child: ListView.separated(
            itemBuilder: (context, index) {
              Prediction? suggestionPlace = placeInfo.predictions?[index];
              return GestureDetector(
                  onTap: () {
                    textFieldsController
                        .onSelectedSuggestionPlace(suggestionPlace);

                    /// To initialize the list of suggestion place.
                    /// And display saved places list.
                    GoogleMapCubit.get(context).getPlacesSuggestions("");

                    if (!textFieldsController.isStartAndEndComplete) return;

                    appearanceController.showRidersMenu();
                    Prediction? toPlaceIdPrediction =
                        textFieldsController.whereTo.value;
                    Prediction? fromPlacePrediction =
                        textFieldsController.whereFrom.value;

                    if (toPlaceIdPrediction == null ||
                        fromPlacePrediction == null) return;
                    List<Prediction> places = [
                      fromPlacePrediction,
                      toPlaceIdPrediction
                    ];
                    GoogleMapCubit.get(context).getPlaceLocation(places);
                  },
                  child: _CustomListTitle(
                      text:
                          suggestionPlace?.structuredFormatting?.mainText ?? "",
                      subText: suggestionPlace
                              ?.structuredFormatting?.secondaryText ??
                          "",
                      icon: Icons.location_on));
            },
            separatorBuilder: (context, index) =>
                Divider(color: ColorManager.veryLightGrey, height: 1.h),
            itemCount: placeInfo.predictions?.length ?? 0));
  }
}

class _SavedResultsList extends StatelessWidget {
  const _SavedResultsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> map = [];

    return Container(
        color: ColorManager.white,
        child: ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                    onTap: () {},
                    child: const _CustomListTitle(
                        text: "Saved Places", icon: Icons.star));
              } else if (index == map.length + 2 - 1) {
                return GestureDetector(
                    onTap: () {},
                    child: const _CustomListTitle(
                        text: "Set location on map", icon: Icons.location_on));
              } else {
                return GestureDetector(
                    onTap: () {},
                    child: _CustomListTitle(
                        text: map[index - 1]["title"] ?? "",
                        subText: map[index - 1]["subTitle"] ?? "",
                        icon: map[index - 1]["icon"] == "star"
                            ? Icons.star
                            : Icons.location_on));
              }
            },
            separatorBuilder: (context, index) {
              if (map.length > 2 && index == 0) {
                return Divider(
                    color: ColorManager.veryLightGrey,
                    thickness: 5.h,
                    height: 5.h);
              } else {
                return Divider(color: ColorManager.veryLightGrey, height: 1.h);
              }
            },
            itemCount: map.length + 2));
  }
}

class SearchBars extends StatelessWidget {
  const SearchBars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      shadowColor: ColorManager.grey.withOpacity(0.3),
      color: ColorManager.white,
      child: SizedBox(
        height: 130.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _SwitchRiderWidgets(),
            Row(
              children: const [
                _PointSquareWidget(),
                _SearchTextFields(),
                _AddIcon()
              ],
            ),
            const Spacer(),
            BlocBuilder<GoogleMapCubit, ResultState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const LinearProgressIndicator(
                      color: ColorManager.black, minHeight: 2),
                  orElse: () => const SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PointSquareWidget extends StatelessWidget {
  const _PointSquareWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Icon(Icons.circle, color: ColorManager.grey, size: 9.r),
          Container(height: 30.h, width: 1.w, color: ColorManager.black),
          Icon(Icons.square, size: 9.r),
        ],
      ),
    );
  }
}

class _SearchTextFields extends StatelessWidget {
  const _SearchTextFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppearanceOfSearchListLogic appearanceController = Get.find(tag: "1");
    final textFieldsController = Get.put(SearchDestinationLogic(), tag: "1");

    return Flexible(
      child: Padding(
        padding: REdgeInsetsDirectional.only(end: 15),
        child: Column(
          children: [
            Listener(
              onPointerDown: (d) {
                appearanceController.showTheFlyingSuggestionsList();
                textFieldsController.isWhereFromSelected.value = true;
                textFieldsController.selectAllTextInFrom();
              },
              child: _SearchTextField(
                  controller: textFieldsController.fromController,
                  focusNode: textFieldsController.whereFromFocusNode.value,
                  hint: "Where from?"),
            ),
            const RSizedBox(height: 10),
            Listener(
              onPointerDown: (d) {
                appearanceController.showTheFlyingSuggestionsList();
                textFieldsController.isWhereFromSelected.value = false;
                textFieldsController.selectAllTextInTo();
              },
              child: _SearchTextField(
                  controller: textFieldsController.toController,
                  focusNode: textFieldsController.whereToFocusNode.value,
                  hint: "Where to?"),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddIcon extends StatelessWidget {
  const _AddIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: REdgeInsetsDirectional.only(end: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            RSizedBox(height: 40),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}

class _SwitchRiderWidgets extends StatelessWidget {
  const _SwitchRiderWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Go.offAll(const MapScreen());
              },
              child: Icon(Icons.arrow_back, size: 30.r)),
          const Spacer(),
          const Text("Switch rider"),
          const Spacer(),
        ],
      ),
    );
  }
}

class _CustomListTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  final String subText;

  const _CustomListTitle({
    Key? key,
    required this.icon,
    required this.text,
    this.subText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.transparent,
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: ColorManager.lightGrey,
              radius: 18.r,
              child: Center(
                  child: Icon(icon, color: ColorManager.white, size: 20.r)),
            ),
            const RSizedBox(width: 20),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(text, style: getNormalStyle(fontSize: 14)),
                  if (subText.isNotEmpty) ...[
                    const RSizedBox(height: 5),
                    Text(subText,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: getNormalStyle(
                            fontSize: 13, color: ColorManager.grey)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final FocusNode focusNode;
  const _SearchTextField(
      {Key? key,
      required this.focusNode,
      required this.controller,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onChanged: (input) {
        GoogleMapCubit.get(context).getPlacesSuggestions(input);
      },
      controller: controller,
      cursorColor: ColorManager.teal,
      style: getNormalStyle(color: ColorManager.black, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: getNormalStyle(color: ColorManager.lightGrey, fontSize: 17),
        fillColor: ColorManager.veryLowOpacityGrey,
        filled: true,
        isDense: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none),
        contentPadding: REdgeInsets.symmetric(horizontal: 10, vertical: 7),
      ),
    );
  }
}
