import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_module/utils/shared_preferences.dart';

import '../../app_colors.dart';

class EditProfilePage extends StatefulWidget {
  final String fieldName;
  final String fieldData;

  const EditProfilePage({required this.fieldName, required this.fieldData, super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _unsavedChanges = true;
  final TextEditingController _textController = TextEditingController();

  // Add your profile editing form fields and logic here
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController.text = widget.fieldData;
  }

  @override
  Widget build(BuildContext context) {
    log(widget.fieldName.toString());
    return WillPopScope(
      onWillPop: () async {
        _unsavedChanges = widget.fieldData != _textController.text ? true : false;
        if (_unsavedChanges) {
          final confirmExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Discard changes?'),
              content: const Text('You have unsaved changes. Do you want to leave this page?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Stay on the page
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Leave the page
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          );
          return confirmExit ?? false;
        }
        return true; // No unsaved changes, allow leaving the page
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Edit ${widget.fieldName}'),
          actions: [
            IconButton(
                onPressed: () {
                  if (widget.fieldName == 'Name') {
                    SharedPreferencesUtils.setName(_textController.text);
                  }
                  if (widget.fieldName == 'Skills') {
                    SharedPreferencesUtils.setSkills(_textController.text);
                  }
                  if (widget.fieldName == 'Experience') {
                    SharedPreferencesUtils.setExp(_textController.text);
                  }
                  Navigator.of(context).pop(true); // Leave the page
                },
                icon: const Icon(Icons.check_circle))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Add your profile editing form fields here

            children: [
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                  enabled: true,
                  isDense: true,
                  hintText: widget.fieldName,
                  hintStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.primary)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: AppColors.black)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 1, color: Colors.red)),
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                // Save email to SharedPreferences when "Remember me" is checked
                onSaved: (value) {
                  // Implementation here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
