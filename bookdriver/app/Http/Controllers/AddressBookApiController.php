<?php

namespace App\Http\Controllers;

use App\Models\AddressBook;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AddressBookApiController extends Controller
{
    public function getList(Request  $request){
        $user = $request->user();
        if($user == null || $user->userInfo == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        return response()->json($user->userInfo->addressBook->all());
    }

    public function insert(Request  $request){
        $validator = Validator::make($request->all(),[
            'name' => ['required', 'string', 'max:255'],
            'address' => ['required', 'string'],
            'lat' => ['required', 'string'],
            'long' => ['required', 'string']
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user == null || $user->userInfo == null){
            return response()->json(['error' => 'Tài khoản không tồn tại'], 400);
        }
        $user->userInfo->addressBook()->create([
            'name' => $request->name,
            'address' => $request->address,
            'lat' => $request->lat,
            'long' => $request->long
        ]);
        return response()->json(['status' => 'success', 'msg' => 'Thêm địa chỉ thành công!'], 200);

    }
}
