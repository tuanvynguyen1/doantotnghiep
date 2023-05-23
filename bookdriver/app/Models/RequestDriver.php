<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class RequestDriver extends Model
{
    use HasFactory;

    protected $fillable = [
        'driverID', 'bookingID', 'status',
    ];

    public function Driver(): BelongsTo
    {
        return $this->belongsTo(Driver::class, 'driverID', 'id');
    }
    public function booking(): BelongsTo{
        return $this->belongsTo(booking::class, 'bookingID', 'id');
    }
}
