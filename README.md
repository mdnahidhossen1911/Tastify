# Tastify a recipe application

<img src="https://raw.githubusercontent.com/mdnahidhossen1911/Tastify/refs/heads/master/banner.jpg?token=GHSAT0AAAAAADGVXUMAW3I7DNE2X55QICYI2D46ZXQ" />

We are going to practice the Agile Development process through this module by
building a Food App. Learners will work as a team and solve problems through
discussion.

__.env file__
~~~
APPNAME='Tastify'
GOOGLESIGNID=' '
SUPABASEURL=' '
ANOKEY=' '
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
- Light/Dark Mode: Switch between light and dark themes.

figma: <a href="https://www.figma.com/design/jzNSKXN5lFN3ZeBxPIEm9p/Tastify?node-id=0-1&t=T8wn1dqrzmGuy2pM-1" target="_blank">Tastify App UI</a>

# Supabase 
## Table: `Users`

The `Users` table is a core component for storing all user accounts. Below are the details for each column:

| Column Name   | Type        | Default Value        | Primary Key |
| :------------ | :---------- | :------------------- | :---------- |
| **`id`** | `uuid`      | `gen_random_uuid()`  | ✅ Yes      |
| **`name`** | `text`      | `NULL`               | ❌ No       |
| **`email`** | `varchar`   | `NULL`               | ❌ No       |
| **`password`**| `varchar`   | `NULL`               | ❌ No       |
| **`photo`** | `varchar`   | `NULL`               | ❌ No       |
| **`create_at`**| `timestamp` | `now()`              | ❌ No       |

---


## Table: `carousel`

| Column Name    | Type        | Default Value        | Primary Key |
| :------------- | :---------- | :------------------- | :---------- |
| **`id`** | `uuid`      | `gen_random_uuid()`  | ✅ Yes      |
| **`image`** | `varchar`   | `NULL`               | ❌ No       |
| **`created_at`** | `timestamp` | `now()`              | ❌ No       |

---

## Table: `category`

| Column Name    | Type        | Default Value        | Primary Key |
| :------------- | :---------- | :------------------- | :---------- |
| **`id`** | `uuid`      | `gen_random_uuid()`  | ✅ Yes      |
| **`created_at`** | `timestamp` | `now()`              | ❌ No       |
| **`title`** | `varchar`   | `NULL`               | ❌ No       |
| **`icon`** | `varchar`   | `NULL`               | ❌ No       |

---

## Table: `recipe`

| Column Name      | Type        | Default Value        | Primary Key |
| :--------------- | :---------- | :------------------- | :---------- |
| **`id`** | `uuid`      | `gen_random_uuid()`  | ✅ Yes      |
| **`user_id`** | `uuid`      | `gen_random_uuid()`  | ❌ No       |
| **`title`** | `text`      | `NULL`               | ❌ No       |
| **`photo`** | `varchar`   | `NULL`               | ❌ No       |
| **`instructions`** | `varchar`   | `NULL`               | ❌ No       |
| **`ingredients`** | `varchar`   | `NULL`               | ❌ No       |
| **`nutrition_info`** | `varchar`   | `NULL`               | ❌ No       |
| **`created_at`** | `timestamp` | `now()`              | ❌ No       |
| **`cid`** | `uuid`      | `NULL`               | ❌ No       |
| **`description`** | `varchar`   | `NULL`               | ❌ No       |
| **`prep_time`** | `text`      | `NULL`               | ❌ No       |
| **`cook_time`** | `text`      | `NULL`               | ❌ No       |
| **`category_nam`** | `text`      | `NULL`               | ❌ No       |
| **`favourite`** | `int8`      | `0::bigint`          | ❌ No       |

## 🔗 Foreign Keys

The `recipe` table establishes relationships with other tables to maintain data integrity and enable comprehensive data querying.

| Foreign Key Name   | Relation To         | Columns             |
| :----------------- | :------------------ | :------------------ |
| `recipe_user_id_fkey` | `public.Users`      | `user_id` &rarr; `public.Users.id` |
| `recipe_cid_fkey`  | `public.category`   | `cid` &rarr; `public.category.id` |

---

## Table: `favourites`

| Column Name    | Type        | Default Value        | Primary Key |
| :------------- | :---------- | :------------------- | :---------- |
| **`id`** | `uuid`      | `gen_random_uuid()`  | ✅ Yes      |
| **`rid`** | `uuid`      | `gen_random_uuid()`  | ❌ No       |
| **`uid`** | `uuid`      | `gen_random_uuid()`  | ❌ No       |
| **`created_at`** | `timestamp` | `now()`              | ❌ No       |


## 🔗 Foreign Keys

The `favourites` table establishes relationships with other tables to link favourite entries to specific recipes and users.

| Foreign Key Name     | Relation To       | Columns           |
| :------------------- | :---------------- | :---------------- |
| `favourites_rid_fkey` | `public.recipe`   | `rid` &rarr; `public.recipe.id` |
| `favourites_uid_fkey` | `public.Users`    | `uid` &rarr; `public.Users.id`  |

---

## Table: `feedback`

| Column Name    | Type        | Default Value        | Primary Key | Description                              |
| :------------- | :---------- | :------------------- | :---------- | :--------------------------------------- |
| **`id`** | `uuid`      | `gen_random_uuid()`  | ✅ Yes      | Unique identifier for each feedback entry. |
| **`uid`** | `uuid`      | `gen_random_uuid()`  | ❌ No       | User ID of the person providing feedback.  |
| **`rid`** | `uuid`      | `gen_random_uuid()`  | ❌ No       | Recipe ID that the feedback is for.      |
| **`feedback`** | `varchar`   | `NULL`               | ❌ No       | The actual feedback text.                |
| **`created_at`** | `timestamp` | `now()`              | ❌ No       | Timestamp when the feedback was created. |
| **`rwid`** | `uuid`      | `NULL`               | ❌ No       | User ID of the recipe writer.            |


## 🔗 Foreign Keys

The `feedback` table establishes relationships with other tables to link feedback entries to specific users and recipes.

| Foreign Key Name   | Relation To       | Columns           |
| :----------------- | :---------------- | :---------------- |
| `feedback_uid_fkey` | `public.Users`    | `uid` &rarr; `public.Users.id` |
| `feedback_rid_fkey` | `public.recipe`   | `rid` &rarr; `public.recipe.id` |

---

## Table: `blog`

| Column Name    | Type        | Default Value        | Primary Key |
| :------------- | :---------- | :------------------- | :---------- |
| **`id`** | `uuid`      | `gen_random_uuid()`  | ✅ Yes      |
| **`title`** | `text`      | `NULL`               | ❌ No       |
| **`image`** | `varchar`   | `NULL`               | ❌ No       |
| **`content`** | `text`      | `NULL`               | ❌ No       |
| **`created_at`** | `timestamp` | `now()`              | ❌ No       |
| **`uid`** | `uuid`      | `NULL`               | ❌ No       |


## 🔗 Foreign Keys

The `blog` table establishes a relationship with the `Users` table to link blog posts to their respective authors.

| Foreign Key Name   | Relation To       | Columns           |
| :----------------- | :---------------- | :---------------- |
| `blog_uid_fkey`    | `public.Users`    | `uid` &rarr; `public.Users.id` |

<br>

## 💖 A Big Thank You for Your Visit!

We're excited to share our project with you. We hope you found this overview helpful.

* If you have suggestions or find any issues, please consider [opening an issue](https://github.com/mdnahidhossen1911/Tastify/issues).
* Even better, if you'd like to contribute, we'd love to have your help!

Thanks again for your time!

