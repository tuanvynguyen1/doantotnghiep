<?php

namespace App\Http\Controllers;

use App\Models\Banner;
use App\Models\Setting;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function settingView(){
        $banner = Banner::where('isDelete', 0)->orderBy('created_at')->get();
        return view(
            'settings',[
                'banner' => $banner
            ]
        );
    }
}
