// lib/presentation/widgets/custom_search_bar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skyo_app_new/presentation/controllers/search_bar_controller.dart';

class CustomSearchBar extends GetView<CustomSearchBarController> {
  final Function(String) onSearch;
  final Color bgColor;
  final Color textColor;
  final Color secondaryColor;

  const CustomSearchBar({
    super.key,
    required this.onSearch,
    required this.bgColor,
    required this.textColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          height: controller.isExpanded.value ? 300 : 56,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: textColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(controller.isExpanded.value ? 16 : 30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Search input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: TextField(
                  onTapOutside: (_) {FocusScope.of(context).unfocus(); },
                  onTap: controller.expand,
                  onChanged: controller.onQueryChanged,
                  onSubmitted: (value) {
                    final trimmed = value.trim();
                    if (trimmed.isNotEmpty) {
                      onSearch(trimmed);
                      controller.collapse();
                    }
                  },
                  style: GoogleFonts.inter(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Search city...',
                    hintStyle: GoogleFonts.inter(color: textColor.withOpacity(0.6)),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search_rounded, color: textColor),
                    suffixIcon: controller.currentQuery.value.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: textColor),
                            onPressed: controller.clear,
                          )
                        : null,
                  ),
                ),
              ),

              // Suggestions area (only when expanded)
              if (controller.isExpanded.value)
                Expanded(
                  child: controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                      : controller.suggestions.isEmpty
                          ? Center(
                              child: Text(
                                'No results',
                                style: GoogleFonts.inter(color: textColor.withOpacity(0.7)),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: controller.suggestions.length,
                              itemBuilder: (context, index) {
                                final city = controller.suggestions[index];
                                return ListTile(
                                  leading: Icon(Icons.location_city, color: textColor),
                                  title: Text(
                                    city.displayName,
                                    style: GoogleFonts.inter(color: textColor),
                                  ),
                                  onTap: () {
                                    onSearch(city.displayName);
                                    controller.collapse();
                                  },
                                );
                              },
                            ),
                ),
            ],
          ),
        ));
  }
}