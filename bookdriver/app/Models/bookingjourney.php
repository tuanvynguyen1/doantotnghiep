<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class bookingjourney extends Model
{
    use HasFactory;

    protected $fillable = [
        'lat',
        'long',
        'status'
    ];
    public function booking(): BelongsTo
    {
        $this->belongsTo(booking::class, 'bookingID', 'id');
    }
}
