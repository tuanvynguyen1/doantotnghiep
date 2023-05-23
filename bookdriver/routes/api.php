<?php

use App\Http\Controllers\AddressBookApiController;
use App\Http\Controllers\BannerController;
use App\Http\Controllers\BookingApiController;
use App\Http\Controllers\DriverController;
use App\Http\Controllers\DriverLicenseController;
use App\Http\Controllers\TripApiController;
use App\Http\Controllers\UserApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\DriverApiController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Broadcast::routes(['middleware'=>'auth:sanctum']);
Route::get('users', function (Request $request) {
    return $request->user();
})->middleware(['auth:sanctum']);
Route::post('login', [AuthenticatedSessionController::class, 'applogin']);
Route::group(
  [
      'prefix' => 'driver',
      'middleware' => 'auth:sanctum'
  ],
    function(){
      Route::get('me', [DriverController::class, 'getDriver']);
      Route::post('upLoc', [DriverApiController::class,'upLocation']);
      Route::get('avatar', [DriverApiController::class, 'getAvatar']);
      Route::post('bookinglist', [DriverApiController::class, 'getBooking']);
      Route::post('logout', [DriverApiController::class , 'logout']);
      Route::post('pendingBook', [BookingApiController::class, 'waitBook']);
      Route::post('rejectRequest', [BookingApiController::class, 'rejectRequest']);
      Route::post('acceptRequest', [BookingApiController::class, 'acceptRequest']);
      Route::post('getListLicense', [DriverLicenseController::class ,'getListLicense']);
      Route::post('uploadLicense', [DriverLicenseController::class, 'upDriverLicense']);
      Route::post('updateTrip',[TripApiController::class, 'driverSendTripLocation']);
      Route::post('updateStatus', [TripApiController::class, 'setStatus']);
      Route::post('finishtrip', [TripApiController::class, 'finishTrip']);
    }

);

Route::group(
    [
        'prefix' => 'driver',
    ],
    function(){
        Route::post('register', [DriverApiController::class, 'regDriver']);
        Route::post('login', [DriverApiController::class, 'logDriver']);
    }
);
Route::group(
    [
        'prefix' => 'user'
    ],
    function(){
        Route::post('register', [UserApiController::class, 'regUser']);
        Route::post('login', [UserApiController::class, 'logUser']);
    }
);
Route::group(
    [
        'prefix' => 'user',
        'middleware' => 'auth:sanctum'
    ],
    function(){
        Route::post('me', [UserApiController::class, 'getUser']);
        Route::get('bannerList', [BannerController::class, 'getList']);
        Route::get('addressbook', [AddressBookApiController::class, 'getList']);
        Route::post('addressbook', [AddressBookApiController::class, 'insert']);
        Route::get('bookinglist', [BookingApiController::class, 'userGetList']);
        Route::post('addReview', [BookingApiController::class, 'addReview']);
        Route::post('book', [BookingApiController::class, 'booking']);
        Route::post('getprice', [BookingApiController::class, 'getPrice']);
        Route::post('isAccept', [BookingApiController::class, 'checkAcceptStatus']);
    }
);
