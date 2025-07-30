# Tastify a recipe application

<img src="https://mpfahmozslhajtyumlug.supabase.co/storage/v1/object/public/github//banner.jpg" />

Welcome to **Tastify**! This project is a recipe application designed to be built using an **Agile Development process**. Our team is collaboratively solving problems and implementing features through continuous discussion and iteration.



## Our Team

We believe in teamwork and shared responsibility. Here's a breakdown of our roles:

* **Nahid Hossen**
    * **Role:** System Design, Figma Design, Backend Design & Implementation
    * **GitHub:** [mdnahidhossen1911](https://github.com/mdnahidhossen1911)
* **Jahangir Alam**
    * **Role:** App UI Design
    * **GitHub:** [jahangirsim](https://github.com/jahangirsim)
* **Mahfuz Ahmed**
    * **Role:** App UI Design
    * **GitHub:** [MahfuzAhmed28](https://github.com/MahfuzAhmed28)

## Device Support

Tastify is being developed to support a wide range of mobile users:

* **Android** 
* **iOS** 

## Environment Configuration

To set up the project locally, you'll need a `.env` file with the following variables:

~~~
APPNAME='Tastify'
GOOGLESIGNID='YOUR_GOOGLE_SIGN_IN_ID'
SUPABASEURL='YOUR_SUPABASE_PROJECT_URL'
ANOKEY='YOUR_SUPABASE_ANON_KEY''
~~~

## Features to Build
- Authentication: Users can sign up using email or social login and log in to their
accounts.
- User Profile: Users can create and update their profile with basic information.
- Home Page: Displays featured recipes, categories, and popular items.
- Recipe Details: Shows recipe image, ingredients, instructions, and nutrition info.
- Upload Recipe: Users can add their recipes with name, image, and steps.
- Edit Recipe: Users can edit recipes they uploaded.
- Delete Recipe: Users can delete their recipe posts.
- Search Recipes: Users can search for recipes by name or category.
- Wishlist/Favourites: Users can save recipes to a favourites list.
- Blog Section: Read articles related to food, cooking tips, and healthy eating.
- Blog Post Page: Full blog article view with related content suggestions.
- Contact Page: Users can send messages or feedback through a contact form.


## UI/UX Design (Figma)

Explore the visual design and user experience of the Tastify app:

* **Figma Prototype:** [Tastify App UI](https://www.figma.com/design/jzNSKXN5lFN3ZeBxPIEm9p/Tastify?node-id=0-1&t=T8wn1dqrzmGuy2pM-1)


---

# Supabase Database Schema

### Manual Tables (Data added manually via dashboard)

These tables must be populated manually. Image fields should store direct **image URLs**.

#### Table: `category`

| Column       | Type      | Notes            |
| ------------ | --------- | ---------------- |
| `id`         | uuid      | Primary key      |
| `created_at` | timestamp | Auto-generated   |
| `title`      | varchar   | Category title   |
| `icon`       | varchar   | Image URL (icon) |

#### Table: `carousel`

| Column       | Type      | Notes          |
| ------------ | --------- | -------------- |
| `id`         | uuid      | Primary key    |
| `image`      | varchar   | Image URL      |
| `created_at` | timestamp | Auto-generated |

---

###  Dynamic Tables (Managed via App)

All image fields here will store **Base64 strings** submitted by the user via the app.

#### Table: `Users`

Stores user accounts.

| Column      | Type      | Primary | Notes                     |
| ----------- | --------- | ------- | ------------------------- |
| `id`        | uuid      | ✅       | Primary key               |
| `name`      | text      | ❌       |                           |
| `email`     | varchar   | ❌       |                           |
| `password`  | varchar   | ❌       | (optional if using OAuth) |
| `photo`     | varchar   | ❌       | Base64 image string       |
| `create_at` | timestamp | ❌       | Auto timestamp            |

#### Table: `recipe`

Core recipe details.

| Column           | Type      | Notes                        |
| ---------------- | --------- | ---------------------------- |
| `id`             | uuid      | Primary key                  |
| `user_id`        | uuid      | FK → Users.id                |
| `title`          | text      | Recipe name                  |
| `photo`          | varchar   | Base64 image                 |
| `instructions`   | varchar   |                              |
| `ingredients`    | varchar   |                              |
| `nutrition_info` | varchar   |                              |
| `description`    | varchar   |                              |
| `prep_time`      | text      |                              |
| `cook_time`      | text      |                              |
| `category_nam`   | text      | (redundant if category used) |
| `cid`            | uuid      | FK → category.id             |
| `favourite`      | int8      | Defaults to 0                |
| `created_at`     | timestamp | Auto timestamp               |

#### Table: `favourites`

User's saved recipes.

| Column       | Type      | Notes          |
| ------------ | --------- | -------------- |
| `id`         | uuid      | Primary key    |
| `rid`        | uuid      | FK → recipe.id |
| `uid`        | uuid      | FK → Users.id  |
| `created_at` | timestamp | Auto timestamp |

#### Table: `feedback`

Stores user feedback on recipes.

| Column       | Type      | Notes                  |
| ------------ | --------- | ---------------------- |
| `id`         | uuid      | Primary key            |
| `uid`        | uuid      | FK → Users.id          |
| `rid`        | uuid      | FK → recipe.id         |
| `rwid`       | uuid      | Recipe owner's user ID |
| `feedback`   | varchar   | Text content           |
| `created_at` | timestamp | Auto timestamp         |

#### Table: `blog`

User-generated blog posts.

| Column       | Type      | Notes                |
| ------------ | --------- | -------------------- |
| `id`         | uuid      | Primary key          |
| `title`      | text      |                      |
| `image`      | varchar   | Base64 image         |
| `content`    | text      | Full article content |
| `uid`        | uuid      | FK → Users.id        |
| `created_at` | timestamp | Auto timestamp       |

---
<br>

## 💖 A Big Thank You for Your Visit!

We're excited to share our project with you. We hope you found this overview helpful.

* If you have suggestions or find any issues, please consider [opening an issue](https://github.com/mdnahidhossen1911/Tastify/issues).
* Even better, if you'd like to contribute, we'd love to have your help!

Thanks again for your time!

