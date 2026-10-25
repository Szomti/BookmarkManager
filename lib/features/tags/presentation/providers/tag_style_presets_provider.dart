import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/tag_style.dart';

part 'tag_style_presets_provider.g.dart';

@Riverpod(keepAlive: true)
List<TagStyle> tagStyleBuiltInPresets(Ref ref) => const [
  TagStyle(
    borderColor: Color(0xFFA8A8A8),
    backgroundColor: Color(0xFF232323),
    textColor: Color(0xFFE0E0E0),
  ),
  TagStyle(
    borderColor: Color(0xFF8AA4C0),
    backgroundColor: Color(0xFF243447),
    textColor: Color(0xFFD6E2EF),
  ),
  TagStyle(
    borderColor: Color(0xFF8CC5AE),
    backgroundColor: Color(0xFF064E3B),
    textColor: Color(0xFFD2EEE3),
  ),
  TagStyle(
    borderColor: Color(0xFFB0C58C),
    backgroundColor: Color(0xFF1A2E05),
    textColor: Color(0xFFE4EED2),
  ),
  TagStyle(
    borderColor: Color(0xFFC5B88C),
    backgroundColor: Color(0xFF451A03),
    textColor: Color(0xFFEEE8D2),
  ),
  TagStyle(
    borderColor: Color(0xFFC5A98C),
    backgroundColor: Color(0xFF431407),
    textColor: Color(0xFFEEE1D2),
  ),
  TagStyle(
    borderColor: Color(0xFFC58C93),
    backgroundColor: Color(0xFF4C0519),
    textColor: Color(0xFFEED2D6),
  ),
  TagStyle(
    borderColor: Color(0xFFBD8CC5),
    backgroundColor: Color(0xFF4A044E),
    textColor: Color(0xFFEBD2EE),
  ),
  TagStyle(
    borderColor: Color(0xFF988CC5),
    backgroundColor: Color(0xFF2E1065),
    textColor: Color(0xFFD8D2EE),
  ),
  TagStyle(
    borderColor: Color(0xFF8CA7C5),
    backgroundColor: Color(0xFF172554),
    textColor: Color(0xFFD2E0EE),
  ),
  TagStyle(
    borderColor: Color(0xFF8CBEC5),
    backgroundColor: Color(0xFF083344),
    textColor: Color(0xFFD2EBEE),
  ),
  TagStyle(
    borderColor: Color(0xFF8FC9B5),
    backgroundColor: Color(0xFF1F3D36),
    textColor: Color(0xFFCDEEE2),
  ),
];