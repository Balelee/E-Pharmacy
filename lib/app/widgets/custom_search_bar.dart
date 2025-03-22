import 'dart:async'; // Import Timer
import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String?)? onSearch;
  final Function(XFile?)? onPhotoTaken;

  const CustomSearchBar({Key? key, this.onSearch, this.onPhotoTaken})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Timer? _debounceTimer;

  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      widget.onPhotoTaken?.call(image);
    }
  }

  void _onSearch() {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      widget.onSearch?.call(query);
    } else {
      widget.onSearch?.call(null);
    }
  }

  void _onSearchChanged() {
    // Cancel the previous timer if it exists
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    // Start a new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _onSearch();
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
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
              decoration: const InputDecoration(
                  hintText: "Rechercher un médicament...",
                  border: InputBorder.none,
                  hintStyle: AppTextStyles.bodyText2),
              onChanged: (value) => _onSearchChanged(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt, color: Get.theme.primaryColor),
            onPressed: _pickImage,
          ),
        ],
      ),
    );
  }
}
