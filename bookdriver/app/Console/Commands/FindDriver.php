<?php

namespace App\Console\Commands;

use App\Models\booking;
use App\Models\Driver;
use App\Models\RequestDriver;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class FindDriver extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'booking:findDriver';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Find driver for booking that under 5 minute and have not found the driver yet! Automatically close the booking that expired.';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    /**
     *
     *
     */
    public function handle()
    {
        $driver = Driver::all();
        foreach($driver as $d){
            $time = time();
            $updatedTime = $d['updated_at']->getTimestamp();
            if($time - 60*5 > $updatedTime) {
                $d['is_online'] = 0;
                $d->save();
            }
        }

        $time = time();
        $booking = booking::where('status', 0)->get();
        foreach($booking as $b){

            if($time - 60*5> $b['created_at']->getTimestamp()){
                $b['status'] = -1;
                $rq = $b->requestDriver()->where('status', 0)->first();
                if($rq != null){
                    $rq['status']=-1;
                    $rq->save();
                }
                $b->save();
            }
            else{
                $rq = $b->requestDriver()->where('status', 0)->first();
                if($rq == null){
                    $db = Driver::select('*')
                        ->selectRaw("id, score, (6371 *acos(cos(radians("+$b->latitudefrom+")) * cos (radians(lat)) * cos (radians(`long`) - radians ("+$b->longtitudefrom+")) + sin (radians("+$b->latitudefrom+")) * sin (radians(lat )))) as distance, status, is_online")
                        ->where("status", "=", 0)
                        ->where("is_online", "=", 1)
                        ->orderBy("score")
                        ->orderBy('distance')
                        ->get();
                    foreach($db as $item){
                        if($b->requestDriver()->where('driverID', $item->id)->first() == null){
                            RequestDriver::create([
                                'bookingID' => $b->id,
                                'driverID' => $item->id,
                                'status' => 0,
                            ]);
                            $item->status = 1;
                            $item->save();
                            break;
                        }
                    }


                }
            }

        }
    }
}
