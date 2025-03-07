import 'package:e_pharma/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String)? onSearch; // Callback pour la recherche
  final Function(XFile?)? onPhotoTaken; // Callback pour la photo

  const CustomSearchBar({Key? key, this.onSearch, this.onPhotoTaken})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      widget.onPhotoTaken?.call(image);
    }
  }

  void _onSearch() {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      widget.onSearch?.call(query); // Exécute la recherche
    }
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
            icon: const Icon(Icons.search, color: Colors.blue),
            onPressed: _onSearch, // Lance la recherche
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                  hintText: "Rechercher un médicament...",
                  border: InputBorder.none,
                  hintStyle: AppTextStyles.bodyText2),
              onSubmitted: (_) => _onSearch(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.blue),
            onPressed: _pickImage, // Capture une photo
          ),
        ],
      ),
    );
  }
}
