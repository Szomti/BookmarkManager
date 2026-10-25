import '../entities/tag_style.dart';

abstract class TagRepository {
  Future<int> addTag(String label, TagStyle style);
}