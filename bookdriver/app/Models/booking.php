<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class booking extends Model
{
    use HasFactory;
    protected $fillable = [
        'addressfrom',
        'latitudefrom',
        'longtitudefrom',
        'totaldistance',
        'cartype',
        'addressdes',
        'latitudedes',
        'longtitudedes'
    ];
    public function Driver(): BelongsTo
    {
        return $this->belongsTo(Driver::class, 'driverID', 'id');
    }
    public function UserInfo(): BelongsTo
    {
        return $this->belongsTo(UserInfo::class, 'user_infoID', 'id');
    }
    public function bookingjourney(): HasMany
    {
        return $this->hasMany(bookingjourney::class, 'bookingID', 'id');
    }
    public function RequestDriver(): HasMany
    {
        return $this->hasMany(RequestDriver::class, 'driverID', 'id');
    }
}
