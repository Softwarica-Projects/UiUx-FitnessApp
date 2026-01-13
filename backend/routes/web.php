<?php

// Controllers
use App\Http\Controllers\HomeController;
use App\Http\Controllers\SettingController;

use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Artisan;
// Packages
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\EquipmentController;
use App\Http\Controllers\CategoryDietController;
use App\Http\Controllers\WorkoutTypeController;
use App\Http\Controllers\DietController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\LevelController;
use App\Http\Controllers\BodyPartController;
use App\Http\Controllers\ClassScheduleController;
use App\Http\Controllers\WorkoutController;
use App\Http\Controllers\ExerciseController;


use App\Http\Controllers\PushNotificationController;

use App\Http\Controllers\SubAdminController;

require __DIR__.'/auth.php';

Route::get('/storage', function () {
    Artisan::call('storage:link');
});

Route::get('optimize', function () {
    Artisan::call('optimize:clear');
});

use Illuminate\Support\Facades\Schema;
Route::get('migrate', function(){
    try {
        // check user table exist or not
        $schema = Schema::hasTable('users');
        Artisan::call('migrate', ['--force' => true]);
        if( !$schema ) {
            Artisan::call('db:seed', ['--force' => true]);
        }

        return redirect()->route('dashboard');
    } catch (\Exception $e) {
        return 'Migration failed: ' . $e->getMessage();
    }
});

Route::get('language/{locale}', [ HomeController::class, 'changeLanguage'])->name('change.language');

Route::group(['middleware' => [ 'auth', 'useractive' ]], function () {

    // Dashboard Routes
    Route::get('/', [HomeController::class, 'index']);
    Route::get('/dashboard', [HomeController::class, 'index'])->name('dashboard');
	Route::get('changeStatus', [ HomeController::class, 'changeStatus'])->name('changeStatus');

    // Users Module
    Route::resource('users', UserController::class);
    Route::resource('equipment', EquipmentController::class);

    Route::resource('subadmin', SubAdminController::class);

    Route::get('users-graph',[ UserController::class, 'fetchUserGraph' ])->name('user.fetchGraph');
    
    //assign deit
    Route::get('assigndiet/{user_id}',[ UserController::class, 'assignDietForm' ])->name('add.assigndiet');
    Route::post('assigndiet',[ UserController::class, 'assignDietSave' ])->name('save.assigndiet');
    Route::post('assigndiet-delete',[ UserController::class, 'assignDietDestroy' ])->name('delete.assigndiet');

    Route::get('assigndiet-list',[ UserController::class, 'getAssignDietList'])->name('get.assigndietlist');
    //assign workout
    Route::get('assignworkout/{user_id}',[ UserController::class, 'assignWorkoutForm' ])->name('add.assignworkout');
    Route::post('assignworkout',[ UserController::class, 'assignWorkoutSave' ])->name('save.assignworkout');
    Route::post('assignworkout-delete',[ UserController::class, 'assignWorkoutDestroy' ])->name('delete.assignworkout');

    Route::get('assignworkout-list',[ UserController::class, 'getAssignWorkoutList'])->name('get.assignworkoutlist');

    //Fitness CategoryDiet 
    Route::resource('categorydiet', CategoryDietController::class);
    
    //Fitness Workout 
    Route::resource('workouttype', WorkoutTypeController::class);

    Route::resource('diet', DietController::class);
    Route::resource('category', CategoryController::class);
    

    Route::resource('level', LevelController::class);

    Route::resource('bodypart', BodyPartController::class);

    Route::resource('exercise', ExerciseController::class);

    Route::resource('workout', WorkoutController::class);

    Route::post('workoutdays-exercise-delete', [ WorkoutController::class , 'workoutDaysExerciseDelete'])->name('workoutdays.exercise.delete');
    
    Route::post('remove-file',[ HomeController::class, 'removeFile' ])->name('remove.file');
    
    Route::get('setting/{page?}', [ SettingController::class, 'settings'])->name('setting.index');
    Route::post('layout-page', [ SettingController::class, 'layoutPage'])->name('layout_page');
    Route::post('settings/save', [ SettingController::class , 'settingsUpdates'])->name('settingsUpdates');
	Route::post('env-setting', [ SettingController::class , 'envChanges'])->name('envSetting');

    Route::post('update-profile', [ SettingController::class , 'updateProfile'])->name('updateProfile');
    Route::post('change-password', [ SettingController::class , 'changePassword'])->name('changePassword');

    Route::get('pages/term-condition',[ SettingController::class, 'termAndCondition'])->name('pages.term_condition');
    Route::post('term-condition-save',[ SettingController::class, 'saveTermAndCondition'])->name('pages.term_condition_save');

    Route::get('pages/privacy-policy',[ SettingController::class, 'privacyPolicy'])->name('pages.privacy_policy');
    Route::post('privacy-policy-save',[ SettingController::class, 'savePrivacyPolicy'])->name('pages.privacy_policy_save');

    Route::resource('pushnotification', PushNotificationController::class);
    Route::get('resend-pushnotification/{id}',[ PushNotificationController::class, 'edit'])->name('resend.pushnotification');

    Route::resource('classschedule', ClassScheduleController::class);
});

Route::get('/ajax-list',[ HomeController::class, 'getAjaxList' ])->name('ajax-list');


//Auth pages Routs
Route::group(['prefix' => 'auth'], function() {
    Route::get('signin', [HomeController::class, 'signin'])->name('auth.signin');
    Route::get('signup', [HomeController::class, 'signup'])->name('auth.signup');
    Route::get('confirmmail', [HomeController::class, 'confirmmail'])->name('auth.confirmmail');
    Route::get('lockscreen', [HomeController::class, 'lockscreen'])->name('auth.lockscreen');
    Route::get('recover-password', [HomeController::class, 'recoverpw'])->name('auth.recover-password');
    Route::get('userprivacysetting', [HomeController::class, 'userprivacysetting'])->name('auth.userprivacysetting');
});

//Error Page Route
Route::group(['prefix' => 'errors'], function() {
    Route::get('error404', [HomeController::class, 'error404'])->name('errors.error404');
    Route::get('error500', [HomeController::class, 'error500'])->name('errors.error500');
    Route::get('maintenance', [HomeController::class, 'maintenance'])->name('errors.maintenance');
});

//Extra Page Route
Route::get('privacy-policy', [HomeController::class, 'privacyPolicy'])->name('privacy.policy');
Route::get('terms-condition', [HomeController::class, 'termsCondition'])->name('terms.condition');
