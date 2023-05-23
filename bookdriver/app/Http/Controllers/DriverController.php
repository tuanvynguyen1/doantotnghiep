<?php

namespace App\Http\Controllers;

use App\Models\Driver;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;

class DriverController extends Controller
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

    public function online(){
        $driver = Driver::all();
        foreach($driver as $d){
            $time = time();
            $updatedTime = $d['updated_at']->getTimestamp();
            if($time - 60*5 > $updatedTime) {
                $d['is_online'] = 0;
                $d->save();
            }
        }
    }

    public function getLocation(){

        $driver = Driver::all(['id', 'is_online', 'status', 'phone', 'name', 'lat', 'long']);


        return response()->json(['status' => 'Success', 'data' => $driver], );

    }
    /**
     * Display a list of all Driver that current status is Active
     *
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function listDriver(){
        $driver = Driver::Where('is_active', true)->get();

        return view(
            'driver',[
                'drivers' => $driver,
                'isPending' => false
            ]
        );
    }

    /**
     * Display a list of all Driver that current status is DeActive
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function pendingDriver(){
        $driver = Driver::Where('is_active', false)->get();

        return view(
            'driver',[
                'drivers' => $driver,
                'isPending' => true
            ]
        );
    }

    public function getDriver(Request $request){
        $user = $request->user();
        if(isset($user->driver)){
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
            ]);
        }
        else{
            return json_encode([
                'msg' => 'ERROR'
            ]);
        }
    }

    public function updateDriverInfo(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => ['required'],
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255'],
            'dob' => ['required'],
            'gender' => ['required'],
            'phone' => ['required', 'string', 'size:10', 'starts_with:0'],
            'address' => ['required', 'string'],
            'citizen_identity_card' => ['required', 'string'],
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        $driver = Driver::where('id', $request->id)->first();
        if($driver == null){
            return response()->json([
                'error' => 'Không tìm thấy DriverID'
            ], 400);
        }
        $date = date_parse($request->dob);
        $newDate = date("Y-m-d", strtotime($request->dob));
        $driver->update([
            'id' => $request->id,
            'name' => $request->name,
            'email' => $request->email,
            'dob' => $newDate,
            'gender' => $request->gender,
            'phone' => $request->phone,
            'address' => $request->address,
            'citizen_identity_card' => $request->citizen_identity_card,
        ]);
        return response()->json(['msg' => 'Cập nhật thông tin thành công!']);
    }
    public function switchStatus(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => ['required']
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }
        $driver = Driver::where('id', $request->id)->first();
        if($driver == null){
            return response()->json([
                'error' => 'Không tìm thấy DriverID'
            ], 400);
        }
        $driver->update([
            'is_active' => $driver->is_active*(-1)+1
        ]);
        return response()->json(['msg' => 'Cập nhật thông tin thành công!']);

    }

    /**
     *  Display a Specific Documentary of one Driver Given by ID
     * @param  string $id
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function getDriverInfo(string $id){
//        $validator = Validator::make($request->all(), [
//            'id' => ['required', 'string']
//        ]);
//
//        if($validator->fails()){
//            return Redirect::to('404');
//        }

        $driver = Driver::findOrFail($id);

        return view(
            'driverinfo',[
                'driver' => $driver,
                'session' => $driver->user->session
            ]
        );

    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Driver  $driver
     * @return \Illuminate\Http\Response
     */
    public function show(Driver $driver)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Driver  $driver
     * @return \Illuminate\Http\Response
     */
    public function edit(Driver $driver)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Driver  $driver
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Driver $driver)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Driver  $driver
     * @return \Illuminate\Http\Response
     */
    public function destroy(Driver $driver)
    {
        //
    }
}
