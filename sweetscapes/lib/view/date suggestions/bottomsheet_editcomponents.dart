import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetscapes/model/response/getAllPlans_response.dart';
import 'package:sweetscapes/res/color.dart';
import 'package:sweetscapes/res/components/AppText.dart';
import 'package:sweetscapes/res/components/editPlanComponent_Tile.dart';
import 'package:sweetscapes/res/components/planComponent_Tile.dart';
import 'package:sweetscapes/res/components/primary_button.dart';
import 'package:sweetscapes/res/components/secondary_button.dart';
import 'package:sweetscapes/res/enums/Fonts.dart';
import 'package:sweetscapes/res/fonts.dart';
import 'package:sweetscapes/view/date%20suggestions/date_details_viewmodel.dart';

class BottomSheetEditComponents extends StatefulWidget {
  BottomSheetEditComponents(this.planComponents, this.model);

  final List<Components> planComponents;
  final DateDetailsViewModel model;

  @override
  _BottomSheetEditComponentsState createState() =>
      _BottomSheetEditComponentsState();
}

class _BottomSheetEditComponentsState extends State<BottomSheetEditComponents> {
  List<Components> editPlanComponents = [];
  List<Components> componentsByTag = [];
  int indexToBeChanged = 0;
  bool showTagsSearch = false;
  String typeToBeSearched = 'Dining';
  String tagToBeSearched = 'Fine_Dining';
  final TextEditingController _searchTagController = TextEditingController();
  final FocusNode _searchTagNode = FocusNode();

  void _onChangePressed(String type, String tag, int order) {
    setState(() {
      componentsByTag = [];
      tagToBeSearched = tag;
      typeToBeSearched = type;
      indexToBeChanged = order - 1;
      _searchTagController.text = '';
      showTagsSearch = true;
    });
  }

  void _updatePlanComponentsList(Components component) {
    setState(() {
      component.order = indexToBeChanged + 1;
      editPlanComponents[indexToBeChanged] = component;
      showTagsSearch = false;
    });
  }

  void _resetSheet() {
    setState(() {
      showTagsSearch = false;
    });
  }

  Future<void> getComponent(
      String search, List<Components> componentList) async {
    await Future.delayed(const Duration(microseconds: 500));
    List<Components> newList = componentList.where((element) {
      String checker = (element.details!.type == 'Dining')
          ? element.details!.hotelName!
          : element.details!.placeName!;
      return checker.toLowerCase().contains(search.toLowerCase());
    }).toList();

    setState(() {
      componentsByTag = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    editPlanComponents = widget.planComponents;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: showTagsSearch
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _resetSheet();
                              },
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                size: 24,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: AppColor.secondary,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColor.black),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: TextFormField(
                                  controller: _searchTagController,
                                  focusNode: _searchTagNode,
                                  autofocus: true,
                                  onChanged: (searchValue) => getComponent(
                                      searchValue,
                                      widget.model.componentsByTag),
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    hintText: 'Explore other places',
                                    suffixIcon: Icon(
                                      Icons.cancel_outlined,
                                      color: AppColor.black,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: AppColor.black,
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SizedBox(
                          width: screenWidth,
                          height: 200,
                          child: (componentsByTag.isEmpty)
                              ? FutureBuilder(
                                  future: widget.model.getComponentsByTag(
                                      typeToBeSearched,
                                      tagToBeSearched,
                                      context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasData) {
                                      componentsByTag = snapshot.data!;
                                      return CupertinoScrollbar(
                                        child: ListView.builder(
                                          itemCount: componentsByTag.length,
                                          itemBuilder: (context, index) =>
                                              EditPlanComponentTile(
                                            component: componentsByTag[index],
                                            onPressed:
                                                _updatePlanComponentsList,
                                          ),
                                        ),
                                      );
                                    }
                                    return const Text(
                                        'Not able to fetch components');
                                  },
                                )
                              : CupertinoScrollbar(
                                  child: ListView.builder(
                                    itemCount: componentsByTag.length,
                                    itemBuilder: (context, index) =>
                                        EditPlanComponentTile(
                                      component: componentsByTag[index],
                                      onPressed: _updatePlanComponentsList,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Edit Plan',
                      size: 24,
                      font: Fonts.TITLE,
                      weight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    Text(
                      'We have better suggestions for all the components. Explore and replace them as per your wish. Trust us with the Highlight of your Plan.',
                      style: TextStyle(
                        height: 1.14,
                        fontSize: 14,
                        fontFamily: AppFonts.subtitle,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                        letterSpacing: 0.21,
                      ),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    Column(
                      children: editPlanComponents.map((Components component) {
                        return PlanComponentTile(
                          component: component,
                          isEditable: true,
                          onChangePressed: _onChangePressed,
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 2,
                      color: AppColor.secondary,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SecondaryButton(
                                title: 'Cancel',
                                onPress: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          Expanded(
                            child: PrimaryButton(
                                title: 'Save Changes',
                                onPress: () {
                                  widget.model.updatePlan();
                                  Navigator.pop(context);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
