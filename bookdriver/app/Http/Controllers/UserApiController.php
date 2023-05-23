<?php
namespace App\Http\Controllers;
use App\Models\User;
use App\Models\UserInfo;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;
class UserApiController extends Controller
{
    public function logUser(LoginRequest $request){
        $validator = Validator::make($request->all(),[
            'email' => ['required', 'string', 'email', 'max:255'],
            'password' => ['required', Rules\Password::defaults()],
            'device_name' => ['required', 'string']
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $request->authenticate();
        $user = Auth()->user();
        if($user->userInfo == null){
            die(json_encode([
                'error' => 'Tài khoản không tồn tại'
            ]));
        }
        $token = $user->createToken("USER_TOKEN_".$user->email);
        $user->session()->create([
            'tokenID' => $token->accessToken->id,
            'device_name' => $request->device_name,
        ]);
        return response()->json([
            'status' => '200',
            'data' => $user->userInfo->makeHidden(['id', 'userID']),
            'token' => $token->plainTextToken
        ]);
    }
    public function regUser(Request $request){

        $validator = Validator::make($request->all(),[
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:user_infos'],
            'phone' => ['required', 'unique:user_infos', 'string', 'size:10','starts_with:0'],
            'address' => ['required', 'string'],
            'password' => ['required', Rules\Password::defaults()],
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = User::where('email', $request->email)->first();
        $userInfo = UserInfo::where('email', $request->email)->first();
        if($userInfo != null){
            return response()->json(['Error' => 'Email đã tồn tại! Vui lòng thử Đặt lại mật khẩu!'], 400);
        }
        if($user == null){
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
            ]);
        }
        $user->userInfo()->create([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'address' => $request->address
        ]);

        return response()->json(['Success' => 'Create Account successful'], 200);
    }
    public function getUser(Request $request){
        $user = $request->user();
        if($user == null || $user->userInfo == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        return response()->json($user->userInfo->makeHidden(['id', 'userID']));
    }
}
