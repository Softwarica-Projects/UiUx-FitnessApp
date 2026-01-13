
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fitness`
--

-- --------------------------------------------------------

--
-- Table structure for table `assign_diets`
--

CREATE TABLE `assign_diets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `diet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assign_workouts`
--

CREATE TABLE `assign_workouts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `workout_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `body_parts`
--

CREATE TABLE `body_parts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `body_parts`
--

INSERT INTO `body_parts` (`id`, `title`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Leg', 'leg', 'active', '2025-10-21 21:20:34', '2025-10-21 21:20:34'),
(2, 'Chest', 'chest', 'active', '2025-10-22 07:56:54', '2025-10-22 07:56:54'),
(3, 'Back', 'back', 'active', '2025-10-22 07:57:03', '2025-10-22 07:57:03'),
(4, 'Arms', 'arms', 'active', '2025-10-22 07:57:38', '2025-10-22 07:57:38'),
(5, 'Neck', 'neck', 'active', '2025-10-22 07:58:00', '2025-10-22 07:58:00'),
(6, 'Abs', 'abs', 'active', '2025-10-22 08:55:00', '2025-10-22 08:55:00'),
(7, 'Full Body', 'full-body', 'active', '2025-10-22 08:55:11', '2025-10-22 08:55:11'),
(8, 'Shoulders', 'shoulders', 'active', '2025-10-22 08:57:57', '2025-10-22 08:57:57'),
(9, 'Bicep', 'bicep', 'active', '2025-10-25 21:35:40', '2025-10-25 21:35:40'),
(10, 'Tricep', 'tricep', 'active', '2025-10-25 21:35:54', '2025-10-25 21:35:54');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category_diets`
--

CREATE TABLE `category_diets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_diets`
--

INSERT INTO `category_diets` (`id`, `title`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'High Protein', 'high-protein', 'active', '2025-10-22 09:08:03', '2025-10-22 09:08:03'),
(2, 'Snack', 'snack', 'active', '2025-10-22 09:08:11', '2025-10-22 09:08:11'),
(3, 'Vegetarian', 'vegetarian', 'active', '2025-10-22 09:08:22', '2025-10-22 09:08:22'),
(4, 'Low Carb', 'low-carb', 'active', '2025-10-22 09:08:30', '2025-10-22 09:08:30'),
(5, 'Balanced', 'balanced', 'active', '2025-10-22 09:08:38', '2025-10-22 09:08:38'),
(6, 'Breakfast', 'breakfast', 'active', '2025-10-22 09:08:47', '2025-10-22 09:08:47'),
(7, 'Lunch', 'lunch', 'active', '2025-10-22 09:08:56', '2025-10-22 09:08:56'),
(8, 'Low Fat', 'low-fat', 'active', '2025-10-22 09:20:39', '2025-10-22 09:20:39'),
(9, 'Flexitarian Diet', 'flexitarian-diet', 'active', '2025-10-25 21:32:59', '2025-10-25 21:32:59'),
(10, 'High Carb Diet', 'high-carb-diet', 'active', '2025-10-25 21:33:28', '2025-10-25 21:33:28');

-- --------------------------------------------------------

--
-- Table structure for table `class_schedules`
--

CREATE TABLE `class_schedules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `workout_id` bigint(20) UNSIGNED DEFAULT NULL,
  `workout_title` varchar(255) DEFAULT NULL,
  `workout_type` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `link` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `class_schedules`
--

INSERT INTO `class_schedules` (`id`, `class_name`, `workout_id`, `workout_title`, `workout_type`, `start_date`, `end_date`, `start_time`, `end_time`, `name`, `link`, `created_at`, `updated_at`) VALUES
(1, 'Test', 1, NULL, 'workout', '2025-10-22', '2025-10-24', '12:00:00', '18:00:00', 'tewst', NULL, '2025-10-21 21:30:47', '2025-10-21 21:30:47'),
(2, 'Warmup class', 1, NULL, 'workout', '2025-10-30', '2025-10-31', '12:00:00', '14:00:00', 'Test', NULL, '2025-10-29 08:06:14', '2025-10-29 08:06:14');

-- --------------------------------------------------------

--
-- Table structure for table `class_schedule_plans`
--

CREATE TABLE `class_schedule_plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `class_schedule_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `diets`
--

CREATE TABLE `diets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `categorydiet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `calories` varchar(255) DEFAULT NULL,
  `carbs` varchar(255) DEFAULT NULL,
  `protein` varchar(255) DEFAULT NULL,
  `fat` varchar(255) DEFAULT NULL,
  `servings` varchar(255) DEFAULT NULL,
  `total_time` varchar(255) DEFAULT NULL,
  `is_featured` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `ingredients` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `diets`
--

INSERT INTO `diets` (`id`, `title`, `slug`, `categorydiet_id`, `calories`, `carbs`, `protein`, `fat`, `servings`, `total_time`, `is_featured`, `status`, `ingredients`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Grilled Chicken Salad', 'grilled-chicken-salad', 1, '350', '20', '40', '10', '1', '20', 'yes', 'active', '<h3 data-start=\"111\" data-end=\"144\">🌿 <strong data-start=\"118\" data-end=\"133\">Ingredients</strong> (serves 2)</h3>\r\n    <p data-start=\"146\" data-end=\"166\"><strong data-start=\"146\" data-end=\"166\">For the chicken:</strong></p>\r\n    <ul data-start=\"167\" data-end=\"354\">\r\n        <li data-start=\"167\" data-end=\"207\"><p data-start=\"169\" data-end=\"207\">2 boneless, skinless chicken breasts</p></li>\r\n        <li data-start=\"208\" data-end=\"228\"><p data-start=\"210\" data-end=\"228\">1 tbsp olive oil</p></li>\r\n        <li data-start=\"229\" data-end=\"252\"><p data-start=\"231\" data-end=\"252\">1 tsp garlic powder</p></li>\r\n        <li data-start=\"253\" data-end=\"270\"><p data-start=\"255\" data-end=\"270\">1 tsp paprika</p></li>\r\n        <li data-start=\"271\" data-end=\"285\"><p data-start=\"273\" data-end=\"285\">&frac12; tsp salt</p></li>\r\n    </ul>', 'Delicious grilled chicken salad', '2026-01-13 14:31:33', '2026-01-13 14:31:33');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `title`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Resistance Band', 'test-equip', 'active', '2025-10-21 21:21:00', '2025-10-22 08:02:21'),
(4, 'Bench', 'bench', 'active', '2025-10-22 08:02:42', '2025-10-22 08:02:42'),
(5, 'Yoga Mat', 'yoga-mat', 'active', '2025-10-22 08:02:52', '2025-10-22 08:02:52'),
(6, 'Treadmill', 'treadmill', 'active', '2025-10-22 08:03:01', '2025-10-22 08:03:01'),
(7, 'Stationary Bike', 'stationary-bike', 'active', '2025-10-22 08:03:13', '2025-10-22 08:03:13'),
(8, 'Foam Roller', 'foam-roller', 'active', '2025-10-22 08:03:25', '2025-10-22 08:03:25'),
(9, 'Battle Rope', 'battle-rope', 'active', '2025-10-22 08:03:35', '2025-10-22 08:03:35'),
(10, 'Cable Machine', 'cable-machine', 'active', '2025-10-22 08:03:45', '2025-10-22 08:03:45'),
(11, 'Pull-up Bar', 'pull-up-bar', 'active', '2025-10-22 08:04:07', '2025-10-22 08:04:07'),
(12, 'Dumbells', 'none', 'active', '2025-10-22 08:06:18', '2025-10-26 01:48:07'),
(13, 'Medicine Ball', 'medicine-ball', 'active', '2025-10-22 08:55:38', '2025-10-22 08:55:38'),
(15, 'Jump Rope', 'jump-rope', 'active', '2025-10-26 01:49:15', '2025-10-26 01:49:15'),
(16, 'Kettlebells', 'kettlebells', 'active', '2025-10-26 01:49:36', '2025-10-26 01:49:36'),
(18, 'Barbell', 'barbell-2', 'active', '2025-10-26 01:49:58', '2025-10-26 01:49:58'),
(20, 'Weight Plate', 'weight-plate-1', 'active', '2025-10-26 01:50:27', '2025-10-26 01:50:27');

-- --------------------------------------------------------

--
-- Table structure for table `exercises`
--

CREATE TABLE `exercises` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `instruction` text DEFAULT NULL,
  `tips` text DEFAULT NULL,
  `video_type` varchar(255) DEFAULT NULL,
  `video_url` text DEFAULT NULL,
  `bodypart_ids` text DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `based` varchar(255) DEFAULT NULL COMMENT 'reps, time',
  `type` varchar(255) DEFAULT NULL COMMENT 'sets, duration',
  `equipment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `level_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sets` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`sets`)),
  `status` varchar(255) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `exercises`
--

INSERT INTO `exercises` (`id`, `title`, `slug`, `instruction`, `tips`, `video_type`, `video_url`, `bodypart_ids`, `duration`, `based`, `type`, `equipment_id`, `level_id`, `sets`, `status`, `created_at`, `updated_at`) VALUES
(2, 'Push ups', 'push-ups', NULL, NULL, 'url', NULL, '[\"2\"]', NULL, 'reps', 'sets', 12, 1, '[{\"reps\":\"12\",\"weight\":null,\"rest\":\"45\",\"time\":null},{\"reps\":\"12\",\"weight\":null,\"rest\":\"45\",\"time\":null},{\"reps\":\"12\",\"weight\":null,\"rest\":\"45\",\"time\":null}]', 'active', '2025-10-22 08:07:19', '2025-10-22 08:07:19'),
(3, 'Bench Press', 'bench-press', NULL, NULL, 'url', NULL, '[\"2\"]', NULL, 'reps', 'sets', 18, 2, '[{\"reps\":\"10\",\"weight\":\"40\",\"rest\":\"60\",\"time\":null},{\"reps\":\"10\",\"weight\":\"40\",\"rest\":\"60\",\"time\":null},{\"reps\":\"10\",\"weight\":\"40\",\"rest\":\"60\",\"time\":null},{\"reps\":\"10\",\"weight\":\"40\",\"rest\":\"60\",\"time\":null}]', 'active', '2025-10-22 08:08:29', '2025-11-30 01:14:31'),
(4, 'Dumbbell Fly', 'dumbbell-fly', NULL, NULL, 'url', NULL, '[\"2\"]', NULL, 'reps', 'sets', 2, 2, '[{\"reps\":\"12\",\"weight\":\"8\",\"rest\":\"45\",\"time\":null},{\"reps\":\"12\",\"weight\":\"8\",\"rest\":\"45\",\"time\":null}]', 'active', '2025-10-22 08:09:17', '2025-10-22 08:09:17'),
(5, 'Pull-Ups', 'pull-ups', NULL, NULL, 'url', NULL, '[\"3\"]', NULL, 'reps', 'sets', 11, 2, '[{\"reps\":\"8\",\"weight\":null,\"rest\":\"60\",\"time\":null},{\"reps\":\"8\",\"weight\":null,\"rest\":\"60\",\"time\":null},{\"reps\":\"8\",\"weight\":null,\"rest\":\"60\",\"time\":null},{\"reps\":\"8\",\"weight\":null,\"rest\":\"60\",\"time\":null}]', 'active', '2025-10-22 08:09:49', '2025-10-22 08:09:49'),
(6, 'Bent Over Row', 'bent-over-row', NULL, NULL, 'url', NULL, '[\"3\"]', NULL, 'reps', 'sets', 20, 3, '[{\"reps\":\"10\",\"weight\":\"50\",\"rest\":\"60\",\"time\":null},{\"reps\":\"10\",\"weight\":\"50\",\"rest\":\"60\",\"time\":null},{\"reps\":\"10\",\"weight\":\"50\",\"rest\":\"60\",\"time\":null},{\"reps\":\"10\",\"weight\":\"50\",\"rest\":\"60\",\"time\":null}]', 'active', '2025-10-22 08:51:07', '2025-11-30 01:15:24'),
(7, 'Bicep Curl', 'bicep-curl', NULL, NULL, 'url', NULL, '[\"4\"]', NULL, 'reps', 'sets', 18, 1, '[{\"reps\":\"12\",\"weight\":\"8\",\"rest\":\"30\",\"time\":null},{\"reps\":\"12\",\"weight\":\"8\",\"rest\":\"30\",\"time\":null},{\"reps\":\"12\",\"weight\":\"8\",\"rest\":\"30\",\"time\":null}]', 'active', '2025-10-22 08:52:43', '2025-11-30 01:17:15'),
(8, 'Tricep Dips', 'tricep-dips', NULL, NULL, 'url', NULL, '[\"4\"]', NULL, 'reps', 'sets', 4, 2, '[{\"reps\":\"10\",\"weight\":null,\"rest\":\"45\",\"time\":null},{\"reps\":\"10\",\"weight\":null,\"rest\":\"45\",\"time\":null},{\"reps\":\"10\",\"weight\":null,\"rest\":\"45\",\"time\":null}]', 'active', '2025-10-22 08:53:25', '2025-10-22 08:53:25'),
(9, 'Barbell Squat', 'barbell-squat', NULL, NULL, 'url', NULL, '[\"1\"]', NULL, 'reps', 'sets', 3, 3, '[{\"reps\":\"8\",\"weight\":\"60\",\"rest\":\"90\",\"time\":null},{\"reps\":\"8\",\"weight\":\"60\",\"rest\":\"90\",\"time\":null},{\"reps\":\"8\",\"weight\":\"60\",\"rest\":\"90\",\"time\":null},{\"reps\":\"8\",\"weight\":\"60\",\"rest\":\"90\",\"time\":null}]', 'active', '2025-10-22 08:54:16', '2025-10-22 08:54:16'),
(10, 'Russian Twists', 'russian-twists', NULL, NULL, 'url', NULL, '[\"6\"]', NULL, 'reps', 'sets', 13, 2, '[{\"reps\":\"20\",\"weight\":\"5\",\"rest\":\"30\",\"time\":null},{\"reps\":\"20\",\"weight\":\"5\",\"rest\":\"30\",\"time\":null},{\"reps\":\"20\",\"weight\":\"5\",\"rest\":\"30\",\"time\":null}]', 'active', '2025-10-22 08:55:57', '2025-10-22 08:55:57'),
(11, 'Plank', 'plank', NULL, NULL, 'url', NULL, '[\"6\"]', NULL, 'time', 'sets', 12, 1, NULL, 'active', '2025-10-22 08:56:38', '2025-10-22 08:56:38'),
(12, 'Deadlift', 'deadlift', NULL, NULL, 'url', NULL, '[\"1\"]', NULL, 'reps', 'sets', 3, 3, '[{\"reps\":\"6\",\"weight\":\"80\",\"rest\":\"90\",\"time\":null},{\"reps\":\"6\",\"weight\":\"80\",\"rest\":\"90\",\"time\":null},{\"reps\":\"6\",\"weight\":\"80\",\"rest\":\"90\",\"time\":null},{\"reps\":\"6\",\"weight\":\"80\",\"rest\":\"90\",\"time\":null}]', 'active', '2025-10-22 08:57:16', '2025-10-22 08:57:16'),
(13, 'Shoulder Press', 'shoulder-press', NULL, NULL, 'url', NULL, '[\"8\"]', NULL, 'reps', 'sets', 4, 2, '[{\"reps\":\"12\",\"weight\":\"10\",\"rest\":\"45\",\"time\":null},{\"reps\":\"12\",\"weight\":\"10\",\"rest\":\"45\",\"time\":null},{\"reps\":\"12\",\"weight\":\"10\",\"rest\":\"45\",\"time\":null}]', 'active', '2025-10-22 08:58:24', '2025-11-30 01:16:38'),
(14, 'Tricep Rope Pushdown', 'tricep-rope-pushdown', NULL, NULL, 'url', NULL, '[\"4\"]', NULL, 'reps', 'sets', 10, 3, '[{\"reps\":\"12\",\"weight\":\"25\",\"rest\":\"45\",\"time\":null},{\"reps\":\"12\",\"weight\":\"25\",\"rest\":\"45\",\"time\":null},{\"reps\":\"12\",\"weight\":\"25\",\"rest\":\"45\",\"time\":null}]', 'active', '2025-10-22 09:00:32', '2025-10-22 09:00:32'),
(15, 'Neck Extension with Band', 'neck-extension-with-band', NULL, NULL, 'url', NULL, '[\"5\"]', NULL, 'reps', 'sets', 1, 3, '[{\"reps\":\"15\",\"weight\":null,\"rest\":\"45\",\"time\":null},{\"reps\":\"15\",\"weight\":null,\"rest\":\"45\",\"time\":null},{\"reps\":\"15\",\"weight\":null,\"rest\":\"45\",\"time\":null}]', 'active', '2025-10-22 09:01:09', '2025-10-22 09:01:09'),
(16, 'Box Jumps', 'box-jumps', NULL, NULL, 'url', NULL, '[\"1\"]', '00:10:00', NULL, 'duration', 12, 2, NULL, 'active', '2025-10-22 09:01:52', '2025-11-30 01:18:32'),
(17, 'Step-Ups', 'step-ups', NULL, NULL, 'url', NULL, '[\"1\"]', NULL, 'reps', 'sets', 12, 2, '[{\"reps\":\"12\",\"weight\":\"8\",\"rest\":\"45\",\"time\":null},{\"reps\":\"12\",\"weight\":\"8\",\"rest\":\"45\",\"time\":null},{\"reps\":\"12\",\"weight\":\"8\",\"rest\":\"45\",\"time\":null}]', 'active', '2025-10-22 09:02:36', '2025-11-30 01:16:12'),
(18, 'Sumo Deadlift', 'sumo-deadlift', NULL, NULL, 'url', NULL, '[\"1\"]', NULL, 'reps', 'sets', 18, 3, '[{\"reps\":\"8\",\"weight\":\"70\",\"rest\":\"90\",\"time\":null},{\"reps\":\"8\",\"weight\":\"70\",\"rest\":\"90\",\"time\":null},{\"reps\":\"8\",\"weight\":\"70\",\"rest\":\"90\",\"time\":null}]', 'active', '2025-10-22 09:04:26', '2025-11-30 01:15:45');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `levels`
--

CREATE TABLE `levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `rate` bigint(20) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `levels`
--

INSERT INTO `levels` (`id`, `title`, `slug`, `rate`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Beginner', 'easy', 1, 'active', '2025-10-21 21:17:16', '2025-10-22 08:00:54'),
(2, 'Intermediate', 'hard', 2, 'active', '2025-10-21 21:17:25', '2025-10-22 08:00:41'),
(3, 'Advanced', 'advanced', 3, 'active', '2025-10-22 07:58:23', '2025-10-22 08:00:48');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `conversions_disk` varchar(255) DEFAULT NULL,
  `size` bigint(20) UNSIGNED NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`manipulations`)),
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`custom_properties`)),
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`generated_conversions`)),
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`responsive_images`)),
  `order_column` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`id`, `model_type`, `model_id`, `uuid`, `collection_name`, `name`, `file_name`, `mime_type`, `disk`, `conversions_disk`, `size`, `manipulations`, `custom_properties`, `generated_conversions`, `responsive_images`, `order_column`, `created_at`, `updated_at`) VALUES
(28, 'App\\Models\\Equipment', 12, 'e1bc0575-bdbc-4d78-999f-42750be578da', 'equipment_image', 'cb3468b286855fc1bac62c8cf53a4a8ff9250e54', 'cb3468b286855fc1bac62c8cf53a4a8ff9250e54.jpg', 'image/jpeg', 'public', 'public', 128539, '[]', '[]', '[]', '[]', 1, '2025-10-26 01:48:07', '2025-10-26 01:48:07'),
(36, 'App\\Models\\Exercise', 18, '89840257-efdd-4b1d-ba0a-161cc94f597f', 'exercise_image', 'person-doing-crossfit-training_23-2149162358', 'person-doing-crossfit-training_23-2149162358.jpg', 'image/avif', 'public', 'public', 39941, '[]', '[]', '[]', '[]', 1, '2025-10-26 01:52:22', '2025-10-26 01:52:22'),
(37, 'App\\Models\\Exercise', 17, '99867889-5f61-4e16-8640-444fc84d278b', 'exercise_image', 'step-ups-best-exercises-for-women-fb4bb696dd534d37be4d484785e385ed', 'step-ups-best-exercises-for-women-fb4bb696dd534d37be4d484785e385ed.jpg', 'image/jpeg', 'public', 'public', 77641, '[]', '[]', '[]', '[]', 1, '2025-10-26 01:53:11', '2025-10-26 01:53:11'),
(38, 'App\\Models\\Exercise', 16, '10869b0f-446e-4dbb-856b-3fe344e17f73', 'exercise_image', 'Box-Jump-e1745506954713', 'Box-Jump-e1745506954713.jpg', 'image/jpeg', 'public', 'public', 32419, '[]', '[]', '[]', '[]', 1, '2025-10-26 01:54:16', '2025-10-26 01:54:16'),
(39, 'App\\Models\\Exercise', 15, '63d341be-20b8-49c5-a3de-88a08c66c204', 'exercise_image', 'images (2)', 'images-(2).jpeg', 'image/jpeg', 'public', 'public', 2635, '[]', '[]', '[]', '[]', 1, '2025-10-26 01:56:28', '2025-10-26 01:56:28'),
(40, 'App\\Models\\Exercise', 14, '0c8cf0a5-a213-45c8-9110-a8fccf9743a8', 'exercise_image', 'images (3)', 'images-(3).jpeg', 'image/jpeg', 'public', 'public', 5174, '[]', '[]', '[]', '[]', 1, '2025-10-26 01:57:29', '2025-10-26 01:57:29'),
(41, 'App\\Models\\Exercise', 13, '1e27d410-5747-4b78-960b-be6e0c5ac481', 'exercise_image', 'images (4)', 'images-(4).jpeg', 'image/jpeg', 'public', 'public', 4670, '[]', '[]', '[]', '[]', 1, '2025-10-26 01:59:18', '2025-10-26 01:59:18'),
(42, 'App\\Models\\Exercise', 12, '2ec7ab22-77e7-4754-ab5d-19fe825851ae', 'exercise_image', 'images (5)', 'images-(5).jpeg', 'image/jpeg', 'public', 'public', 5899, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:00:13', '2025-10-26 02:00:13'),
(43, 'App\\Models\\Exercise', 11, '3050092c-231e-4792-8a7a-437a0adb372c', 'exercise_image', 'images (6)', 'images-(6).jpeg', 'image/jpeg', 'public', 'public', 4413, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:01:00', '2025-10-26 02:01:00'),
(44, 'App\\Models\\Exercise', 10, '818ca01e-60a7-496d-8d95-3465503ecf11', 'exercise_image', 'png-clipart-russian-twist-exercise-biceps-muscle-training-twist-workout-sport-human', 'png-clipart-russian-twist-exercise-biceps-muscle-training-twist-workout-sport-human.png', 'image/png', 'public', 'public', 42744, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:02:46', '2025-10-26 02:02:46'),
(45, 'App\\Models\\Exercise', 9, 'b4b7b42f-9105-4d0d-930c-49bb4c819b72', 'exercise_image', 'Barbell-back-squat-reproduced-from-61', 'Barbell-back-squat-reproduced-from-61.png', 'image/png', 'public', 'public', 19873, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:03:46', '2025-10-26 02:03:46'),
(46, 'App\\Models\\Exercise', 8, 'c89e4fdd-dd4f-43e2-97fd-1dfbe9f0d9f5', 'exercise_image', 'istockphoto-1354012432-612x612', 'istockphoto-1354012432-612x612.jpg', 'image/jpeg', 'public', 'public', 24980, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:04:54', '2025-10-26 02:04:54'),
(47, 'App\\Models\\Exercise', 7, 'f5d7460c-15dd-4b6f-96e9-c87bbcc53cb1', 'exercise_image', '08b77f1986408c2da2bf4163116963cf', '08b77f1986408c2da2bf4163116963cf.jpg', 'image/jpeg', 'public', 'public', 39204, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:06:10', '2025-10-26 02:06:10'),
(48, 'App\\Models\\Exercise', 3, '0e58fb57-bec7-4740-a6ea-a6f3acca0510', 'exercise_image', 'images (7)', 'images-(7).jpeg', 'image/jpeg', 'public', 'public', 7336, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:06:54', '2025-10-26 02:06:54'),
(49, 'App\\Models\\Exercise', 4, 'dfca732d-8983-435c-acb5-d5706ee4f482', 'exercise_image', 'images (8)', 'images-(8).jpeg', 'image/jpeg', 'public', 'public', 10486, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:08:08', '2025-10-26 02:08:08'),
(50, 'App\\Models\\Exercise', 5, 'afdd8aac-5e95-4e8b-91d6-a61cce826b40', 'exercise_image', 'e01d20991829287dc43b50ce2240441c', 'e01d20991829287dc43b50ce2240441c.jpg', 'image/jpeg', 'public', 'public', 33829, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:08:51', '2025-10-26 02:08:51'),
(51, 'App\\Models\\Exercise', 6, '2f218429-cbc8-4fe1-8bf5-67468e8a4842', 'exercise_image', 'images (9)', 'images-(9).jpeg', 'image/jpeg', 'public', 'public', 7915, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:10:08', '2025-10-26 02:10:08'),
(52, 'App\\Models\\Exercise', 2, '0335f2fa-604f-4908-9ec8-5e989c947171', 'exercise_image', 'png-clipart-push-up-bench-exercise-dip-burpee-incline-angle-hand', 'png-clipart-push-up-bench-exercise-dip-burpee-incline-angle-hand.png', 'image/png', 'public', 'public', 14137, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:11:25', '2025-10-26 02:11:25'),
(53, 'App\\Models\\Workout', 1, '90dca8a5-3318-4c2b-a7b3-9a874427acc3', 'workout_image', '6ad13254cca0de77c0e1c27313364a90dd7d0ef1', '6ad13254cca0de77c0e1c27313364a90dd7d0ef1.jpg', 'image/jpeg', 'public', 'public', 53184, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:12:41', '2025-10-26 02:12:41'),
(54, 'App\\Models\\WorkoutType', 2, 'ccd808b9-f2e8-4bcb-9317-ba4fcb03baee', 'workouttype_image', '6ad13254cca0de77c0e1c27313364a90dd7d0ef1', '6ad13254cca0de77c0e1c27313364a90dd7d0ef1.jpg', 'image/jpeg', 'public', 'public', 53184, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:13:07', '2025-10-26 02:13:07'),
(55, 'App\\Models\\WorkoutType', 1, 'cbe90a09-631e-440d-9530-96a3ec7e422c', 'workouttype_image', 'a18b9aa4cfc0260a73ed9dcdae7f2b8e74fdf1d2', 'a18b9aa4cfc0260a73ed9dcdae7f2b8e74fdf1d2.jpg', 'image/jpeg', 'public', 'public', 38089, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:13:58', '2025-10-26 02:13:58'),
(56, 'App\\Models\\Diet', 1, 'aa086d19-b4f1-4949-b270-9fbe49a78a9d', 'diet_image', 'istockphoto-169986941-612x612', 'istockphoto-169986941-612x612.jpg', 'image/jpeg', 'public', 'public', 61422, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:15:23', '2025-10-26 02:15:23'),
(57, 'App\\Models\\Diet', 11, 'b16b41b4-e7e4-4397-aecf-0c78b1b26d8a', 'diet_image', 'images (10)', 'images-(10).jpeg', 'image/jpeg', 'public', 'public', 15450, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:18:31', '2025-10-26 02:18:31'),
(58, 'App\\Models\\Diet', 10, '0c3f50fd-2cd7-404c-af3d-c2ea34b8f538', 'diet_image', 'Spinach.-Mushroom-Havarti-Egg-White-Omelette-2-500x500', 'Spinach.-Mushroom-Havarti-Egg-White-Omelette-2-500x500.jpg', 'image/jpeg', 'public', 'public', 29434, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:20:31', '2025-10-26 02:20:31'),
(59, 'App\\Models\\Diet', 9, '04fb19a1-91a7-4993-9a05-32c32536449c', 'diet_image', 'grilled-salmon-with-mashed-potatoes-and-broccoli-photo', 'grilled-salmon-with-mashed-potatoes-and-broccoli-photo.jpg', 'image/jpeg', 'public', 'public', 418821, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:21:39', '2025-10-26 02:21:39'),
(60, 'App\\Models\\Diet', 8, '93001b9e-2c93-4eee-99bc-d1668953a81e', 'diet_image', 'images (11)', 'images-(11).jpeg', 'image/jpeg', 'public', 'public', 11135, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:22:41', '2025-10-26 02:22:41'),
(61, 'App\\Models\\Diet', 7, '797e7328-da6b-422c-acc9-1f977e60c99c', 'diet_image', 'images (12)', 'images-(12).jpeg', 'image/jpeg', 'public', 'public', 13828, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:23:46', '2025-10-26 02:23:46'),
(62, 'App\\Models\\Diet', 6, '469d9c15-840b-430d-9a4d-ac89ff4ceeb3', 'diet_image', 'protein_shake_21728_16x9', 'protein_shake_21728_16x9.jpg', 'image/jpeg', 'public', 'public', 149851, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:24:52', '2025-10-26 02:24:52'),
(63, 'App\\Models\\Diet', 5, 'c2ff92d9-8231-4481-b968-9fb53e603bd2', 'diet_image', 'istockphoto-1372166601-612x612', 'istockphoto-1372166601-612x612.jpg', 'image/jpeg', 'public', 'public', 61082, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:26:27', '2025-10-26 02:26:27'),
(64, 'App\\Models\\Diet', 4, '8d579853-3c12-4fcf-bbfa-0655d1e061de', 'diet_image', 'istockphoto-1397869054-612x612', 'istockphoto-1397869054-612x612.jpg', 'image/jpeg', 'public', 'public', 44415, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:27:21', '2025-10-26 02:27:21'),
(65, 'App\\Models\\Diet', 3, '43154d9e-162b-4844-a8b6-3b56a4fe9d0a', 'diet_image', 'poached-egg-and-avocado-toast-horizontal', 'poached-egg-and-avocado-toast-horizontal.jpg', 'image/jpeg', 'public', 'public', 73019, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:29:55', '2025-10-26 02:29:55'),
(66, 'App\\Models\\Diet', 2, '0c2c1e24-f3df-4af0-b143-8fadfb4be477', 'diet_image', 'oatmeal-porridge-with-raspberries-blueberries-almonds-bowl-wooden-table_123827-32361', 'oatmeal-porridge-with-raspberries-blueberries-almonds-bowl-wooden-table_123827-32361.jpg', 'image/avif', 'public', 'public', 30745, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:31:12', '2025-10-26 02:31:12'),
(68, 'App\\Models\\CategoryDiet', 10, '6e59b40e-f07a-4625-b05a-4b9cc6754dc0', 'categorydiet_image', 'istockphoto-613046884-612x612', 'istockphoto-613046884-612x612.jpg', 'image/jpeg', 'public', 'public', 80299, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:32:12', '2025-10-26 02:32:12'),
(69, 'App\\Models\\CategoryDiet', 9, '482bbf4a-faba-4178-9fc3-f4750bfe8d76', 'categorydiet_image', '360_F_1576374476_s48oiaXmDQGb47EazcXJJWmpPqYmEhIj', '360_F_1576374476_s48oiaXmDQGb47EazcXJJWmpPqYmEhIj.jpg', 'image/jpeg', 'public', 'public', 108570, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:33:57', '2025-10-26 02:33:57'),
(70, 'App\\Models\\CategoryDiet', 8, 'a72a9769-0e96-4d2e-aa6f-27aa713f6559', 'categorydiet_image', 'istockphoto-1457433817-612x612', 'istockphoto-1457433817-612x612.jpg', 'image/jpeg', 'public', 'public', 95204, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:34:35', '2025-10-26 02:34:35'),
(71, 'App\\Models\\CategoryDiet', 7, '6b9ca2b8-5121-450d-ac52-63cb633e00bc', 'categorydiet_image', 'premium_photo-1673108852141-e8c3c22a4a22', 'premium_photo-1673108852141-e8c3c22a4a22.jpeg', 'image/jpeg', 'public', 'public', 1122599, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:35:14', '2025-10-26 02:35:14'),
(72, 'App\\Models\\CategoryDiet', 6, 'e9cb1734-580f-43d3-befe-930189a97cf5', 'categorydiet_image', 'istockphoto-938158500-612x612', 'istockphoto-938158500-612x612.jpg', 'image/jpeg', 'public', 'public', 66772, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:35:28', '2025-10-26 02:35:28'),
(73, 'App\\Models\\CategoryDiet', 5, 'b2d9b671-fff9-4ce7-a691-0ac7e2fe5f57', 'categorydiet_image', 'istockphoto-168340083-612x612', 'istockphoto-168340083-612x612.jpg', 'image/jpeg', 'public', 'public', 30773, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:36:03', '2025-10-26 02:36:03'),
(74, 'App\\Models\\CategoryDiet', 4, '03bd68f7-cdcc-4beb-847e-0b4df66f29b6', 'categorydiet_image', 'images (13)', 'images-(13).jpeg', 'image/jpeg', 'public', 'public', 13296, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:37:00', '2025-10-26 02:37:00'),
(75, 'App\\Models\\CategoryDiet', 3, 'b74941e4-3d89-4f22-829b-48c986049f0e', 'categorydiet_image', 'istockphoto-1284690585-612x612', 'istockphoto-1284690585-612x612.jpg', 'image/jpeg', 'public', 'public', 86689, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:38:04', '2025-10-26 02:38:04'),
(76, 'App\\Models\\CategoryDiet', 2, 'cd4fed33-0495-4706-9e63-c1bcc934d3bd', 'categorydiet_image', 'images (14)', 'images-(14).jpeg', 'image/jpeg', 'public', 'public', 11126, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:38:36', '2025-10-26 02:38:36'),
(77, 'App\\Models\\CategoryDiet', 1, '02296abc-c730-4b6b-9062-9fbf8a6de92e', 'categorydiet_image', 'istockphoto-637229718-612x612', 'istockphoto-637229718-612x612.jpg', 'image/jpeg', 'public', 'public', 59001, '[]', '[]', '[]', '[]', 1, '2025-10-26 02:39:04', '2025-10-26 02:39:04'),
(83, 'App\\Models\\BodyPart', 10, '83723ef7-3854-46be-bef9-13ade8bdafbe', 'bodypart_image', 'tricep', 'tricep.jpg', 'image/jpeg', 'public', 'public', 411926, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:44:41', '2025-11-29 23:44:41'),
(84, 'App\\Models\\BodyPart', 9, '6abccd53-6e01-4781-b4ba-ce16e539dc7c', 'bodypart_image', 'bicep', 'bicep.jpg', 'image/jpeg', 'public', 'public', 338025, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:45:04', '2025-11-29 23:45:04'),
(85, 'App\\Models\\BodyPart', 8, '19fa63ac-c945-40f9-840f-6781789b3360', 'bodypart_image', 'shoulder', 'shoulder.jpg', 'image/jpeg', 'public', 'public', 365442, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:45:19', '2025-11-29 23:45:19'),
(86, 'App\\Models\\BodyPart', 7, '85bdde89-8fe6-4580-9456-ace982e85934', 'bodypart_image', 'fullbody', 'fullbody.jpg', 'image/jpeg', 'public', 'public', 236385, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:45:28', '2025-11-29 23:45:28'),
(87, 'App\\Models\\BodyPart', 6, '68212975-0d47-40eb-920d-571252dfa27e', 'bodypart_image', 'abs', 'abs.png', 'image/png', 'public', 'public', 1187835, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:45:37', '2025-11-29 23:45:37'),
(88, 'App\\Models\\BodyPart', 5, 'c4227ad8-b033-4fa6-896f-e14fe8f314ca', 'bodypart_image', 'neck', 'neck.jpg', 'image/jpeg', 'public', 'public', 293393, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:45:46', '2025-11-29 23:45:46'),
(89, 'App\\Models\\BodyPart', 4, 'ec5d3a43-6e2e-40fb-8bd1-3da92d2f73f1', 'bodypart_image', 'arm', 'arm.jpg', 'image/jpeg', 'public', 'public', 264850, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:45:57', '2025-11-29 23:45:57'),
(90, 'App\\Models\\BodyPart', 3, '4851aea4-d450-45b3-a4c5-5d15d820d645', 'bodypart_image', 'back', 'back.jpg', 'image/jpeg', 'public', 'public', 394853, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:46:07', '2025-11-29 23:46:07'),
(91, 'App\\Models\\BodyPart', 2, '3c79f424-ca3a-4651-93e6-211f572176ae', 'bodypart_image', 'chest', 'chest.jpg', 'image/jpeg', 'public', 'public', 383816, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:46:18', '2025-11-29 23:46:18'),
(92, 'App\\Models\\BodyPart', 1, '865f9668-ac89-4605-9048-3c8a341dddb2', 'bodypart_image', 'leg', 'leg.jpg', 'image/jpeg', 'public', 'public', 524316, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:46:29', '2025-11-29 23:46:29'),
(93, 'App\\Models\\Level', 3, '2b108e3d-7211-438d-9d20-c6e843eb3d19', 'level_image', 'advanced', 'advanced.jpg', 'image/jpeg', 'public', 'public', 512798, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:55:48', '2025-11-29 23:55:48'),
(94, 'App\\Models\\Level', 2, '19ad92b5-fdb3-4286-b1cc-23e0f744f3d7', 'level_image', 'intermediate', 'intermediate.jpg', 'image/jpeg', 'public', 'public', 525764, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:56:06', '2025-11-29 23:56:06'),
(95, 'App\\Models\\Level', 1, 'f199d133-030c-4e04-8894-825faccc4a5c', 'level_image', 'beginner', 'beginner.jpg', 'image/jpeg', 'public', 'public', 536414, '[]', '[]', '[]', '[]', 1, '2025-11-29 23:56:18', '2025-11-29 23:56:18'),
(96, 'App\\Models\\Equipment', 20, 'e1296c14-9e0c-4fa7-a471-1198e75cc1f7', 'equipment_image', 'weightplate', 'weightplate.jpg', 'image/jpeg', 'public', 'public', 448876, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:31:14', '2025-11-30 00:31:14'),
(97, 'App\\Models\\Equipment', 16, '6a523111-0684-42b4-9450-e0861c3e2360', 'equipment_image', 'kettlebell', 'kettlebell.jpg', 'image/jpeg', 'public', 'public', 758247, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:32:21', '2025-11-30 00:32:21'),
(98, 'App\\Models\\Equipment', 15, 'db33d24c-da6a-476d-a5f5-26b743523786', 'equipment_image', 'jumprope', 'jumprope.jpg', 'image/jpeg', 'public', 'public', 724514, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:32:48', '2025-11-30 00:32:48'),
(99, 'App\\Models\\Equipment', 13, '43163e71-50be-4427-aef8-2377c3cad1bd', 'equipment_image', 'ball', 'ball.jpg', 'image/jpeg', 'public', 'public', 572628, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:33:15', '2025-11-30 00:33:15'),
(100, 'App\\Models\\Equipment', 11, '47784094-2da1-4099-bf46-50eb5c42dd4c', 'equipment_image', 'pullup', 'pullup.jpg', 'image/jpeg', 'public', 'public', 435973, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:35:08', '2025-11-30 00:35:08'),
(101, 'App\\Models\\Equipment', 10, '0d87d285-6226-4a83-955d-179326d454e0', 'equipment_image', 'dumbell', 'dumbell.jpg', 'image/jpeg', 'public', 'public', 485083, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:35:30', '2025-11-30 00:35:30'),
(102, 'App\\Models\\Equipment', 9, '28a8d70d-0f9d-4bdb-a394-c078f309e20a', 'equipment_image', 'rope', 'rope.jpg', 'image/jpeg', 'public', 'public', 565246, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:35:40', '2025-11-30 00:35:40'),
(103, 'App\\Models\\Equipment', 8, '95c87a11-401a-41e2-9164-534ac9591edb', 'equipment_image', 'foam', 'foam.jpg', 'image/jpeg', 'public', 'public', 472042, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:35:49', '2025-11-30 00:35:49'),
(104, 'App\\Models\\Equipment', 7, '4472eb0c-60fa-481b-8e12-99e0a9f6e743', 'equipment_image', 'bike', 'bike.jpg', 'image/jpeg', 'public', 'public', 124444, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:36:03', '2025-11-30 00:36:03'),
(105, 'App\\Models\\Equipment', 6, 'b545deb7-0e6f-445a-8bf0-73e98fe7e76b', 'equipment_image', 'treadmill', 'treadmill.jpg', 'image/jpeg', 'public', 'public', 594882, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:36:19', '2025-11-30 00:36:19'),
(106, 'App\\Models\\Equipment', 5, '99915888-f7d3-4c25-8ed2-173a6047db9c', 'equipment_image', 'yoga', 'yoga.jpg', 'image/jpeg', 'public', 'public', 416462, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:37:12', '2025-11-30 00:37:12'),
(107, 'App\\Models\\Equipment', 4, '7e1a49c0-58e4-49c3-8899-542bcd110c89', 'equipment_image', 'benchmachine', 'benchmachine.jpg', 'image/jpeg', 'public', 'public', 419023, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:37:33', '2025-11-30 00:37:33'),
(108, 'App\\Models\\Equipment', 1, '7416913b-2fe5-4cf3-8b67-f67abb1a442b', 'equipment_image', 'band', 'band.jpg', 'image/jpeg', 'public', 'public', 411700, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:37:46', '2025-11-30 00:37:46'),
(109, 'App\\Models\\Equipment', 18, 'd3dc586d-fc74-4b27-beb4-583279caa57f', 'equipment_image', '2149267001', '2149267001.jpg', 'image/jpeg', 'public', 'public', 549568, '[]', '[]', '[]', '[]', 1, '2025-11-30 00:39:15', '2025-11-30 00:39:15');

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `push_notifications`
--

CREATE TABLE `push_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `title`, `guard_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin', 'web', 1, '2026-01-13 08:03:14', '2026-01-13 08:03:14'),
(2, 'user', 'User', 'web', 1, '2026-01-13 08:03:14', '2026-01-13 08:03:14');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `user_type` varchar(255) NOT NULL DEFAULT 'user',
  `password` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `login_type` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `player_id` varchar(255) DEFAULT NULL,
  `is_subscribe` tinyint(4) DEFAULT 0,
  `timezone` varchar(255) DEFAULT 'UTC',
  `last_notification_seen` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `first_name`, `last_name`, `email`, `phone_number`, `email_verified_at`, `user_type`, `password`, `status`, `login_type`, `gender`, `display_name`, `player_id`, `is_subscribe`, `timezone`, `last_notification_seen`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'systemadmin', 'System', 'Admin', 'admin@admin.com', NULL, '2026-01-13 08:03:14', 'admin', '$2y$10$ZhCPGIzzv8TVwtnhouvdyOY2I3rUtAcxfSSAOq2mvRkmUngs1pQXi', 'active', NULL, NULL, 'System Admin', NULL, 0, 'UTC', NULL, NULL, '2026-01-13 08:03:14', '2026-01-13 08:03:14');

-- --------------------------------------------------------

--
-- Table structure for table `user_exercises`
--

CREATE TABLE `user_exercises` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `exercise_id` bigint(20) UNSIGNED DEFAULT NULL,
  `workout_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_favourite_diets`
--

CREATE TABLE `user_favourite_diets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `diet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_favourite_workouts`
--

CREATE TABLE `user_favourite_workouts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `workout_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_graphs`
--

CREATE TABLE `user_graphs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `age` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `weight_unit` varchar(255) DEFAULT NULL,
  `height` varchar(255) DEFAULT NULL,
  `height_unit` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workouts`
--

CREATE TABLE `workouts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `level_id` bigint(20) UNSIGNED DEFAULT NULL,
  `workout_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `is_premium` tinyint(1) DEFAULT 0 COMMENT '0-free, 1-premium',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workouts`
--

INSERT INTO `workouts` (`id`, `title`, `slug`, `description`, `level_id`, `workout_type_id`, `status`, `is_premium`, `created_at`, `updated_at`) VALUES
(1, 'Hand workout', 'hand-workout', NULL, 1, 2, 'active', 0, '2025-10-21 21:19:04', '2025-10-21 21:19:04');

-- --------------------------------------------------------

--
-- Table structure for table `workout_days`
--

CREATE TABLE `workout_days` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `workout_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sequence` bigint(20) DEFAULT NULL,
  `is_rest` tinyint(1) DEFAULT 0 COMMENT '0-no,1-yes',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workout_days`
--

INSERT INTO `workout_days` (`id`, `workout_id`, `sequence`, `is_rest`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 0, '2025-10-21 21:19:04', '2025-10-26 02:12:41');

-- --------------------------------------------------------

--
-- Table structure for table `workout_day_exercises`
--

CREATE TABLE `workout_day_exercises` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `workout_id` bigint(20) UNSIGNED DEFAULT NULL,
  `workout_day_id` bigint(20) UNSIGNED DEFAULT NULL,
  `exercise_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sets` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`sets`)),
  `sequence` bigint(20) UNSIGNED DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workout_types`
--

CREATE TABLE `workout_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workout_types`
--

INSERT INTO `workout_types` (`id`, `title`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Leg', 'leg', 'active', '2025-10-21 21:17:43', '2025-10-21 21:17:43'),
(2, 'Hand', 'hand', 'active', '2025-10-21 21:17:52', '2025-10-21 21:17:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assign_diets`
--
ALTER TABLE `assign_diets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assign_workouts`
--
ALTER TABLE `assign_workouts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `body_parts`
--
ALTER TABLE `body_parts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_diets`
--
ALTER TABLE `category_diets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `class_schedules`
--
ALTER TABLE `class_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `class_schedule_plans`
--
ALTER TABLE `class_schedule_plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_schedule_plans_user_id_foreign` (`user_id`);

--
-- Indexes for table `diets`
--
ALTER TABLE `diets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `diets_categorydiet_id_foreign` (`categorydiet_id`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exercises`
--
ALTER TABLE `exercises`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `push_notifications`
--
ALTER TABLE `push_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_exercises`
--
ALTER TABLE `user_exercises`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_exercises_user_id_foreign` (`user_id`),
  ADD KEY `user_exercises_exercise_id_foreign` (`exercise_id`),
  ADD KEY `user_exercises_workout_id_foreign` (`workout_id`);

--
-- Indexes for table `user_favourite_diets`
--
ALTER TABLE `user_favourite_diets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_favourite_diets_user_id_foreign` (`user_id`),
  ADD KEY `user_favourite_diets_diet_id_foreign` (`diet_id`);

--
-- Indexes for table `user_favourite_workouts`
--
ALTER TABLE `user_favourite_workouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_favourite_workouts_user_id_foreign` (`user_id`),
  ADD KEY `user_favourite_workouts_workout_id_foreign` (`workout_id`);

--
-- Indexes for table `user_graphs`
--
ALTER TABLE `user_graphs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workouts`
--
ALTER TABLE `workouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workouts_level_id_foreign` (`level_id`),
  ADD KEY `workouts_workout_type_id_foreign` (`workout_type_id`);

--
-- Indexes for table `workout_days`
--
ALTER TABLE `workout_days`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workout_days_workout_id_foreign` (`workout_id`);

--
-- Indexes for table `workout_day_exercises`
--
ALTER TABLE `workout_day_exercises`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workout_day_exercises_workout_id_foreign` (`workout_id`),
  ADD KEY `workout_day_exercises_workout_day_id_foreign` (`workout_day_id`);

--
-- Indexes for table `workout_types`
--
ALTER TABLE `workout_types`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assign_diets`
--
ALTER TABLE `assign_diets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assign_workouts`
--
ALTER TABLE `assign_workouts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `body_parts`
--
ALTER TABLE `body_parts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_diets`
--
ALTER TABLE `category_diets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `class_schedules`
--
ALTER TABLE `class_schedules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `class_schedule_plans`
--
ALTER TABLE `class_schedule_plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `diets`
--
ALTER TABLE `diets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `exercises`
--
ALTER TABLE `exercises`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `levels`
--
ALTER TABLE `levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `push_notifications`
--
ALTER TABLE `push_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_exercises`
--
ALTER TABLE `user_exercises`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_favourite_diets`
--
ALTER TABLE `user_favourite_diets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_favourite_workouts`
--
ALTER TABLE `user_favourite_workouts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_graphs`
--
ALTER TABLE `user_graphs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workouts`
--
ALTER TABLE `workouts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `workout_days`
--
ALTER TABLE `workout_days`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `workout_day_exercises`
--
ALTER TABLE `workout_day_exercises`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workout_types`
--
ALTER TABLE `workout_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class_schedule_plans`
--
ALTER TABLE `class_schedule_plans`
  ADD CONSTRAINT `class_schedule_plans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `diets`
--
ALTER TABLE `diets`
  ADD CONSTRAINT `diets_categorydiet_id_foreign` FOREIGN KEY (`categorydiet_id`) REFERENCES `category_diets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_exercises`
--
ALTER TABLE `user_exercises`
  ADD CONSTRAINT `user_exercises_exercise_id_foreign` FOREIGN KEY (`exercise_id`) REFERENCES `exercises` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_exercises_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_exercises_workout_id_foreign` FOREIGN KEY (`workout_id`) REFERENCES `workouts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_favourite_diets`
--
ALTER TABLE `user_favourite_diets`
  ADD CONSTRAINT `user_favourite_diets_diet_id_foreign` FOREIGN KEY (`diet_id`) REFERENCES `diets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_favourite_diets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_favourite_workouts`
--
ALTER TABLE `user_favourite_workouts`
  ADD CONSTRAINT `user_favourite_workouts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_favourite_workouts_workout_id_foreign` FOREIGN KEY (`workout_id`) REFERENCES `workouts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `workouts`
--
ALTER TABLE `workouts`
  ADD CONSTRAINT `workouts_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `workouts_workout_type_id_foreign` FOREIGN KEY (`workout_type_id`) REFERENCES `workout_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `workout_days`
--
ALTER TABLE `workout_days`
  ADD CONSTRAINT `workout_days_workout_id_foreign` FOREIGN KEY (`workout_id`) REFERENCES `workouts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `workout_day_exercises`
--
ALTER TABLE `workout_day_exercises`
  ADD CONSTRAINT `workout_day_exercises_workout_day_id_foreign` FOREIGN KEY (`workout_day_id`) REFERENCES `workout_days` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `workout_day_exercises_workout_id_foreign` FOREIGN KEY (`workout_id`) REFERENCES `workouts` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
