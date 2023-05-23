<?php

namespace App\Events;

use App\Events\SendNotificationToDriver;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class SendNotificationToDriverListener
{
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     *
     * @param  \App\Events\SendNotificationToDriver  $event
     * @return void
     */
    public function handle(SendNotificationToDriver $event)
    {
        //
    }
}
