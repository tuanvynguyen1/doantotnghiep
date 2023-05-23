<?php

namespace App\Http\Controllers;

use App\Models\DriverLicense;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DriverLicenseController extends Controller
{
    public function upDriverLicense(Request $request){
        $validator = Validator::make($request->all(),[
            'rank' => ['required'],
            'front' => ['required', 'image'],
            'back' => ['required', 'image']
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user->driver == null){
            die(json_encode([
                'error' => 'Tài khoản không tồn tại'
            ]));
        }
        $backCard = time() . '_' . $user->id . '_back_' . $request->file('back')->extension();
        $backCardPath = $request->file('back')->storeAs('public/img/license', $backCard);
        $frontCard = time() . '_' . $user->id . '_front_' . $request->file('front')->extension();
        $frontCardPath = $request->file('front')->storeAs('public/img/license', $frontCard);

        $user->driver->driverLicense()->create([
            'rank' => $request->rank,
            'front' => str_replace('public','',$frontCardPath),
            'back' => str_replace('public','',$backCardPath)
        ]);
        return response()->json([
            'status' => '200',
            'message' => 'Update Driver License Success!'
        ]);

    }
    public function acceptLicense(Request $request){
        $validator = Validator::make($request->all(),[
            'id' => ['required']
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }

        $license = DriverLicense::where('id', $request->id)->first();
        if($license == null){
            return response()->json(['error' => 'Not Found'], 400);
        }

        $license->status = 1;
        $license->save();
        return response()->json(['status' => 'Success',
            'msg' => 'Đã kích hoạt bằng lái thành công!']);
    }
    public function getListLicense(Request $request){
        $user = $request->user();
        if($user->driver == null){
            die(json_encode([
                'error' => 'Tài khoản không tồn tại'
            ]));
        }
        return response()->json([
            'status' => 'success',
            'data' => $user->driver->driverLicense()->get()
        ]);
    }
}
