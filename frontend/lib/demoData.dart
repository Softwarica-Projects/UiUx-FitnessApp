import 'dart:async';
import 'models/category_diet_response.dart';
import 'package:habit_tracker/models/ScheduledResponse.dart';
import 'package:habit_tracker/models/body_part_response.dart';
import 'package:habit_tracker/models/dashboard_response.dart';
import 'package:habit_tracker/models/day_exercise_response.dart';
import 'package:habit_tracker/models/diet_response.dart';
import 'package:habit_tracker/models/equipment_response.dart';
import 'package:habit_tracker/models/exercise_response.dart' as er;
import 'package:habit_tracker/models/level_response.dart';
import 'package:habit_tracker/models/workout_detail_response.dart';
import 'package:habit_tracker/models/login_response.dart';
import 'package:habit_tracker/models/graph_response.dart';
import 'package:habit_tracker/models/notification_response.dart';

/// Simulates a paginated response with demo data.
Future<Map<String, dynamic>> fakePagination({required List<dynamic> data, int page = 1, int perPage = 10}) async {
  await demoDelay();
  int start = (page - 1) * perPage;
  int end = start + perPage;
  return {
    'data': data.sublist(start, end > data.length ? data.length : end),
    'pagination': {
      'page': page,
      'perPage': perPage,
      'total': data.length,
      'totalPages': (data.length / perPage).ceil(),
    },
  };
}

DashboardResponse get demoDashboard => DashboardResponse(
      bodypart: demoBodyParts,
      equipment: demoEquipment.take(2).toList(),
      exercise: demoExercises.take(3).toList(),
      workout: demoWorkouts.take(3).toList(),
      diet: demoDiets.take(3).map((x) => Diet.fromJson(x.toJson())).toList(),
      featuredDiet: demoDiets.where((d) => d.isFeatured == 'true').map((x) => Diet.fromJson(x.toJson())).toList(),
      level: demoLevels.take(3).toList(),
      workouttype: [],
    );

Future<void> demoDelay() async {
  await Future.delayed(const Duration(seconds: 2));
}

final demoUser = LoginResponse(
    data: UserModel(
  id: 1,
  username: 'RishanSht',
  firstName: 'Rishan',
  lastName: 'Sht',
  email: 'rishan.sht@demo.com',
  phoneNumber: '+9779812345678',
  emailVerifiedAt: '2024-10-12T10:30:00Z',
  userType: 'customer',
  status: 'active',
  loginType: 'email',
  gender: 'male',
  displayName: 'Rishan Sht',
  playerId: 'r123',
  createdAt: '2024-01-01T08:00:00Z',
  updatedAt: '2024-12-01T18:45:00Z',
  apiToken: 'fake_api_token_123456789',
  profileImage: 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
  uid: 'uid_987654321',
  caseSearch: [],
  isPresence: true,
));

final demoWorkouts = [
  WorkoutDetailModel(
    id: 1,
    title: 'Workout 1',
    status: 'active',
    levelId: 1,
    levelTitle: 'Beginner',
    levelRate: 1,
    workoutImage: 'https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg',
    workoutTypeId: 1,
    workoutTypeTitle: 'Full Body',
    createdAt: '2025-12-01T08:00:00Z',
    updatedAt: '2025-12-10T08:00:00Z',
    isFavourite: 1,
    isFavouriteLocally: 0,
    description: 'A beginner workout to get started.',
  ),
  WorkoutDetailModel(
    id: 2,
    title: 'Workout 2',
    status: 'active',
    levelId: 2,
    levelTitle: 'Intermediate',
    levelRate: 2,
    workoutImage: 'https://images.pexels.com/photos/1552106/pexels-photo-1552106.jpeg',
    workoutTypeId: 2,
    workoutTypeTitle: 'Upper Body',
    createdAt: '2025-12-02T08:00:00Z',
    updatedAt: '2025-12-11T08:00:00Z',
    isFavourite: 0,
    isFavouriteLocally: 0,
    description: 'An intermediate workout for progression.',
  ),
  WorkoutDetailModel(
    id: 3,
    title: 'Workout 3',
    status: 'active',
    levelId: 3,
    levelTitle: 'Advanced',
    levelRate: 3,
    workoutImage: 'https://images.pexels.com/photos/414029/pexels-photo-414029.jpeg',
    workoutTypeId: 3,
    workoutTypeTitle: 'Lower Body',
    createdAt: '2025-12-03T08:00:00Z',
    updatedAt: '2025-12-12T08:00:00Z',
    isFavourite: 1,
    isFavouriteLocally: 0,
    description: 'An advanced workout for experts.',
  ),
];

// Demo data for demoDiets
final demoDiets = [
  DietModel(
    id: 1,
    title: 'Diet Plan 1',
    calories: '1500',
    carbs: '200',
    protein: '50',
    fat: '30',
    servings: '2',
    totalTime: '30 min',
    isFeatured: 'true',
    status: 'active',
    ingredients: 'Chicken, Rice, Broccoli',
    description: 'A healthy diet plan for beginners.',
    dietImage: 'https://images.pexels.com/photos/593836/pexels-photo-593836.jpeg',
    categorydietId: 1,
    categorydietTitle: 'Beginner Diets',
    createdAt: '2025-12-01',
    updatedAt: '2025-12-10',
    isFavourite: 1,
  ),
  DietModel(
    id: 2,
    title: 'Diet Plan 2',
    calories: '1600',
    carbs: '210',
    protein: '55',
    fat: '32',
    servings: '3',
    totalTime: '40 min',
    isFeatured: 'false',
    status: 'active',
    ingredients: 'Fish, Quinoa, Spinach',
    description: 'An intermediate diet plan for fitness enthusiasts.',
    dietImage: 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
    categorydietId: 2,
    categorydietTitle: 'Intermediate Diets',
    createdAt: '2025-12-02',
    updatedAt: '2025-12-11',
    isFavourite: 0,
  ),
  DietModel(
    id: 3,
    title: 'Diet Plan 3',
    calories: '1700',
    carbs: '220',
    protein: '60',
    fat: '35',
    servings: '4',
    totalTime: '50 min',
    isFeatured: 'true',
    status: 'active',
    ingredients: 'Beef, Sweet Potato, Kale',
    description: 'An advanced diet plan for professionals.',
    dietImage: 'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg',
    categorydietId: 3,
    categorydietTitle: 'Advanced Diets',
    createdAt: '2025-12-03',
    updatedAt: '2025-12-12',
    isFavourite: 1,
  ),
];

// Demo data for demoDietCategories (for CategoryDietResponse)
final demoDietCategories = [
  CategoryDietModel(
    id: 1,
    title: 'Beginner Diets',
    status: 'active',
    categorydietImage: 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
    createdAt: '2025-12-01',
    updatedAt: '2025-12-10',
  ),
  CategoryDietModel(
    id: 2,
    title: 'Intermediate Diets',
    status: 'active',
    categorydietImage: 'https://images.pexels.com/photos/593836/pexels-photo-593836.jpeg',
    createdAt: '2025-12-02',
    updatedAt: '2025-12-11',
  ),
  CategoryDietModel(
    id: 3,
    title: 'Advanced Diets',
    status: 'active',
    categorydietImage: 'https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg',
    createdAt: '2025-12-03',
    updatedAt: '2025-12-12',
  ),
];

// Demo data for demoBodyParts
final demoBodyParts = [
  BodyPartModel(
    id: 1,
    title: 'Body Part 1',
    bodypartImage: 'https://images.unsplash.com/photo-1556740749-887f6717d7e4?auto=format&fit=crop&w=400&q=80',
    description: 'Description for Body Part 1',
  ),
  BodyPartModel(
    id: 2,
    title: 'Body Part 2',
    bodypartImage: 'https://images.unsplash.com/photo-1556740749-887f6717d7e4?auto=format&fit=crop&w=400&q=80',
    description: 'Description for Body Part 2',
  ),
  BodyPartModel(
    id: 3,
    title: 'Body Part 3',
    bodypartImage: 'https://images.unsplash.com/photo-1556740749-887f6717d7e4?auto=format&fit=crop&w=400&q=80',
    description: 'Description for Body Part 3',
  ),
];

// Demo data for demoEquipment
final demoEquipment = [
  EquipmentModel(
    id: 1,
    title: 'Equipment 1',
    status: 'active',
    description: 'Description for Equipment 1',
    equipmentImage: 'https://images.unsplash.com/photo-1514516870926-2b3f95a707b2?auto=format&fit=crop&w=400&q=80',
    createdAt: '2025-12-01T08:00:00Z',
    updatedAt: '2025-12-10T08:00:00Z',
  ),
  EquipmentModel(
    id: 2,
    title: 'Equipment 2',
    status: 'active',
    description: 'Description for Equipment 2',
    equipmentImage: 'https://images.unsplash.com/photo-1514516870926-2b3f95a707b2?auto=format&fit=crop&w=400&q=80',
    createdAt: '2025-12-01T08:00:00Z',
    updatedAt: '2025-12-10T08:00:00Z',
  ),
  EquipmentModel(
    id: 3,
    title: 'Equipment 3',
    status: 'active',
    description: 'Description for Equipment 3',
    equipmentImage: 'https://images.unsplash.com/photo-1514516870926-2b3f95a707b2?auto=format&fit=crop&w=400&q=80',
    createdAt: '2025-12-01T08:00:00Z',
    updatedAt: '2025-12-10T08:00:00Z',
  ),
];

// Updated demo data to use models instead of JSON objects
final demoExercises = [
  er.ExerciseModel(
    id: 1,
    title: 'Push Ups',
    status: 'active',
    exerciseImage: 'https://images.pexels.com/photos/2261477/pexels-photo-2261477.jpeg',
    videoType: 'youtube',
    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    bodypartName: [
      er.BodypartName(id: 1, title: 'Chest', bodypartImage: 'https://images.pexels.com/photos/3253501/pexels-photo-3253501.jpeg'),
    ],
    duration: '10 minutes',
    sets: [
      er.Sets(reps: '15', rest: '30s', time: '1m', weight: 'Bodyweight'),
    ],
    equipmentId: 1,
    equipmentTitle: 'None',
    levelId: 1,
    levelTitle: 'Beginner',
    instruction: 'Keep your back straight.',
    tips: 'Breathe out when pushing up.',
    createdAt: '2025-12-01',
    updatedAt: '2025-12-10',
    type: 'Strength',
    based: 'Bodyweight',
  ),
  er.ExerciseModel(
    id: 2,
    title: 'Squats',
    status: 'active',
    exerciseImage: 'https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg',
    videoType: 'youtube',
    videoUrl: 'https://www.youtube.com/watch?v=9bZkp7q19f0',
    bodypartName: [
      er.BodypartName(id: 2, title: 'Legs', bodypartImage: 'https://images.pexels.com/photos/1132091/pexels-photo-1132091.jpeg'),
    ],
    duration: '15 minutes',
    sets: [
      er.Sets(reps: '20', rest: '40s', time: '1m30s', weight: 'Bodyweight'),
    ],
    equipmentId: 1,
    equipmentTitle: 'None',
    levelId: 1,
    levelTitle: 'Beginner',
    instruction: 'Keep your knees behind your toes.',
    tips: 'Engage your core.',
    createdAt: '2025-12-01',
    updatedAt: '2025-12-10',
    type: 'Strength',
    based: 'Bodyweight',
  ),
];

// Demo data for GraphResponse
//use GraphModel
final demoProgress = [
  GraphModel(date: DateTime.now().subtract(Duration(days: 1)).toIso8601String(), value: '10'),
  GraphModel(date: DateTime.now().subtract(Duration(days: 2)).toIso8601String(), value: '20'),
  GraphModel(date: DateTime.now().subtract(Duration(days: 3)).toIso8601String(), value: '30'),
];

// Demo data for NotificationResponse
//use NotificationResponse
final demoNotificationDetails = NotificationResponse(
  notificationData: [
    NotificationData(
      id: '1',
      readAt: DateTime.now().toIso8601String(),
      createdAt: DateTime.now().toIso8601String(),
      data: NotificationModel(
        id: 1,
        pushNotificationId: 101,
        type: 'info',
        subject: 'Demo Notification',
        message: 'This is a detailed demo notification.',
        image: 'https://images.pexels.com/photos/3183197/pexels-photo-3183197.jpeg',
      ),
      image: 'https://images.pexels.com/photos/3184357/pexels-photo-3184357.jpeg',
    ),
  ],
  allUnreadCount: 1,
);

final List<NotificationData> notifications = [
  NotificationData(
    id: "1",
    readAt: null,
    createdAt: "2025-12-10T10:00:00Z",
    image: "https://images.pexels.com/photos/417173/pexels-photo-417173.jpeg",
    data: NotificationModel(
      id: 101,
      pushNotificationId: 1001,
      type: "welcome",
      subject: "Welcome!",
      message: "Thanks for joining our platform.",
      image: "https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg",
    ),
  ),
  NotificationData(
    id: "2",
    readAt: "2025-12-10T11:00:00Z",
    createdAt: "2025-12-10T09:30:00Z",
    image: "https://images.pexels.com/photos/593836/pexels-photo-593836.jpeg",
    data: NotificationModel(
      id: 102,
      pushNotificationId: 1002,
      type: "update",
      subject: "App Update",
      message: "A new version of the app is available.",
      image: "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
    ),
  ),
  NotificationData(
    id: "3",
    readAt: null,
    createdAt: "2025-12-09T18:45:00Z",
    image: null,
    data: NotificationModel(
      id: 103,
      pushNotificationId: 1003,
      type: "reminder",
      subject: "Profile Reminder",
      message: "Please complete your profile.",
      image: null,
    ),
  ),
  NotificationData(
    id: "4",
    readAt: "2025-12-09T20:10:00Z",
    createdAt: "2025-12-09T17:00:00Z",
    image: "https://images.pexels.com/photos/3183197/pexels-photo-3183197.jpeg",
    data: NotificationModel(
      id: 104,
      pushNotificationId: 1004,
      type: "security",
      subject: "Security Alert",
      message: "Your password was changed successfully.",
      image: "https://images.pexels.com/photos/3184357/pexels-photo-3184357.jpeg",
    ),
  ),
  NotificationData(
    id: "5",
    readAt: null,
    createdAt: "2025-12-08T14:25:00Z",
    image: null,
    data: NotificationModel(
      id: 105,
      pushNotificationId: 1005,
      type: "promotion",
      subject: "Special Offer",
      message: "Get 20% off on your next purchase.",
      image: null,
    ),
  ),
  NotificationData(
    id: "6",
    readAt: "2025-12-08T15:00:00Z",
    createdAt: "2025-12-08T13:40:00Z",
    image: "https://images.pexels.com/photos/417173/pexels-photo-417173.jpeg",
    data: NotificationModel(
      id: 106,
      pushNotificationId: 1006,
      type: "login",
      subject: "New Login Detected",
      message: "A new device just logged into your account.",
      image: "https://images.pexels.com/photos/461382/pexels-photo-461382.jpeg",
    ),
  ),
  NotificationData(
    id: "7",
    readAt: null,
    createdAt: "2025-12-07T19:10:00Z",
    image: "https://images.pexels.com/photos/593836/pexels-photo-593836.jpeg",
    data: NotificationModel(
      id: 107,
      pushNotificationId: 1007,
      type: "message",
      subject: "New Message",
      message: "You have received a new message.",
      image: "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
    ),
  ),
  NotificationData(
    id: "8",
    readAt: "2025-12-07T20:00:00Z",
    createdAt: "2025-12-07T18:50:00Z",
    image: null,
    data: NotificationModel(
      id: 108,
      pushNotificationId: 1008,
      type: "info",
      subject: "Maintenance Notice",
      message: "Scheduled maintenance tonight at 12 AM.",
      image: null,
    ),
  ),
  NotificationData(
    id: "9",
    readAt: null,
    createdAt: "2025-12-06T09:15:00Z",
    image: "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
    data: NotificationModel(
      id: 109,
      pushNotificationId: 1009,
      type: "survey",
      subject: "We Value Your Feedback",
      message: "Please complete our short survey.",
      image: "https://images.pexels.com/photos/593836/pexels-photo-593836.jpeg",
    ),
  ),
  NotificationData(
    id: "10",
    readAt: "2025-12-06T10:30:00Z",
    createdAt: "2025-12-06T08:45:00Z",
    data: NotificationModel(
      id: 110,
      pushNotificationId: 1010,
      type: "logout",
      subject: "Logged Out",
      message: "You have been logged out successfully.",
      image: null,
    ),
  ),
];
final List<LevelModel> demoLevels = [
  LevelModel(
    id: 1,
    title: "Beginner",
    rate: 10,
    status: "active",
    levelImage: "https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg",
    createdAt: "2025-12-01T08:00:00Z",
    updatedAt: "2025-12-01T08:10:00Z",
  ),
  LevelModel(
    id: 2,
    title: "Intermediate",
    rate: 20,
    status: "active",
    levelImage: "https://images.pexels.com/photos/1552106/pexels-photo-1552106.jpeg",
    createdAt: "2025-12-02T09:00:00Z",
    updatedAt: "2025-12-02T09:10:00Z",
  ),
  LevelModel(
    id: 3,
    title: "Advanced",
    rate: 30,
    status: "active",
    levelImage: "https://images.pexels.com/photos/414029/pexels-photo-414029.jpeg",
    createdAt: "2025-12-03T10:00:00Z",
    updatedAt: "2025-12-03T10:10:00Z",
  ),
];
final List<ScheduledModelData> demoScheduleList = [
  ScheduledModelData(
    id: 1,
    className: "Morning Yoga",
    workoutId: 101,
    workout: "Yoga",
    workoutTitle: "Sunrise Flow",
    workoutType: "Flexibility",
    startDate: "2025-12-18",
    endDate: "2025-12-18",
    startTime: "06:30",
    endTime: "07:30",
    name: "Instructor A",
    link: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    isClassSchedulePlan: 1,
    createdAt: "2025-12-10T08:00:00Z",
    updatedAt: "2025-12-10T08:10:00Z",
  ),
  ScheduledModelData(
    id: 2,
    className: "Evening Cardio",
    workoutId: 102,
    workout: "Cardio",
    workoutTitle: "HIIT Blast",
    workoutType: "Endurance",
    startDate: "2025-12-19",
    endDate: "2025-12-19",
    startTime: "18:00",
    endTime: "19:00",
    name: "Instructor B",
    link: "https://www.youtube.com/watch?v=9bZkp7q19f0",
    isClassSchedulePlan: 0,
    createdAt: "2025-12-11T09:00:00Z",
    updatedAt: "2025-12-11T09:10:00Z",
  ),
  ScheduledModelData(
    id: 3,
    className: "Afternoon Strength",
    workoutId: 103,
    workout: "Strength",
    workoutTitle: "Power Hour",
    workoutType: "Muscle",
    startDate: "2025-12-20",
    endDate: "2025-12-20",
    startTime: "15:00",
    endTime: "16:00",
    name: "Instructor C",
    link: "https://www.youtube.com/watch?v=3JZ_D3ELwOQ",
    isClassSchedulePlan: 1,
    createdAt: "2025-12-12T10:00:00Z",
    updatedAt: "2025-12-12T10:10:00Z",
  ),
  ScheduledModelData(
    id: 4,
    className: "Morning Meditation",
    workoutId: 104,
    workout: "Meditation",
    workoutTitle: "Mindfulness Start",
    workoutType: "Mental",
    startDate: "2025-12-21",
    endDate: "2025-12-21",
    startTime: "07:00",
    endTime: "07:30",
    name: "Instructor D",
    link: "https://www.youtube.com/watch?v=V-_O7nl0Ii0",
    isClassSchedulePlan: 0,
    createdAt: "2025-12-13T07:00:00Z",
    updatedAt: "2025-12-13T07:10:00Z",
  ),
];
final List<DayExerciseModel> demoDayExercises = [
  DayExerciseModel(
    id: 1,
    workoutId: 101,
    workoutDayId: 1,
    exerciseId: 201,
    exerciseImage: "https://images.pexels.com/photos/2261477/pexels-photo-2261477.jpeg",
    exerciseTitle: "Push Ups",
    sequence: 1,
    createdAt: "2025-12-10T08:00:00Z",
    updatedAt: "2025-12-10T08:10:00Z",
    exercise: Exercise(
      id: 201,
      title: "Push Ups",
      status: "active",
      exerciseImage: "https://images.pexels.com/photos/2261477/pexels-photo-2261477.jpeg",
      instruction: "Do 3 sets of 15 reps",
      levelId: 1,
      levelTitle: "Beginner",
      duration: "10 min",
      based: "bodyweight",
      type: "strength",
      createdAt: "2025-12-10T07:50:00Z",
      updatedAt: "2025-12-10T08:00:00Z",
      bodypartName: [
        BodypartName(
          id: 1,
          title: "Chest",
          bodypartImage: "https://images.pexels.com/photos/3253501/pexels-photo-3253501.jpeg",
        ),
        BodypartName(
          id: 2,
          title: "Triceps",
          bodypartImage: "https://images.pexels.com/photos/1132091/pexels-photo-1132091.jpeg",
        ),
      ],
      sets: [
        Sets(reps: "15", rest: "60s", time: null, weight: null),
        Sets(reps: "15", rest: "60s", time: null, weight: null),
        Sets(reps: "15", rest: "60s", time: null, weight: null),
      ],
    ),
  ),
  DayExerciseModel(
    id: 2,
    workoutId: 101,
    workoutDayId: 1,
    exerciseId: 202,
    exerciseImage: "https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg",
    exerciseTitle: "Squats",
    sequence: 2,
    createdAt: "2025-12-10T08:15:00Z",
    updatedAt: "2025-12-10T08:20:00Z",
    exercise: Exercise(
      id: 202,
      title: "Squats",
      status: "active",
      exerciseImage: "https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg",
      instruction: "Do 3 sets of 20 reps",
      levelId: 1,
      levelTitle: "Beginner",
      duration: "12 min",
      based: "bodyweight",
      type: "strength",
      createdAt: "2025-12-10T08:05:00Z",
      updatedAt: "2025-12-10T08:15:00Z",
      bodypartName: [
        BodypartName(
          id: 3,
          title: "Legs",
          bodypartImage: "https://images.pexels.com/photos/1132091/pexels-photo-1132091.jpeg",
        ),
      ],
      sets: [
        Sets(reps: "20", rest: "60s", time: null, weight: null),
        Sets(reps: "20", rest: "60s", time: null, weight: null),
        Sets(reps: "20", rest: "60s", time: null, weight: null),
      ],
    ),
  ),
  DayExerciseModel(
    id: 3,
    workoutId: 101,
    workoutDayId: 1,
    exerciseId: 203,
    exerciseImage: "https://images.pexels.com/photos/1552106/pexels-photo-1552106.jpeg",
    exerciseTitle: "Plank",
    sequence: 3,
    createdAt: "2025-12-10T08:30:00Z",
    updatedAt: "2025-12-10T08:35:00Z",
    exercise: Exercise(
      id: 203,
      title: "Plank",
      status: "active",
      exerciseImage: "https://images.pexels.com/photos/1552106/pexels-photo-1552106.jpeg",
      instruction: "Hold plank for 60s",
      levelId: 1,
      levelTitle: "Beginner",
      duration: "5 min",
      based: "bodyweight",
      type: "core",
      createdAt: "2025-12-10T08:25:00Z",
      updatedAt: "2025-12-10T08:30:00Z",
      bodypartName: [
        BodypartName(
          id: 4,
          title: "Core",
          bodypartImage: "https://images.pexels.com/photos/3253501/pexels-photo-3253501.jpeg",
        ),
      ],
      sets: [
        Sets(reps: null, rest: "30s", time: "60s", weight: null),
      ],
    ),
  ),
  DayExerciseModel(
    id: 4,
    workoutId: 101,
    workoutDayId: 1,
    exerciseId: 204,
    exerciseImage: "https://images.pexels.com/photos/414029/pexels-photo-414029.jpeg",
    exerciseTitle: "Lunges",
    sequence: 4,
    createdAt: "2025-12-10T08:45:00Z",
    updatedAt: "2025-12-10T08:50:00Z",
    exercise: Exercise(
      id: 204,
      title: "Lunges",
      status: "active",
      exerciseImage: "https://images.pexels.com/photos/414029/pexels-photo-414029.jpeg",
      instruction: "Do 3 sets of 12 reps each leg",
      levelId: 1,
      levelTitle: "Beginner",
      duration: "15 min",
      based: "bodyweight",
      type: "strength",
      createdAt: "2025-12-10T08:40:00Z",
      updatedAt: "2025-12-10T08:45:00Z",
      bodypartName: [
        BodypartName(
          id: 3,
          title: "Legs",
          bodypartImage: "https://images.pexels.com/photos/1132091/pexels-photo-1132091.jpeg",
        ),
        BodypartName(
          id: 5,
          title: "Glutes",
          bodypartImage: "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
        ),
      ],
      sets: [
        Sets(reps: "12", rest: "60s", time: null, weight: null),
        Sets(reps: "12", rest: "60s", time: null, weight: null),
        Sets(reps: "12", rest: "60s", time: null, weight: null),
      ],
    ),
  ),
  DayExerciseModel(
    id: 5,
    workoutId: 101,
    workoutDayId: 1,
    exerciseId: 205,
    exerciseImage: "https://images.pexels.com/photos/593836/pexels-photo-593836.jpeg",
    exerciseTitle: "Bicep Curls",
    sequence: 5,
    createdAt: "2025-12-10T09:00:00Z",
    updatedAt: "2025-12-10T09:05:00Z",
    exercise: Exercise(
      id: 205,
      title: "Bicep Curls",
      status: "active",
      exerciseImage: "https://images.pexels.com/photos/593836/pexels-photo-593836.jpeg",
      instruction: "Do 3 sets of 15 reps with dumbbells",
      levelId: 1,
      levelTitle: "Beginner",
      duration: "10 min",
      based: "weights",
      type: "strength",
      createdAt: "2025-12-10T08:55:00Z",
      updatedAt: "2025-12-10T09:00:00Z",
      bodypartName: [
        BodypartName(
          id: 6,
          title: "Biceps",
          bodypartImage: "https://images.pexels.com/photos/3253501/pexels-photo-3253501.jpeg",
        ),
      ],
      sets: [
        Sets(reps: "15", rest: "60s", time: null, weight: "5kg"),
        Sets(reps: "15", rest: "60s", time: null, weight: "5kg"),
        Sets(reps: "15", rest: "60s", time: null, weight: "5kg"),
      ],
    ),
  ),
];
final List<Workoutday> demoWorkoutDays = [
  Workoutday(
    id: 1,
    workoutId: 101,
    sequence: 1,
    isRest: 0,
    createdAt: "2025-12-10T08:00:00Z",
    updatedAt: "2025-12-10T08:10:00Z",
  ),
  Workoutday(
    id: 2,
    workoutId: 101,
    sequence: 2,
    isRest: 1, // This is a rest day
    createdAt: "2025-12-11T08:00:00Z",
    updatedAt: "2025-12-11T08:10:00Z",
  ),
];
