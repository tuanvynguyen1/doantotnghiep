<?php

use App\Events\SendNotificationToDriver;
use App\Http\Controllers\BannerController;
use App\Http\Controllers\DriverLicenseController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\UserInfoController;
use App\Models\booking;
use App\Models\Driver;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use App\Http\Middleware\checkAdminLogin;
use App\Http\Controllers\DriverController;
use App\Http\Controllers\BookingController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('/bookdriver', function(){



});
Route::get('/', function () {
    return view('dashboard');
})->middleware(['auth'])->middleware(checkAdminLogin::class)->name('dashboard');
Route::group(
    [
        'prefix' => 'drivers',
        'middleware' => ['auth', 'auth.admin']
    ],function(){
        Route::get('/', [DriverController::class, 'listDriver']);
        Route::get('/pending', [DriverController::class, 'pendingDriver']);
        Route::get('/{id}',[DriverController::class, 'getDriverInfo']);
        Route::post('/update', [DriverController::class, 'updateDriverInfo']);
        Route::post('/switchStatus', [DriverController::class, 'switchStatus']);
        Route::post('/getLocation', [DriverController::class, 'getLocation']);
        Route::post('/acceptLicense', [DriverLicenseController::class, 'acceptLicense']);
        Route::post('/rejectLicense', [DriverLicenseController::class, 'rejectLicense']);

    }

);
Route::group(
    [
        'prefix' => 'user',
        'middleware' => ['auth', 'auth.admin']
    ],function(){
        Route::get('/', [UserInfoController::class, 'getAllUser']);
}
);
Route::group(
    [
        'prefix' => 'booking',
        'middleware' => ['auth', 'auth.admin']
    ],function(){
        Route::get('/', [BookingController::class, 'index']);
        Route::get('/route/{id}', [BookingController::class, 'routing']);
        Route::post('/getRouting', [BookingController::class, 'getRouting']);
    }
);
Route::group(
    [
        'prefix' => 'banner',
        'middleware' => ['auth', 'auth.admin']
    ],
    function(){
        Route::post('/add' ,[BannerController::class, 'add']);
        Route::post('/remove', [BannerController::class, 'remove']);
    }
);
Route::get('/driveronline', [DriverController::class, 'online']);
Route::get('/settings', [SettingController::class, 'settingView'])->middleware(['auth'])->middleware(checkAdminLogin::class)->name('Settings');
Route::get('/map', function(){
    return view('map');
})->middleware(['auth'])->middleware(checkAdminLogin::class)->name('MAP');

require __DIR__.'/auth.php';
