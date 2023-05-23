<?php

namespace App\Http\Controllers;

use App\Models\booking;
use App\Models\Driver;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use function Nette\Utils\Callback;

class BookingApiController extends Controller
{
    public function userGetList(Request $request){
        $user = $request->user();
        if($user == null || $user->userInfo == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        return response()->json($user->userInfo->booking->all());
    }
    public function addReview(Request $request){

        $validator = Validator::make($request->all(),[
            'id' => ['required'],
            'star' => ['required', 'max:5' , 'min:0'],
            'review' => ['required', 'string']
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user == null || $user->userInfo == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        $booking = booking::Where('id', $request->id)->first();
        if($booking == null || $booking['user_infoID'] != $user->userInfo->id){
            return response()->json(
                ['error' => 'Booking ID không hợp lệ!']);
        }
         booking::where('id', $request->id)->update([
             'rate' => $request->star,
             'comment' => $request->review
         ]);
        $driver = Driver::find($booking['driverID']);
        $driver->score += ($request->star-3)*2;
        $driver->save();
        return response()->json(
            ['status' => 'Success',
                'msg' => 'Thêm đánh giá thành công!']);
    }

    function GetDrivingDistance($lat1, $lat2, $long1, $long2)
    {
        $url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=".$lat1.",".$long1."&destinations=".$lat2.",".$long2."&mode=driving&key=AIzaSyD3AV5OGMgvLNK7WB71ggNXEhVKcb1cd3Y";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_PROXYPORT, 3128);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        $response = curl_exec($ch);
        curl_close($ch);
        $response_a = json_decode($response, true);
        $dist = $response_a['rows'][0]['elements'][0]['distance']['value'];
        $time = $response_a['rows'][0]['elements'][0]['duration']['value'];
        $start = $response_a['destination_addresses'];
        $end = $response_a['origin_addresses'];
        return array('distance' => $dist, 'time' => $time, 'start' => $start, 'end' => $end);
    }
    public function getPrice(Request $request){
        $validator = Validator::make($request->all(), [
            'lat1' => ['required', 'string'],
            'long1' => ['required', 'string'],
            'lat2' => ['required', 'string'],
            'long2' => ['required', 'string'],
            'type' => ['required']
        ]);

//        $route = $this->GetDrivingDistance($request->lat1, $request->lat2, $request->long1, $request->long2);
        $long = random_int(1, 20);
        $total = 0;
        if($request->type == 1) {
//            $total = 300*$route['distance'];
            $totla = 300 * $long;
        }
        else{
//            $total = 500*$route['distance'];
            $totla = 500 * $long;
        }

        return response()->json(
            ['status' => 'Success',  'data' => $total]);
    }
    public function booking(Request $request){
        $validator = Validator::make($request->all(), [
            'latitudefrom' => ['required', 'string'],
            'longtitudefrom' => ['required', 'string'],
            'cartype' => ['required', 'numeric', 'min:0', 'max:1'],
            'latitudedes' => ['required', 'string'],
            'longtitudedes' => ['required', 'string']
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user == null || $user->userInfo == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        $lat1 = $request->latitudefrom;
        $lat2 = $request->latitudedes;
        $long1 = $request->longtitudefrom;
        $long2 = $request->longtitudedes;
        $result = $this->GetDrivingDistance($lat1, $lat2, $long1, $long2);
        $booking = $user->userInfo->booking()->create([
            'addressfrom' => $result['start'][0],
            'latitudefrom' => $lat1,
            'longtitudefrom' => $long1,
            'cartype' => $request->cartype,
            'totaldistance' => ($result['distance']/1000),
            'addressdes' => $result['end'][0],
            'latitudedes' => $lat2,
            'longtitudedes' => $long2
        ]);

        return response()->json(
            ['status' => 'Success', 'msg' => 'Đã đặt thành công booking.' , 'bookingID' => $booking['id']]);
    }
    public function checkAcceptStatus(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => ['required'],
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user == null || $user->userInfo == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        $booking = booking::Where('id', $request->id)->first();
        if($booking == null || $booking['user_infoID'] != $user->userInfo->id){
            return response()->json(
                ['error' => 'Booking ID không hợp lệ!'], 400);
        }

        if($booking['driverID'] == null) {
            return response()->json(
                ['status' => 'Not Yet']);
        }
        else{
            return response()->json(
                ['status' => 'Accepted']);
        }
    }
    public function rejectRequest(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => ['required'],
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user == null || $user->driver == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        $result = $user->driver->requestDriver()->where('id', $request->id)->first();
        if($result == null){
            return response()->json( ['status' => 'fail', 'msg' => 'Không có đơn nào.'
            ]);
        }
        $result->status = 2;
        $user->driver->score -= 2;
        $result->save();
        $user->driver->save();
        return response()->json( ['status' => 'success', 'msg' => 'Đã từ chối đơn.'
        ]);
    }
    public function acceptRequest(Request $request){
        $validator = Validator::make($request->all(), [
            'id' => ['required'],
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()], 400);
        }
        $user = $request->user();
        if($user == null || $user->driver == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        $result = $user->driver->requestDriver()->where('id', $request->id)->first();
        if($result == null){
            return response()->json( ['status' => 'fail', 'msg' => 'Không có đơn nào.'
            ]);
        }
        $result->update([
            'status' => 1
        ]);
        $result->booking()->update([
           'driverID' => $user->driver->id,
            'driveracepttime' => now()->toDateTimeString()
        ]);
        return response()->json( ['status' => 'success', 'msg' => 'Đã chấp nhận đơn.'
        ]);
    }
    public function waitBook(Request $request){
        $user = $request->user();
        if($user == null || $user->driver == null){
            return response()->json(
                ['error' => 'Hệt thời hạn! Vui lòng đăng nhập lại!']);
        }
        $result = $user->driver->requestDriver()->where('status', 1)->first();
        if($result!= null){
            return response()->json(
                ['status' => 'Rejoin', 'msg' => 'Về lại đơn trước đó!' , 'data' => [
                    'id' => $result->id,
                    'bookID' => $result->booking->id,
                    'add1' => $result->booking->addressfrom,
                    'lat1' => $result->booking->latitudefrom,
                    'lng1' => $result->booking->longtitudefrom,
                    'distance' => $result->booking->totaldistance,
                    'add2' => $result->booking->addressdes,
                    'lat2' => $result->booking->latitudedes,
                    'lng2' => $result->booking->longtitudedes,
                    'name' => $result->booking->userInfo->name,
                    'sdt' => $result->booking->userInfo->phone,
                    'status' => $result->booking->status
                ]]);
        }
        $result = $user->driver->requestDriver()->where('status', 0)->first();
        if($result == null){
            return response()->json( ['status' => 'fail', 'msg' => 'Không có đơn nào.'
            ]);
        }
        return response()->json(
            ['status' => 'Success', 'msg' => 'Có một đơn mới.' , 'data' => [
                'id' => $result->id,
                'bookID' => $result->booking->id,
                'add1' => $result->booking->addressfrom,
                'lat1' => $result->booking->latitudefrom,
                'lng1' => $result->booking->longtitudefrom,
                'distance' => $result->booking->totaldistance,
                'add2' => $result->booking->addressdes,
                'lat2' => $result->booking->latitudedes,
                'lng2' => $result->booking->longtitudedes,
                'name' => $result->booking->userInfo->name,
                'sdt' => $result->booking->userInfo->phone,
                'status' => $result->booking->status
            ]]);
    }

}
