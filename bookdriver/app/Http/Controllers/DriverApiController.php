<?php

namespace App\Http\Controllers;

use App\Models\Driver;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;


class DriverApiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Create a New Driver Profile
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function regDriver(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:drivers'],
            'dob' => ['required'],
            'gender' => ['required'],
            'phone' => ['required', 'unique:drivers', 'string', 'starts_with:0'],
            'address' => ['required', 'string'],
            'citizen_identity_card' => ['required', 'string', 'unique:drivers'],
            'password' => ['required', Rules\Password::defaults()],
            'frontCard' => ['required', 'image'],
            'backCard' => ['required', 'image']
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = User::where('email', $request->email)->first();
        $driver = Driver::where('email', $request->email)->first();
        if ($driver != null) {
            return response()->json(['Error' => 'Email đã tồn tại! Vui lòng thử Đặt lại mật khẩu!'], 400);
        }
        if ($user == null) {
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
            ]);
        }
        $backCardFileName = time() . '_' . $user->id . '_backCard_' . $request->file('backCard')->extension();
        $backCardPath = $request->file('backCard')->storeAs('public/img/idcard', $backCardFileName);
        $frontCardFileName = time() . '_' . $user->id . '_frontCard_' . $request->file('frontCard')->extension();
        $frontCardPath = $request->file('backCard')->storeAs('public/img/idcard', $frontCardFileName);
        $user->driver()->create([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'gender' => $request->gender,
            'dob' => $request->dob,
            'address' => $request->address,
            'citizen_identity_card' => $request->citizen_identity_card,
            'citizen_identity_card_img_front' => str_replace('public','',$frontCardPath),
            'citizen_identity_card_img_back' => str_replace('public','',$backCardPath)
        ]);

        return response()->json(['status' => 'Success', 'msg' => 'Tạo tài khoản thành công!'], 200);
    }


    public function updateDriver(Request $request){
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:drivers'],
            'dob' => ['required'],
            'avatar' => ['required', 'image'],
            'gender' => ['required'],
            'phone' => ['required', 'unique:drivers', 'string', 'size:10', 'starts_with:0'],
            'address' => ['required', 'string'],
            'citizen_identity_card' => ['required', 'string', 'unique:drivers'],
            'password' => ['required', Rules\Password::defaults()],
            'frontCard' => ['required', 'image'],
            'backCard' => ['required', 'image']
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = Auth()->user();
        if ($user->driver == null) {
            die(json_encode([
                'error' => 'Tài khoản không tồn tại'
            ]));
        }


    }
    /**
     * Login Driver then return Token.
     *
     * @param \Illuminate\Http\LoginRequest $request
     * @return \Illuminate\Http\JsonResponse
     * @throws ValidationException
     */
    public function logDriver(LoginRequest $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => ['required', 'string', 'email', 'max:255'],
            'password' => ['required', Rules\Password::defaults()],
            'device_name' => ['required', 'string']
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }
        $request->authenticate();
        $user = Auth()->user();
        if ($user->driver == null) {
            die(json_encode([
                'error' => 'Tài khoản không tồn tại'
            ]));
        }
        $token = $user->createToken("DRIVER_TOKEN_" . $user->email);
        $user->session()->create([
            'tokenID' => $token->accessToken->id,
            'device_name' => $request->device_name,
        ]);
        $isBike = $user->driver->driverLicense()->where('rank', 'A1')->where('status', '1')->first() != null ? true : false;
        $isCar = $user->driver->driverLicense()->where('rank', 'B2')->where('status', '1')->first() != null ? true : false;
        return response()->json([
            'status' => '200',
            'data' => [
                "name" => $user->driver->name,
                "email" => $user->driver->email,
                "dob" => $user->driver->dob,
                "gender" => $user->driver->gender,
                "avatar" => $user->driver->avatar,
                "phone" => $user->driver->phone,
                "address" => $user->driver->address,
                "citizen_identity_card" => $user->driver->citizen_identity_card,
                "citizen_identity_card_img_front" => $user->driver->citizen_identity_card_img_front,
                "citizen_identity_card_img_back" => $user->driver->citizen_identity_card_img_back,
                "score" => $user->driver->score,
                "is_active" => $user->driver->is_active,
                "lat" => $user->driver->lat,
                "long" => $user->driver->long,
                "status" => $user->driver->status,
                'isBike' => $isBike,
                'isCar' => $isCar
            ],
            'token' => $token->plainTextToken
        ]);
    }

    public function getBooking(Request $request)
    {
        $user = $request->user();
//        $booking = $user->driver->booking::all();
        json_encode($user->driver->booking->all());
    }

    public function upLocation(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'lat' => ['required'],
            'long' => ['required']
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if ($user->driver == null) {
            die(json_encode([
                'error' => 'Tài khoản không tồn tại'
            ]));
        }
        $user->driver->lat = $request->lat;
        $user->driver->long = $request->long;
        $user->driver->is_online = 1;
        $user->driver->save();
        return response()->json([
            'status' => '200',
            'message' => 'Update Location Success!'
        ]);
    }

    public function getAvatar(Request $request)
    {
        $user = $request->user();
        $path = storage_path('app/' . $user->driver->citizen_identity_card_img_front);
        return response()->file($path);
    }

    /**
     * Display the specified resource.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json([
            'status' => '200',
            'message' => 'Log out successful!'
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
