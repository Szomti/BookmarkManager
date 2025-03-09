library;

import 'dart:convert';
import 'dart:io';

import 'package:bookmark_manager/models/bool_value_notifier/model.dart';
import 'package:bookmark_manager/storage/bookmarks/handler.dart';
import 'package:bookmark_manager/storage/settings/settings.dart';
import 'package:bookmark_manager/widgets/custom_outlined_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../models/bookmarks/bookmarks.dart';
import '../../storage/external_data/external_data.dart';
import '../../widgets/navigation_bar.dart';

part './screen.dart';
