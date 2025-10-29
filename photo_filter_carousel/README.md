# photo_filter_carousel

A new Flutter project.

## Step 1: Create a new project
Create a new flutter project in meeting 09 with the name photo_filter_carousel
![alt text](images/1.png)

## Step 2: Create a Selector ring and dark gradient widget
Create a widgetnew folder and file containing the following code.

lib/widget/filter_selector.dart
```dart:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;
import 'filter_item.dart';
import 'carousel_flowdelegate.dart';

@immutable
class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
  });

  final List<Color> filters;
  final void Function(Color selectedColor) onFilterChanged;
  final EdgeInsets padding;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

  late final PageController _controller;
  late int _page;

  int get filterCount => widget.filters.length;

  Color itemColor(int index) => widget.filters[index % filterCount];

  @override
  void initState() {
    super.initState();
    _page = 0;
    _controller = PageController(
      initialPage: _page,
      viewportFraction: _viewportFractionPerItem,
    );
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = (_controller.page ?? 0).round();
    if (page != _page) {
      _page = page;
      widget.onFilterChanged(widget.filters[page]);
    }
  }

  void _onFilterTapped(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      controller: _controller,
      axisDirection: AxisDirection.right,
      physics: const PageScrollPhysics(),
      viewportBuilder: (context, viewportOffset) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final itemSize = constraints.maxWidth * _viewportFractionPerItem;
            viewportOffset
              ..applyViewportDimension(constraints.maxWidth)
              ..applyContentDimensions(0.0, itemSize * (filterCount - 1));

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _buildShadowGradient(itemSize),
                _buildCarousel(
                  viewportOffset: viewportOffset,
                  itemSize: itemSize,
                ),
                _buildSelectionRing(itemSize),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildShadowGradient(double itemSize) {
    return SizedBox(
      height: itemSize * 2 + widget.padding.vertical,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
        child: SizedBox.expand(),
      ),
    );
  }

  Widget _buildCarousel({
    required ViewportOffset viewportOffset,
    required double itemSize,
  }) {
    return Container(
      height: itemSize,
      margin: widget.padding,
      child: Flow(
        delegate: CarouselFlowDelegate(
          viewportOffset: viewportOffset,
          filtersPerScreen: _filtersPerScreen,
        ),
        children: [
          for (int i = 0; i < filterCount; i++)
            FilterItem(
              onFilterSelected: () => _onFilterTapped(i),
              color: itemColor(i),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectionRing(double itemSize) {
    return IgnorePointer(
      child: Padding(
        padding: widget.padding,
        child: SizedBox(
          width: itemSize,
          height: itemSize,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(width: 6, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```

Step 3: Create a photo filter carousel widget
Create a new file in the widget folder with code like the following.

lib/widget/filter_carousel.dart
```dart:
import 'package:flutter/material.dart';
import 'filter_selector.dart';

@immutable
class PhotoFilterCarousel extends StatefulWidget {
  const PhotoFilterCarousel({super.key});

  @override
  State<PhotoFilterCarousel> createState() => _PhotoFilterCarouselState();
}

class _PhotoFilterCarouselState extends State<PhotoFilterCarousel> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          // Gambar utama dengan efek filter warna
          Positioned.fill(
            child: _buildPhotoWithFilter(),
          ),
          // Carousel filter di bagian bawah layar
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        // Kamu bisa ganti URL ini dengan foto kamu sendiri
        return Image.network(
          'https://docs.flutter.dev/cookbook/img-files'
          '/effects/instagram-buttons/millennial-dude.jpg',
          color: color.withOpacity(0.5),
          colorBlendMode: BlendMode.color,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
```

## Step 4: Creating a color filter - part 1
Create a new file in the widget folder like the following code.

lib/widget/carousel_flowdelegate.dart

```dart:
import 'dart:math';
import 'package:flutter/material.dart';

class CarouselFlowDelegate extends FlowDelegate {
  final ScrollController scrollController;
  final double itemHeight;

  CarouselFlowDelegate({
    required this.scrollController,
    required this.itemHeight,
  }) : super(repaint: scrollController);

  @override
  void paintChildren(FlowPaintingContext context) {
    double viewportDimension = scrollController.position.viewportDimension;
    double scrollOffset = scrollController.offset;
    double activeItem = scrollOffset / itemHeight;

    for (int i = 0; i < context.childCount; i++) {
      double scale = 1.0 - (activeItem - i).abs() * 0.2;
      scale = scale.clamp(0.8, 1.0);

      double opacity = 1.0 - (activeItem - i).abs() * 0.3;
      opacity = opacity.clamp(0.5, 1.0);

      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(0.0, i * itemHeight)
          ..scale(scale, scale),
        opacity: opacity,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CarouselFlowDelegate oldDelegate) {
    return oldDelegate.scrollController != scrollController ||
        oldDelegate.itemHeight != itemHeight;
  }
}
```
## Step 5: Creating a color filter
Create a new file in the widget folder like the following code.

lib/widget/filter_item.dart
```dart:
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final String title;
  final Color filterColor;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterItem({
    super.key,
    required this.title,
    required this.filterColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        padding: const EdgeInsets.all(8.0),
        width: 80,
        decoration: BoxDecoration(
          color: filterColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              const BoxShadow(
                color: Colors.white54,
                blurRadius: 10,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.filter, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
```
Step 6: Implement the carousel filter
Finally, we import the widget PhotoFilterCarouselinto mainlike the following code.

lib/main.dart

```dart:
import 'package:flutter/material.dart';
import 'widget/filter_carousel.dart';

void main() {
  runApp(
    const MaterialApp(
      home: PhotoFilterCarousel(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
```