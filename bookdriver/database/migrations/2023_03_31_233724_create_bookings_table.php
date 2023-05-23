<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBookingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bookings', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('driverID')->unsigned()->index()->nullable();
            $table->bigInteger('user_infoID')->unsigned()->index()->nullable();
            $table->string('addressfrom');
            $table->string('latitudefrom');
            $table->string('longtitudefrom');
            $table->double('totaldistance');
            $table->integer('driverincome')->nullable();
            $table->integer('companyincome')->nullable();
            $table->timestamp('bookingtime')->nullable();
            $table->timestamp('driveracepttime')->nullable();
            $table->smallInteger('cartype');
            $table->double('rate')->nullable();
            $table->string('comment')->nullable();
            $table->timestamp('starttime')->nullable();
            $table->timestamp('endtime')->nullable();
            $table->boolean('paymentstatus')->default(false);
            $table->string('addressdes');
            $table->string('latitudedes');
            $table->string('longtitudedes');
            $table->timestamps();
            $table->foreign('driverID')->references('id')->on('drivers')->onDelete('cascade');
            $table->foreign('user_infoID')->references('id')->on('user_infos')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bookings');
    }
}
