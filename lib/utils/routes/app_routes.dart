import 'package:go_router/go_router.dart';
import 'package:tastify/model/recipe_model.dart';
import 'package:tastify/view/views.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: SplashView.name,
    routes: [
      GoRoute(
        path: SplashView.name,
        name: SplashView.name,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: LoginView.name,
        name: LoginView.name,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: SignUpView.name,
        name: SignUpView.name,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: ForgotPasswordView.name,
        name: ForgotPasswordView.name,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: SetPasswordView.name,
        name: SetPasswordView.name,
        builder: (context, state) {
          final email = state.extra as String?;
          return SetPasswordView(email: email ?? '');
        },
      ),
      GoRoute(
        path: OtpVerifyView.name,
        name: OtpVerifyView.name,
        builder: (context, state) {
          final email = state.extra as String?;
          return OtpVerifyView(email: email ?? '');
        },
      ),
      GoRoute(
        path: MainBottomNavBarView.name,
        name: MainBottomNavBarView.name,
        builder: (context, state) => const MainBottomNavBarView(),
      ),
      GoRoute(
        path: CategoryListView.name,
        name: CategoryListView.name,
        builder: (context, state) => const CategoryListView(),
      ),
      GoRoute(
        path: MyRecipeView.name,
        name: MyRecipeView.name,
        builder: (context, state) => const MyRecipeView(),
      ),
      GoRoute(
        path: FeaturedRecipeListView.name,
        name: FeaturedRecipeListView.name,
        builder: (context, state) => const FeaturedRecipeListView(),
      ),
      GoRoute(
        path: PopularListView.name,
        name: PopularListView.name,
        builder: (context, state) => const PopularListView(),
      ),
      GoRoute(
        path: SearchListView.name,
        name: SearchListView.name,
        builder: (context, state) => const SearchListView(),
      ),
      GoRoute(
        path: AddRecipeView.name,
        name: AddRecipeView.name,
        builder: (context, state) => const AddRecipeView(),
      ),
      GoRoute(
        path: CategoryWiseListView.name,
        name: CategoryWiseListView.name,
        builder: (context, state) {
          final categoryName = state.extra as String?;
          return CategoryWiseListView(categoryName: categoryName ?? '');
        },
      ),
      GoRoute(
        path: BlogDetailsView.name,
        name: BlogDetailsView.name,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          return BlogDetailsView(blogDetails: data ?? {});
        },
      ),
      GoRoute(
        path: AddBlogView.name,
        name: AddBlogView.name,
        builder: (context, state) => const AddBlogView(),
      ),
      GoRoute(
        path: ProfileEditView.name,
        name: ProfileEditView.name,
        builder: (context, state) => const ProfileEditView(),
      ),
      GoRoute(
        path: UpdateRecipeView.name,
        name: UpdateRecipeView.name,
        builder: (context, state) {
          final recipeData = state.extra as RecipeModel?;
          return UpdateRecipeView(recipe: recipeData!);
        },
      ),
      GoRoute(
        path: RecipeDetailsView.name,
        name: RecipeDetailsView.name,
        builder: (context, state) {
          final recipe = state.extra as Map<String, dynamic>?;
          return RecipeDetailsView(recipeDetails: recipe!);
        },
      ),
      GoRoute(
        path: ChangePasswordView.name,
        name: ChangePasswordView.name,
        builder: (context, state) {
          final email = state.extra as String?;
          return ChangePasswordView(email: email);
        },
      ),
      GoRoute(
        path: RecipeFeedbackView.name,
        name: RecipeFeedbackView.name,
        builder: (context, state) {
          return RecipeFeedbackView();
        },
      ),
      // Add more GoRoutes as needed
    ],
  );
}
