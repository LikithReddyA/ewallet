import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final IconData? icon;

  TabItem({required this.title, this.icon});
}

class CustomTabBar extends StatefulWidget {
  final List<TabItem> tabItems;
  final List<Widget> tabContents;

  const CustomTabBar({
    super.key,
    required this.tabItems,
    required this.tabContents,
  }) : assert(
         tabItems.length == tabContents.length,
         'Tab titles and tab contents must have the same length',
       );

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabItems.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        // This rebuilds the tab buttons to update their selected state
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent, // Hide default indicator
            labelColor: Colors.blue, // Color for selected button text
            unselectedLabelColor:
                Colors.grey, // Color for unselected button text
            isScrollable: true, // Allow scrolling if many buttons
            tabs: List.generate(widget.tabItems.length, (index) {
              return _buildCustomTabButton(widget.tabItems[index], index);
            }),
            dividerHeight: 0,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabContents,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTabButton(TabItem tabItem, int index) {
    bool isSelected = _tabController.index == index;
    return Tab(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index); // Navigate to the selected tab
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              if (tabItem.icon != null) ...[
                Icon(
                  tabItem.icon,
                  size: 20,
                  color: isSelected ? Colors.blue : Colors.grey,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                tabItem.title,
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
