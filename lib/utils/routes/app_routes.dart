import 'package:go_router/go_router.dart';
import 'package:tastify/model/recipe_model.dart';
import 'package:tastify/view/views.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: SplashScreen.name,
    routes: [
      GoRoute(
        path: SplashScreen.name,
        name: SplashScreen.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: LoginScreen.name,
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: SignUpScreen.name,
        name: SignUpScreen.name,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: ForgotPasswordScreen.name,
        name: ForgotPasswordScreen.name,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: SetPasswordScreen.name,
        name: SetPasswordScreen.name,
        builder: (context, state) {
          final email = state.extra as String?;
          return SetPasswordScreen(email: email ?? '');
        },
      ),
      GoRoute(
        path: OtpVerifyScreen.name,
        name: OtpVerifyScreen.name,
        builder: (context, state) {
          final email = state.extra as String?;
          return OtpVerifyScreen(email: email ?? '');
        },
      ),
      GoRoute(
        path: MainBottomNavBar.name,
        name: MainBottomNavBar.name,
        builder: (context, state) => const MainBottomNavBar(),
      ),
      GoRoute(
        path: CategoryListScreen.name,
        name: CategoryListScreen.name,
        builder: (context, state) => const CategoryListScreen(),
      ),
      GoRoute(
        path: MyRecipeScreen.name,
        name: MyRecipeScreen.name,
        builder: (context, state) => const MyRecipeScreen(),
      ),
      GoRoute(
        path: FeaturedRecipeListScreen.name,
        name: FeaturedRecipeListScreen.name,
        builder: (context, state) => const FeaturedRecipeListScreen(),
      ),
      GoRoute(
        path: PopularListScreen.name,
        name: PopularListScreen.name,
        builder: (context, state) => const PopularListScreen(),
      ),
      GoRoute(
        path: SearchListScreen.name,
        name: SearchListScreen.name,
        builder: (context, state) => const SearchListScreen(),
      ),
      GoRoute(
        path: AddRecipeScreen.name,
        name: AddRecipeScreen.name,
        builder: (context, state) => const AddRecipeScreen(),
      ),
      GoRoute(
        path: CategoryWiseListScreen.name,
        name: CategoryWiseListScreen.name,
        builder: (context, state) {
          final categoryName = state.extra as String?;
          return CategoryWiseListScreen(categoryName: categoryName ?? '');
        },
      ),
      GoRoute(
        path: BlogDetailsScreen.name,
        name: BlogDetailsScreen.name,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return BlogDetailsScreen(blogDetails: data ?? {});
        },
      ),
      GoRoute(
        path: AddBlogScreen.name,
        name: AddBlogScreen.name,
        builder: (context, state) => const AddBlogScreen(),
      ),
      GoRoute(
        path: ProfileEditScreen.name,
        name: ProfileEditScreen.name,
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: UpdateRecipeScreen.name,
        name: UpdateRecipeScreen.name,
        builder: (context, state) {
          final recipeData = state.extra as RecipeModel?;
          return UpdateRecipeScreen(recipe: recipeData!);
        },
      ),
      GoRoute(
        path: RecipeDetailsScreen.name,
        name: RecipeDetailsScreen.name,
        builder: (context, state) {
          final recipe = state.extra as Map<String, dynamic>?;
          return RecipeDetailsScreen(recipeDetails: recipe!);
        },
      ),
      GoRoute(
        path: ChangePasswordScreen.name,
        name: ChangePasswordScreen.name,
        builder: (context, state) {
          final email = state.extra as String?;
          return ChangePasswordScreen(email: email);
        },
      ),
      GoRoute(
        path: RecipeFeedbackScreen.name,
        name: RecipeFeedbackScreen.name,
        builder: (context, state) {
          return RecipeFeedbackScreen();
        },
      ),
      // Add more GoRoutes as needed
    ],
  );
}
