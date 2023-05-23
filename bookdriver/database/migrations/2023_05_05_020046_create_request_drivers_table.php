<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRequestDriversTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('request_drivers', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('driverID')->unsigned()->index();
            $table->bigInteger('bookingID')->unsigned()->index();
            $table->integer('status')->nullable();
            $table->foreign('driverID')->references('id')->on('drivers')->onDelete('cascade');
            $table->foreign('bookingID')->references('id')->on('bookings')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('request_drivers');
    }
}
