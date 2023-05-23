<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Driver extends Model
{
    use HasFactory;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'avatar', 'phone','gender','dob', 'address', 'citizen_identity_card', 'citizen_identity_card_img_front', 'citizen_identity_card_img_back', 'is_active', 'is_online'
    ];
    public function User(): BelongsTo
    {
        return $this->belongsTo(User::class, 'userID', 'id');
    }
    public function booking(): HasMany
    {
        return $this->hasMany(booking::class, 'driverID', 'id');
    }
    public function DriverLicense(): HasMany
    {
        return $this->hasMany(DriverLicense::class, 'driverID', 'id');
    }
    public function RequestDriver(): HasMany
    {
        return $this->hasMany(RequestDriver::class, 'driverID', 'id');
    }
}
