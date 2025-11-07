import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String?)? onSearch;
  final Function(XFile?)? onPhotoTaken;
  final String searchLabel;
  final double borderRadius;

  const CustomSearchBar(
      {Key? key,
      this.onSearch,
      this.onPhotoTaken,
      this.searchLabel = "Recherche",
      this.borderRadius = 30})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Timer? _debounceTimer;
  bool _showCancel = false;
  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      widget.onPhotoTaken?.call(image);
    }
  }

  void onSearch() {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      widget.onSearch?.call(query);
    } else {
      widget.onSearch?.call(null);
    }
  }

  void _onSearchChanged() {
    // Cancel the previous timer if it exists
    setState(() {
      if (_searchController.text.isNotEmpty) {
        _showCancel = true;
      } else {
        _showCancel = false;
      }
    });
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    // Start a new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      onSearch();
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _showCancel = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.search, color: Get.theme.primaryColor),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: widget.searchLabel,
                  border: InputBorder.none,
                  hintStyle: AppTextStyles.bodyText2),
              onChanged: (value) => _onSearchChanged(),
            ),
          ),
          if (_showCancel)
            IconButton(
              icon: Icon(Icons.cancel, color: Get.theme.primaryColor),
              onPressed: () => {_searchController.clear(), _onSearchChanged()},
            ),
        ],
      ),
    );
  }
}
