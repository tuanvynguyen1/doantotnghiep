<?php

namespace App\Http\Controllers;

use App\Models\Banner;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class BannerController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function add(Request $request){
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'expire' => ['required'],
            'image' => ['required', 'image']
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        $banner = time() . '_banner.' . $request->file('image')->extension();
        $bannerPath = $request->file('image')->storeAs('public/img/banner', $banner);


        Banner::create([
            'name' => $request->name,
            'expire' => $request->expire,
            'image' => str_replace('public','',$bannerPath)
        ]);
        return response()->json(['status' => 'Success',
            'msg' => 'Tạo banner thành công!'], );

    }
    public function remove(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => ['required']
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        $banner = Banner::where('id', $request->id)->first();
        if($banner == null ){
            return response()->json(['status' => 'Fail',
                'msg' => 'Không tìm thấy Banner'], );
        }
        $banner->update([
            'isDelete' => 1
        ]);
        $banner->save();
        return response()->json(['status' => 'Success',
            'msg' => 'Xóa thành công!'], );
    }

    public function getList(Request $request){
        $time = now();
        $banner = Banner::where('expire', '>', $time)->get();
        return response()->json([
            'status' => 'Success',
            'data' => $banner
        ] );
    }
}
