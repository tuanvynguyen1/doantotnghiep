<?php

namespace App\Http\Controllers;

use App\Models\booking;
use App\Models\bookingjourney;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class BookingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Contracts\View\View
     */
    public function index()
    {
        //
        $booking = booking::all();
        return view(
            'booking',[
                'booking' => $booking
            ]
        );
    }
    /**
     *Show list routing of Specific Booking ID
     * @param  \App\Models\booking  $id
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\View|\Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function routing(Request $request){

        $booking = Booking::where('id', $request->id)->first();
        if($booking == null){
            return redirect('/booking');
        }
        return view(
            'routing',[
                'bookInfo' => $booking
            ]
        );
    }

    public function getRouting(Request $request){

        $validator = Validator::make($request->all(), [
            'id' => ['required']
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        $journey = bookingjourney::where('bookingID', $request->id)->get();
        $booking = booking::where('id', $request->id)->first();
        return response()->json([
            'status' => 'Success',
            'data' => $journey,
            'isFinish' => $booking->status == 2
        ]);
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
     * @param  \App\Models\booking  $booking
     * @return \Illuminate\Http\Response
     */
    public function show(booking $booking)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\booking  $booking
     * @return \Illuminate\Http\Response
     */
    public function edit(booking $booking)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\booking  $booking
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, booking $booking)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\booking  $booking
     * @return \Illuminate\Http\Response
     */
    public function destroy(booking $booking)
    {
        //
    }
}
