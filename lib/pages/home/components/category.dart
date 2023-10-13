import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_page_bloc.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    super.key,
    required this.state,
  });

  final HomePageState state;
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = widget.state as HomePageInitial;

    final categories = state.categories;
    final selectedIndex = state.selectedIndex;
    return Expanded(
      flex: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: Column(
          children: [
            Hero(
              tag: "category",
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.asMap().entries.map((entry) {
                    final category = entry.value;
                    final isSelected = selectedIndex == entry.key;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ActionChip(
                        label: Text(
                          category['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isSelected
                                ? colorScheme.background
                                : colorScheme.onBackground,
                          ),
                        ),
                        backgroundColor: isSelected
                            ? colorScheme.primary
                            : colorScheme.background,
                        elevation: isSelected ? 6 : 0,
                        onPressed: () {
                          BlocProvider.of<HomePageBloc>(context)
                              .add(ChangeCategoriesEvent(newIndex: entry.key));
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
