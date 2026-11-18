import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/models/category_info.dart';
import 'package:afl2/features/Quiz/presentation/pages/quiz_page.dart';
import 'package:afl2/features/Quiz/presentation/widgets/category_empty_state.dart';
import 'package:afl2/features/Quiz/presentation/widgets/category_filter_chips.dart';
import 'package:afl2/features/Quiz/presentation/widgets/category_grid.dart';
import 'package:afl2/features/Quiz/presentation/widgets/category_search_bar.dart';
import 'package:afl2/features/Quiz/presentation/widgets/home_background_slider.dart';
import 'package:afl2/features/Quiz/presentation/widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  String _query = '';
  CategoryGroup? _group;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CategoryInfo> get _filtered => CategoryInfo.all
      .where((c) => c.matches(_query) && (_group == null || c.group == _group))
      .toList();

  void _open(CategoryInfo info) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => QuizPage(category: info.category)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: HomeBackgroundSlider()),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  children: [
                    const HomeHeader(),
                    const SizedBox(height: 20),
                    CategorySearchBar(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _query = v),
                    ),
                    const SizedBox(height: 14),
                    CategoryFilterChips(
                      selected: _group,
                      onSelected: (g) => setState(() => _group = g),
                    ),
                    const SizedBox(height: 24),
                    if (items.isEmpty)
                      const CategoryEmptyState()
                    else
                      CategoryGrid(items: items, onSelected: _open),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
