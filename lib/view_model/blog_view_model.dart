import 'package:flutter/cupertino.dart';

import '../utils/app_logger.dart';
import '../utils/supabase.dart';
import '../utils/supabase_tables.dart';

class BlogViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<Map<String, dynamic>> _blogs = [];

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get blogs => _blogs;

  Future<bool> addBlog(Map<String, dynamic> blog) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res =
          await supaBase
              .from(SupaBaseTables.blog)
              .insert(blog)
              .select()
              .single();

      appLogger.i("Blog Added: ${res['id']}");
      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      appLogger.e("Failed to add blog: $e");

      return false;
    }
  }

  Future<void> fetchBlogs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await supaBase
          .from(SupaBaseTables.blog)
          .select('*, Users(name,photo)')
          .order('created_at', ascending: false);

      if (res.isNotEmpty) {
        _blogs = List<Map<String, dynamic>>.from(res);
      } else {
        _blogs = [];
      }

      appLogger.i("Blogs fetched successfully");
    } catch (e) {
      appLogger.e("Failed to fetch blogs: $e");
      _blogs = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
