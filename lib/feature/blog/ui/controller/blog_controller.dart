import 'package:get/get.dart';
import 'package:tastify/core/app_logger.dart';
import 'package:tastify/core/supabase.dart';

class BlogController extends GetxController{

  bool _isLoading = false;
  List<Map<String,dynamic>> _blogs = [];

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get blogs => _blogs;

  Future<bool> addBlog(Map<String, dynamic> blog) async {
    _isLoading = true;
    update();

    try{

      final res = await supabase.from('blog').insert(blog).select().single();

      appLogger.i("Blog Added: ${res['id']}");
      _isLoading = false;
      update();

      return true;

    }catch(e) {
      _isLoading = false;
      update();
      appLogger.e("Failed to add blog: $e");

      return false;
    }
  }

  Future<void> fetchBlogs() async {
    _isLoading = true;
    update();

    try {
      final res = await supabase.from('blog').select('*, Users(name,photo)').order('created_at', ascending: false);

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
      update();
    }
  }



}