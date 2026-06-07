import 'package:flutter/material.dart';
import '../models.dart';

enum ReadingTheme { light, dark, sepia }

class ReadingScreen extends StatefulWidget {
  final Book book;
  final int initialChapterIndex;
  final int initialPageIndex;

  const ReadingScreen({
    super.key,
    required this.book,
    required this.initialChapterIndex,
    required this.initialPageIndex,
  });

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late int _currentChapterIndex;
  late int _currentPageIndex;
  
  bool _showControls = false;
  double _fontSize = 18.0;
  ReadingTheme _theme = ReadingTheme.light;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideTopAnimation;
  late Animation<Offset> _slideBottomAnimation;
  
  @override
  void initState() {
    super.initState();
    _currentChapterIndex = widget.initialChapterIndex;
    _currentPageIndex = widget.initialPageIndex;
    _pageController = PageController(initialPage: _currentPageIndex);
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideTopAnimation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    
    _slideBottomAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _addBookmark() {
    final newBookmark = Bookmark(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      bookId: widget.book.id,
      chapterTitle: mockChapters[_currentChapterIndex].title,
      pageIndex: _currentPageIndex,
      snippet: mockChapters[_currentChapterIndex].pages[_currentPageIndex].length > 50 
        ? '${mockChapters[_currentChapterIndex].pages[_currentPageIndex].substring(0, 50)}...'
        : mockChapters[_currentChapterIndex].pages[_currentPageIndex],
      createdAt: DateTime.now(),
    );
    
    setState(() {
      globalBookmarks.add(newBookmark);
      // Toggle controls off after adding bookmark
      _toggleControls();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Bookmark saved successfully!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: SnackBarAction(
          label: 'VIEW',
          textColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            // View bookmark action could go here
          },
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (_theme) {
      case ReadingTheme.dark: return const Color(0xFF121212);
      case ReadingTheme.sepia: return const Color(0xFFFBF0D9);
      case ReadingTheme.light: return const Color(0xFFFAFAFA);
    }
  }

  Color _getTextColor() {
    switch (_theme) {
      case ReadingTheme.dark: return const Color(0xFFE0E0E0);
      case ReadingTheme.sepia: return const Color(0xFF5B4636);
      case ReadingTheme.light: return const Color(0xFF212121);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chapter = mockChapters[_currentChapterIndex];
    
    return Scaffold(
      backgroundColor: _getBackgroundColor(),
      body: SafeArea(
        child: Stack(
          children: [
            // Reading Content
            GestureDetector(
              onTap: _toggleControls,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemCount: chapter.pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: Text(
                              chapter.title,
                              style: TextStyle(
                                fontSize: _fontSize + 8,
                                fontWeight: FontWeight.bold,
                                color: _getTextColor(),
                                fontFamily: 'Georgia',
                                height: 1.3,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            chapter.pages[index],
                            style: TextStyle(
                              fontSize: _fontSize,
                              height: 1.8,
                              color: _getTextColor(),
                              fontFamily: 'Georgia',
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Progress Indicator (Bottom)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: _showControls ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    'Page ${_currentPageIndex + 1} of ${chapter.pages.length}',
                    style: TextStyle(
                      color: _getTextColor().withOpacity(0.5),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            
            // Controls Overlay
            if (_showControls || _animationController.isAnimating) 
              _buildControlsOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlsOverlay() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top App Bar
          SlideTransition(
            position: _slideTopAnimation,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          mockChapters[_currentChapterIndex].title,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark_add_outlined),
                    tooltip: 'Add Bookmark',
                    onPressed: _addBookmark,
                  ),
                  IconButton(
                    icon: const Icon(Icons.toc_rounded),
                    tooltip: 'Table of Contents',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Settings Bar
          SlideTransition(
            position: _slideBottomAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 16,
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Font Size',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('A', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Slider(
                          value: _fontSize,
                          min: 14.0,
                          max: 30.0,
                          activeColor: Theme.of(context).colorScheme.primary,
                          onChanged: (value) {
                            setState(() {
                              _fontSize = value;
                            });
                          },
                        ),
                      ),
                      const Text('A', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Theme',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _ThemeButton(
                          color: const Color(0xFFFAFAFA),
                          textColor: const Color(0xFF212121),
                          label: 'Light',
                          isSelected: _theme == ReadingTheme.light,
                          onTap: () => setState(() => _theme = ReadingTheme.light),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ThemeButton(
                          color: const Color(0xFFFBF0D9),
                          textColor: const Color(0xFF5B4636),
                          label: 'Sepia',
                          isSelected: _theme == ReadingTheme.sepia,
                          onTap: () => setState(() => _theme = ReadingTheme.sepia),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ThemeButton(
                          color: const Color(0xFF121212),
                          textColor: Colors.white,
                          label: 'Dark',
                          isSelected: _theme == ReadingTheme.dark,
                          onTap: () => setState(() => _theme = ReadingTheme.dark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeButton({
    required this.color,
    required this.textColor,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ] : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
