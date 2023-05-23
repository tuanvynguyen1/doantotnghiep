<?php

namespace App\Http\Controllers;

use App\Models\bookingjourney;
use App\Models\RequestDriver;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TripApiController extends Controller
{
    public function driverSendTripLocation(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => ['required'],
            'lat' => ['required'],
            'lng' => ['required']
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user == null || $user->driver == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        $booking = $user->driver->booking()->where('id', $request->id)->first();
        if($booking == null){
            return response()->json(
                ['error' => 'Booking không được tìm thấy!']);
        }

        $booking->bookingjourney()->create([
            'long' => $request->lng,
            'lat' => $request->lat,
            'status' => $booking->status
        ]);

        return response()->json(
            [
                'status' =>'success',
                'step' => $booking->status
            ]
        );
    }
    public function setStatus(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => ['required'],
            'status' => ['required']
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user == null || $user->driver == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        $booking = $user->driver->booking()->where('id', $request->id)->first();
        if($booking == null){
            return response()->json(
                ['error' => 'Booking không được tìm thấy!']);
        }

        $booking->status = $request->status;
        $booking->save();
        return response()->json(
            ['msg' => 'Cập nhật thành công!']);
    }
    public function finishTrip(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => ['required']
        ]);

        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user == null || $user->driver == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        $booking = $user->driver->booking()->where('id', $request->id)->first();
        if($booking == null){
            return response()->json(
                ['error' => 'Booking không được tìm thấy!']);
        }
        $rD = RequestDriver::where('driverID', $user->driver->id)->where('bookingID', $request->id)->first();
        $rD->status = 2;
        $rD->save();
        $booking->update([
            'status' => 2,
            'endtime' => now()->toDateTimeString(),
            'paymentstatus' => 1,

        ]);
        $booking->status = 2;
        $booking->endtime  = now()->toDateTimeString();
        $booking->paymentstatus = 1;
        $booking->save();
        $user->driver->status = 0;
        $user->driver->save();
        return response()->json(
            ['msg' => 'Cập nhật thành công!']);
    }

}
