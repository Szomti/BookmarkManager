library;

import 'dart:convert';
import 'dart:io';

import 'package:bookmark_manager/ui/core/ui/custom_outlined_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/themes/colors.dart';
import '../../data/models/bookmarks/bookmarks.dart';
import '../../data/models/bool_value_notifier/model.dart';
import '../../data/services/bookmarks/handler.dart';
import '../../data/services/external_data/external_data.dart';
import '../../data/services/settings/settings.dart';
import '../core/ui/navigation_bar.dart';

part 'widgets/screen.dart';
