<?php

namespace App\Http\Controllers;

use App\Models\UserInfo;
use Illuminate\Http\Request;

class UserInfoController extends Controller
{
    public function getAllUser(){
        $user = UserInfo::orderByDesc('created_at')->withCount('Booking')->get();
//        dd($user);
        return view(
            'user',[
                'users' => $user
            ]
        );
    }
}
