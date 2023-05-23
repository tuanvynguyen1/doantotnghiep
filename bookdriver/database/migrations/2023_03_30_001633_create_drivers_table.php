<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDriversTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('drivers', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('userID')->unsigned()->index()->nullable();
            $table->string('name');
            $table->string('email')->nullable();
            $table->string('avatar')->nullable();
            $table->string('phone');
            $table->string('address');
            $table->string('citizen_identity_card');
            $table->string('citizen_identity_card_img_front')->nullable();
            $table->string('citizen_identity_card_img_back')->nullable();
            $table->unsignedDouble('score')->default(100);
            $table->boolean('is_active')->default(false);
            $table->boolean('is_online')->default(false);
            $table->foreign('userID')->references('id')->on('users')->onDelete('cascade');
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
        Schema::dropIfExists('drivers');
    }
}
